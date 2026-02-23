import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/profile_controller.dart';
import '../../../auth/presentation/providers/auth_controller.dart';

class CompanyProfileScreen extends ConsumerStatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  ConsumerState<CompanyProfileScreen> createState() =>
      _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends ConsumerState<CompanyProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for company profile fields
  final _businessNameController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _taxIdController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController(); // Read-only

  // Image handling (Reusing profile image as Company Logo for now)
  File? _selectedImage;
  Uint8List? _imageBytes; // for web
  String? _profileImageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Load profile data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileControllerProvider.notifier).loadProfile();
    });
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _businessAddressController.dispose();
    _taxIdController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          setState(() {
            _imageBytes = bytes;
            _selectedImage = null;
          });
        } else {
          setState(() {
            _selectedImage = File(image.path);
            _imageBytes = null;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _loadProfileData(Map<String, dynamic>? profile) {
    if (profile == null || !mounted) return;

    // Update text controllers with profile data
    _businessNameController.text =
        profile['businessName'] ?? profile['companyName'] ?? '';
    _businessAddressController.text = profile['businessAddress'] ?? '';
    _taxIdController.text = profile['taxId'] ?? '';
    _phoneController.text = profile['phone'] ?? '';
    _emailController.text = profile['email'] ?? '';

    // Update profile image URL (Logo)
    _profileImageUrl = profile['profileImage'] ?? profile['imageUrl'];
    // Force rebuild only if not already rebuilding (safety check, though ref.listen runs post-build usually)
    setState(() {});
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      // Prepare profile data
      final profileData = {
        'businessName': _businessNameController.text,
        'businessAddress': _businessAddressController.text,
        'taxId': _taxIdController.text,
        'phone': _phoneController.text,
        // Email is read-only, not sending it for update to avoid accidental change checks
      };

      final success = await ref
          .read(profileControllerProvider.notifier)
          .updateProfile(profileData, imageFile: _selectedImage);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Company Profile updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
          // Clear selected image after successful save
          setState(() {
            _selectedImage = null;
            _imageBytes = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                ref.read(profileControllerProvider).errorMessage ??
                    'Failed to update profile',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen for profile changes to update local state
    ref.listen<ProfileState>(profileControllerProvider, (previous, next) {
      if (next.profile != null && next.profile != previous?.profile) {
        _loadProfileData(next.profile);
      }
    });

    final authState = ref.watch(authControllerProvider);
    final isEditable = authState.user?.isAdmin ?? false;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profile",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Company Profile",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Company Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(
                            Icons.business,
                            "Company Information",
                          ),
                          const SizedBox(height: 20),

                          // Logo Upload Section
                          if (isEditable)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: _imageBytes != null
                                      ? Image.memory(
                                          _imageBytes!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : _selectedImage != null
                                      ? Image.file(
                                          _selectedImage!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : _profileImageUrl != null
                                      ? Image.network(
                                          _profileImageUrl!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  width: 100,
                                                  height: 100,
                                                  color: Colors.grey.shade300,
                                                  child: const Icon(
                                                    Icons.business,
                                                    size: 50,
                                                    color: Colors.grey,
                                                  ),
                                                );
                                              },
                                        )
                                      : Container(
                                          width: 100,
                                          height: 100,
                                          color: Colors.grey.shade300,
                                          child: const Icon(
                                            Icons.business,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: _pickImage,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.orange.shade400,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        ),
                                        child: const Text("Upload Logo"),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        "Upload logo below 2 MB, JPG/PNG",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          else
                            // Read-only logo view
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: _profileImageUrl != null
                                      ? Image.network(
                                          _profileImageUrl!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  width: 100,
                                                  height: 100,
                                                  color: Colors.grey.shade300,
                                                  child: const Icon(
                                                    Icons.business,
                                                    size: 50,
                                                    color: Colors.grey,
                                                  ),
                                                );
                                              },
                                        )
                                      : Container(
                                          width: 100,
                                          height: 100,
                                          color: Colors.grey.shade300,
                                          child: const Icon(
                                            Icons.business,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 32),

                          // Responsive Form Layout
                          LayoutBuilder(
                            builder: (context, constraints) {
                              bool useSingleColumn = constraints.maxWidth < 600;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Company Name and Tax ID
                                  useSingleColumn
                                      ? Column(
                                          children: [
                                            _buildField(
                                              "Company Name *",
                                              _businessNameController,
                                              readOnly: !isEditable,
                                            ),
                                            const SizedBox(height: 20),
                                            _buildField(
                                              "Tax ID / GSTIN",
                                              _taxIdController,
                                              readOnly: !isEditable,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: _buildField(
                                                "Company Name *",
                                                _businessNameController,
                                                readOnly: !isEditable,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: _buildField(
                                                "Tax ID / GSTIN",
                                                _taxIdController,
                                                readOnly: !isEditable,
                                              ),
                                            ),
                                          ],
                                        ),
                                  const SizedBox(height: 20),

                                  // Business Address (Always full width)
                                  _buildField(
                                    "Business Address",
                                    _businessAddressController,
                                    readOnly: !isEditable,
                                  ),
                                  const SizedBox(height: 20),

                                  // Phone and Email
                                  useSingleColumn
                                      ? Column(
                                          children: [
                                            _buildField(
                                              "Phone Number",
                                              _phoneController,
                                              readOnly: !isEditable,
                                            ),
                                            const SizedBox(height: 20),
                                            _buildField(
                                              "Email (Read Only)",
                                              _emailController,
                                              readOnly: true,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: _buildField(
                                                "Phone Number",
                                                _phoneController,
                                                readOnly: !isEditable,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: _buildField(
                                                "Email (Read Only)",
                                                _emailController,
                                                readOnly: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 32),
                          // Action Buttons
                          if (isEditable)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Reload to cancel
                                    ref
                                        .read(
                                          profileControllerProvider.notifier,
                                        )
                                        .loadProfile();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0F172A),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: const Text("Cancel"),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: _saveProfile,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange.shade400,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: const Text("Save Changes"),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.orange.shade400),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          readOnly: readOnly,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            filled: readOnly,
            fillColor: readOnly ? Colors.grey.shade100 : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            suffixIcon: isPassword
                ? const Icon(Icons.visibility_off_outlined, size: 20)
                : null,
          ),
        ),
      ],
    );
  }
}
