import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/widgets/product_image.dart';
import 'package:ezo/core/di/service_locator.dart';
import 'package:ezo/core/models/category.dart';
import 'package:ezo/core/models/brand.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      backgroundColor: PosColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // 1. HEADER
            PosPageHeader(
              title: "Product Details",
              subTitle: product.name,
              onBack: () => context.pop(),
            ),
            const SizedBox(height: 24),

            // 2. MAIN CONTENT
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LEFT COLUMN (Main Info)
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // BASIC INFO CARD
                      PosContentCard(
                        title: "Basic Information",
                        child: Column(
                          children: [
                            _buildDetailRow("Product Name", product.name),
                            _buildDetailRow("SKU", product.sku ?? "-"),
                            FutureBuilder<Category?>(
                              future: ServiceLocator.instance.categoryRepository.getCategoryById(product.categoryId ?? -1),
                              builder: (context, snapshot) {
                                return _buildDetailRow("Category", snapshot.data?.name ?? "-");
                              },
                            ),
                            FutureBuilder<Brand?>(
                              future: ServiceLocator.instance.brandRepository.getBrandById(product.brandId ?? -1),
                              builder: (context, snapshot) {
                                return _buildDetailRow("Brand", snapshot.data?.name ?? "-");
                              },
                            ),
                            _buildDetailRow("GST Type", product.gstType ?? "-"),
                            _buildDetailRow("GST Rate", product.gstRate ?? "-"),
                            _buildStatusRow("Status", product.isActive),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // DESCRIPTION CARD
                      if (product.description != null && product.description!.isNotEmpty) ...[
                        PosContentCard(
                          title: "Description",
                          child: Text(
                            product.description!,
                            style: const TextStyle(
                              color: PosColors.textMain,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // SYSTEM INFO CARD
                      PosContentCard(
                        title: "System Information",
                        child: Column(
                          children: [
                            _buildDetailRow("UUID", product.uuid),
                            _buildDetailRow("Created At", product.createdAt.toString().split('.')[0]),
                            _buildDetailRow("Last Updated", product.updatedAt.toString().split('.')[0]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),

                // RIGHT COLUMN (Pricing & Image)
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      // PRODUCT IMAGE CARD
                      PosContentCard(
                        title: "Product Image",
                        child: Center(
                          child: ProductImage(product: product, size: 200, borderRadius: 12),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // PRICING CARD
                      PosContentCard(
                        title: "Pricing & Inventory",
                        child: Column(
                          children: [
                            _buildPriceRow("Sales Price", product.price),
                            _buildPriceRow("Cost Price", product.cost),
                            const Divider(height: 24, color: PosColors.border),
                            _buildStockRow("Stock Quantity", product.stockQuantity),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ACTIONS CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: PosColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Actions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: PosColors.textMain)),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Navigate to Edit Mode
                                  context.push('/inventory/add', extra: product);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF9F43), // Orange
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                icon: const Icon(Icons.edit, size: 18),
                                label: const Text("Edit Product"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(color: PosColors.textLight, fontSize: 13, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: const TextStyle(color: PosColors.textMain, fontSize: 14, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double? price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: PosColors.textLight, fontSize: 14)),
          Text(
            "\$${(price ?? 0.0).toStringAsFixed(2)}",
            style: const TextStyle(color: PosColors.textMain, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

    Widget _buildStockRow(String label, int? qty) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: PosColors.textLight, fontSize: 14)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: (qty ?? 0) > 0 ? Colors.green.shade50 : Colors.red.shade50,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "${qty ?? 0} Units",
            style: TextStyle(
              color: (qty ?? 0) > 0 ? Colors.green.shade700 : Colors.red.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 13
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 2,
            child: Text("Status", style: TextStyle(color: PosColors.textLight, fontSize: 13, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                Text(isActive ? "Active" : "Inactive", style: const TextStyle(color: PosColors.textMain, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
