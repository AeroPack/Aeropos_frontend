import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/widgets/pos_data_form.dart';
import 'package:ezo/core/widgets/pos_toast.dart';
import 'package:ezo/core/di/service_locator.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:ezo/core/viewModel/product_view_model.dart';
import 'package:ezo/core/models/category.dart';
import 'package:ezo/core/models/unit.dart';
import 'package:ezo/core/models/brand.dart';
import 'package:drift/drift.dart' as drift;
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class AddItemScreen extends StatefulWidget {
  final ProductEntity? product;

  const AddItemScreen({super.key, this.product});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _priceController = TextEditingController();
  final _costController = TextEditingController();
  // Removed _stockController - quantity field removed from form
  final _descController = TextEditingController();
  final _discountController = TextEditingController(text: '0.0');
  bool _isPercentDiscount = false;

  int? _selectedCategoryId;
  int? _selectedUnitId;
  int? _selectedBrandId;
  String? _selectedGstType;
  String? _selectedGstRate;
  bool _isLoading = false;
  static const List<String> _gstRates = ['0%', '5%', '12%', '18%', '28%'];
  static const List<String> _gstTypes = ['Inclusive', 'Exclusive'];

  final _imagePicker = ImagePicker();
  XFile? _selectedImageFile;
  Uint8List? _selectedImageBytes; // for web preview
  String? _currentLocalPath;
  String? _imageUrl;

  late final ProductViewModel _viewModel =
      ServiceLocator.instance.productViewModel;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      final p = widget.product!;
      _nameController.text = p.name;
      _skuController.text = p.sku ?? '';
      _priceController.text = p.price.toString();
      _costController.text = p.cost?.toString() ?? '';
      // Removed stockController initialization
      _descController.text = '';
      _selectedBrandId = p.brandId;
      _selectedCategoryId = p.categoryId;
      _selectedUnitId = p.unitId;
      _selectedGstType = p.gstType;
      _selectedGstRate = p.gstRate;
      _currentLocalPath = p.localPath;
      // Pre-load existing imageUrl (includes Base64 data URIs saved on web)
      _imageUrl = p.imageUrl;
      _discountController.text = p.discount.toString();
      _isPercentDiscount = p.isPercentDiscount;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _priceController.dispose();
    _costController.dispose();
    // Removed stockController disposal
    _descController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty) {
      PosToast.showError(context, "Name and Price are required");
      return;
    }

    if (_selectedCategoryId == null) {
      PosToast.showError(context, "Category is required");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Check SKU uniqueness
      final sku = _skuController.text;
      if (sku.isNotEmpty) {
        final isSkuUnique = await _viewModel.isSkuUnique(
          sku,
          excludeId: widget.product?.id,
        );
        if (!isSkuUnique) {
          setState(() => _isLoading = false);
          PosToast.showError(
            context,
            "SKU already exists. Please use a unique SKU.",
          );
          return;
        }
      }

      // Check Name uniqueness
      final name = _nameController.text;
      final isNameUnique = await _viewModel.isNameUnique(
        name,
        excludeId: widget.product?.id,
      );
      if (!isNameUnique) {
        setState(() => _isLoading = false);
        PosToast.showError(
          context,
          "Product Color or Name already exists. Please use a unique name.",
        );
        return;
      }
      String? localPathToSave = _currentLocalPath;
      String? imageUrlToSave =
          _imageUrl; // preserve existing imageUrl by default

      if (kIsWeb) {
        // On web: File/path_provider are not available.
        // Convert the picked image bytes to a Base64 data URI and store in imageUrl.
        if (_selectedImageBytes != null) {
          final base64Str = base64Encode(_selectedImageBytes!);
          imageUrlToSave = 'data:image/jpeg;base64,$base64Str';
          localPathToSave = null; // Not applicable on web
        }
        // If URL was entered directly, imageUrlToSave already holds the URL
      } else {
        // On native: download URL to file if needed, then copy/compress
        if (_imageUrl != null && _selectedImageFile == null) {
          try {
            final response = await http.get(Uri.parse(_imageUrl!));
            if (response.statusCode == 200) {
              final tempDir = await getApplicationDocumentsDirectory();
              final fileName =
                  'product_${DateTime.now().millisecondsSinceEpoch}.jpg';
              final tempPath = path.join(tempDir.path, fileName);
              final tempFile = File(tempPath);
              await tempFile.writeAsBytes(response.bodyBytes);
              _selectedImageFile = XFile(tempPath);
            } else {
              throw Exception(
                'Failed to download image: ${response.statusCode}',
              );
            }
          } catch (e) {
            if (mounted) {
              PosToast.showError(
                context,
                "Failed to download image from URL: $e",
              );
              setState(() => _isLoading = false);
              return;
            }
          }
        }

        if (_selectedImageFile != null) {
          final appDir = await getApplicationDocumentsDirectory();
          final fileName =
              'product_${DateTime.now().millisecondsSinceEpoch}.jpg';
          final targetPath = path.join(appDir.path, fileName);

          if (Platform.isAndroid || Platform.isIOS) {
            try {
              final result = await FlutterImageCompress.compressAndGetFile(
                _selectedImageFile!.path,
                targetPath,
                quality: 80,
                format: CompressFormat.jpeg,
              );
              if (result != null) {
                localPathToSave = result.path;
              } else {
                final savedImage = await File(
                  _selectedImageFile!.path,
                ).copy(targetPath);
                localPathToSave = savedImage.path;
              }
            } catch (e) {
              print("Compression failed: $e");
              final savedImage = await File(
                _selectedImageFile!.path,
              ).copy(targetPath);
              localPathToSave = savedImage.path;
            }
          } else {
            final savedImage = await File(
              _selectedImageFile!.path,
            ).copy(targetPath);
            localPathToSave = savedImage.path;
          }
        }
      }

      double price = double.tryParse(_priceController.text) ?? 0.0;
      double discount = double.tryParse(_discountController.text) ?? 0.0;

      if (_isPercentDiscount) {
        if (discount > 100) discount = 100;
      } else {
        if (discount > price) discount = price;
      }
      if (discount < 0) discount = 0;

      if (widget.product == null) {
        await _viewModel.addProduct(
          name: _nameController.text,
          sku: _skuController.text,
          price: price,
          cost: double.tryParse(_costController.text) ?? 0.0,
          stockQuantity: 0.0, // Default to 0
          categoryId: _selectedCategoryId,
          unitId: _selectedUnitId,
          brandId: _selectedBrandId,
          gstType: _selectedGstType,
          gstRate: _selectedGstRate,
          description: _descController.text,
          localPath: localPathToSave,
          imageUrl: imageUrlToSave,
          discount: discount,
          isPercentDiscount: _isPercentDiscount,
        );
      } else {
        final updatedProduct = widget.product!.copyWith(
          name: _nameController.text,
          sku: drift.Value(
            _skuController.text == '' ? null : _skuController.text,
          ),
          price: double.tryParse(_priceController.text) ?? 0.0,
          cost: drift.Value(double.tryParse(_costController.text)),
          // Keep existing stockQuantity, don't update it
          categoryId: drift.Value(_selectedCategoryId),
          unitId: drift.Value(_selectedUnitId),
          brandId: drift.Value(_selectedBrandId),
          syncStatus: 1,
          gstType: drift.Value(_selectedGstType),
          gstRate: drift.Value(_selectedGstRate),
          description: drift.Value(_descController.text),
          localPath: drift.Value(localPathToSave),
          imageUrl: drift.Value(imageUrlToSave),
          discount: discount,
          isPercentDiscount: _isPercentDiscount,
          updatedAt: DateTime.now(),
        );
        await _viewModel.updateProduct(updatedProduct);
      }

      if (mounted) {
        PosToast.showSuccess(
          context,
          widget.product == null
              ? 'Product Added Successfully'
              : 'Product Updated Successfully',
        );
        // Wait a moment for the toast to show before navigating
        await Future.delayed(const Duration(milliseconds: 500));

        if (mounted) {
          if (widget.product == null) {
            // After adding a new product, clear form and navigate to product list
            _clearForm();
            context.go('/inventory');
          } else {
            // After updating, just go back
            if (context.canPop()) {
              context.pop();
            }
          }
        }
      }
    } catch (e) {
      if (mounted) {
        PosToast.showError(context, "Error: ${e.toString()}");
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _clearForm() {
    _nameController.clear();
    _skuController.clear();
    _priceController.clear();
    _costController.clear();
    _descController.clear();
    _discountController.text = '0.0';
    setState(() {
      _selectedCategoryId = null;
      _selectedUnitId = null;
      _selectedBrandId = null;
      _selectedGstType = null;
      _selectedGstRate = null;
      _selectedImageFile = null;
      _selectedImageBytes = null;
      _imageUrl = null;
      _currentLocalPath = null;
      _isPercentDiscount = false;
    });
  }

  void _generateSku() async {
    // Only generate if SKU field is empty
    if (_skuController.text.isNotEmpty) {
      if (mounted) {
        PosToast.showInfo(
          context,
          "SKU already generated. Clear the field to generate a new one.",
        );
      }
      return;
    }

    try {
      final sku = await _viewModel.generateNextSku();
      setState(() {
        _skuController.text = sku;
      });
    } catch (e) {
      if (mounted) {
        PosToast.showError(context, "Error generating SKU: ${e.toString()}");
      }
    }
  }

  /// Builds an image widget from a URL string.
  /// Handles both Base64 data URIs (saved on web) and regular http/https URLs.
  Widget _buildImageFromUrl(String url) {
    if (url.startsWith('data:')) {
      // Base64 data URI — decode and display with Image.memory
      try {
        final commaIndex = url.indexOf(',');
        if (commaIndex != -1) {
          final base64Str = url.substring(commaIndex + 1);
          final bytes = base64Decode(base64Str);
          return Image.memory(bytes, fit: BoxFit.cover);
        }
      } catch (_) {}
      return const Icon(Icons.broken_image, color: Colors.red);
    }
    // Regular HTTP/HTTPS URL
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error_outline, color: Colors.red)),
    );
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Image Source',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(
                Icons.camera_alt,
                color: PosColors.blue,
                size: 28,
              ),
              title: const Text('Camera'),
              subtitle: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(context);
                _pickFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: PosColors.blue,
                size: 28,
              ),
              title: const Text('Gallery'),
              subtitle: const Text('Choose from device'),
              onTap: () {
                Navigator.pop(context);
                _pickFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.link, color: PosColors.blue, size: 28),
              title: const Text('From URL'),
              subtitle: const Text('Enter image URL'),
              onTap: () {
                Navigator.pop(context);
                _pickFromUrl();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFromCamera() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        setState(() {
          _selectedImageFile = image;
          _selectedImageBytes = bytes;
          _imageUrl = null;
        });
      } else {
        setState(() {
          _selectedImageFile = image;
          _selectedImageBytes = null;
          _imageUrl = null;
        });
      }
    }
  }

  Future<void> _pickFromGallery() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        setState(() {
          _selectedImageFile = image;
          _selectedImageBytes = bytes;
          _imageUrl = null;
        });
      } else {
        setState(() {
          _selectedImageFile = image;
          _selectedImageBytes = null;
          _imageUrl = null;
        });
      }
    }
  }

  Future<void> _pickFromUrl() async {
    final urlController = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Image URL'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                hintText: 'https://example.com/image.jpg',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 8),
            Text(
              'Enter a valid image URL',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final url = urlController.text.trim();
              if (url.isNotEmpty) {
                Navigator.pop(context, url);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _imageUrl = result;
        _selectedImageFile = null; // Clear file if URL is used
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
      stream: _viewModel.allCategories,
      builder: (context, categorySnapshot) {
        final categories = categorySnapshot.data ?? [];

        return StreamBuilder<List<Unit>>(
          stream: _viewModel.allUnits,
          builder: (context, unitSnapshot) {
            final units = unitSnapshot.data ?? [];

            return StreamBuilder<List<Brand>>(
              stream: _viewModel.allBrands,
              builder: (context, brandSnapshot) {
                final brands = brandSnapshot.data ?? [];

                return PosDataForm(
                  title: widget.product == null
                      ? "Add New Product"
                      : "Edit Product",
                  subTitle: widget.product == null
                      ? "Create new item in inventory"
                      : "Update existing product details",
                  formTitle: "Product Information",
                  submitLabel: widget.product == null
                      ? "Create Product"
                      : "Update Product",
                  isLoading: _isLoading,
                  onBack: () => context.pop(),
                  onSubmit: _handleSubmit,

                  fields: [
                    PosTextInput(
                      label: "Product Name",
                      isRequired: true,
                      controller: _nameController,
                      placeholder: "e.g. Wireless Mouse",
                    ),
                    PosTextInput(
                      label: "SKU / Barcode",
                      isRequired: true,
                      controller: _skuController,
                      placeholder: "Scan or generate",
                      suffix: Container(
                        margin: const EdgeInsets.all(4),
                        child: ElevatedButton(
                          onPressed: _generateSku,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade100,
                            foregroundColor: Colors.orange.shade900,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          child: const Text(
                            "Generate",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),

                    // CATEGORY DROPDOWN (Real Data)
                    PosDropdown<int>(
                      label: "Category",
                      isRequired: true,
                      value: _selectedCategoryId,
                      hint: "Select Category",
                      items: (categories)
                          .map(
                            (c) => DropdownMenuItem(
                              value: c.id,
                              child: Text(c.name),
                            ),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedCategoryId = val),
                    ),

                    PosDropdown<int>(
                      label: "Brand",
                      value: _selectedBrandId,
                      hint: "Select Brand",
                      items: brands
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.id,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedBrandId = val),
                    ),
                    PosTextInput(
                      label: "Sale Rate (\$)",
                      isRequired: true,
                      controller: _priceController,
                      placeholder: "0.00",
                    ),
                    PosTextInput(
                      label: "Purchase Rate (\$)",
                      isRequired: false,
                      controller: _costController,
                      placeholder: "0.00",
                    ),

                    // UNIT DROPDOWN (Real Data)
                    PosDropdown<int>(
                      label: "Unit",
                      value: _selectedUnitId,
                      hint: "Select Unit",
                      items: units
                          .map(
                            (u) => DropdownMenuItem(
                              value: u.id,
                              child: Text(u.name),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _selectedUnitId = val),
                    ),
                    PosDropdown<String>(
                      label: "Gst Type",
                      value: _selectedGstType,
                      items: _gstTypes
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedGstType = val),
                    ),
                    PosDropdown<String>(
                      label: "Gst Rate",
                      value: _selectedGstRate,
                      items: (_gstRates)
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedGstRate = val),
                    ),
                    PosTextInput(
                      label: "Default Discount",
                      controller: _discountController,
                      placeholder: "0.00",
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () =>
                                setState(() => _isPercentDiscount = false),
                            style: TextButton.styleFrom(
                              backgroundColor: !_isPercentDiscount
                                  ? PosColors.blue.withOpacity(0.1)
                                  : null,
                              foregroundColor: !_isPercentDiscount
                                  ? PosColors.blue
                                  : Colors.grey,
                            ),
                            child: const Text("Rs"),
                          ),
                          TextButton(
                            onPressed: () =>
                                setState(() => _isPercentDiscount = true),
                            style: TextButton.styleFrom(
                              backgroundColor: _isPercentDiscount
                                  ? PosColors.blue.withOpacity(0.1)
                                  : null,
                              foregroundColor: _isPercentDiscount
                                  ? PosColors.blue
                                  : Colors.grey,
                            ),
                            child: const Text("%"),
                          ),
                        ],
                      ),
                    ),
                  ],

                  extraSections: [
                    PosContentCard(
                      title: "Product Image",
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          // Show existing image as square thumbnail
                          if (_selectedImageFile != null ||
                              _imageUrl != null ||
                              _currentLocalPath != null)
                            Stack(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: PosColors.border),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade50,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: _selectedImageFile != null
                                        ? (_selectedImageBytes != null
                                              ? Image.memory(
                                                  _selectedImageBytes!,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  File(
                                                    _selectedImageFile!.path,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ))
                                        : _imageUrl != null
                                        ? _buildImageFromUrl(_imageUrl!)
                                        : _currentLocalPath != null
                                        ? (kIsWeb
                                              ? Image.network(
                                                  _currentLocalPath!,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  File(_currentLocalPath!),
                                                  fit: BoxFit.cover,
                                                ))
                                        : const SizedBox(),
                                  ),
                                ),
                                // Remove button
                                Positioned(
                                  top: -4,
                                  right: -4,
                                  child: IconButton(
                                    icon: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedImageFile = null;
                                        _selectedImageBytes = null;
                                        _imageUrl = null;
                                        _currentLocalPath = null;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          // Add image button
                          InkWell(
                            onTap: _showImageSourceOptions,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: PosColors.border,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade50,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    size: 32,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Add Image",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    PosContentCard(
                      title: "Description",
                      child: TextField(
                        controller: _descController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Enter detailed product description...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: PosColors.border,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: PosColors.border,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
