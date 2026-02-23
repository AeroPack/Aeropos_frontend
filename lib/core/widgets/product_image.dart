import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezo/core/database/app_database.dart'; 

class ProductImage extends StatelessWidget {
  final ProductEntity product;
  final double size;
  final double borderRadius;

  const ProductImage({
    super.key,
    required this.product,
    this.size = 80,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    Widget image;

    // 1. If we have a local path and the file exists, show local image
    if (!kIsWeb && product.localPath != null && product.localPath!.isNotEmpty) {
      final file = File(product.localPath!);
      if (file.existsSync()) {
        image = Image.file(
          file,
          fit: BoxFit.cover,
          width: size,
          height: size,
        );
      } else {
        image = _buildFallback();
      }
    } 
    // 1b. Web support for local path (blob URLs)
    else if (kIsWeb && product.localPath != null && product.localPath!.isNotEmpty) {
      image = Image.network(
        product.localPath!,
        fit: BoxFit.cover,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
      );
    }
    // 2. If no local path but we have a URL, show network image
    else if (product.imageUrl != null && product.imageUrl!.isNotEmpty) {
      image = CachedNetworkImage(
        imageUrl: product.imageUrl!,
        fit: BoxFit.cover,
        width: size,
        height: size,
        placeholder: (context, url) => Container(
          width: size,
          height: size,
          color: Colors.grey.shade100,
          child: const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
        errorWidget: (context, url, error) => _buildFallback(),
      );
    } 
    // 3. Fallback
    else {
      image = _buildFallback();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: image,
    );
  }

  Widget _buildFallback() {
    return Container(
      width: size,
      height: size,
      color: Colors.grey.shade100,
      child: Icon(
        Icons.inventory_2_outlined,
        color: Colors.grey.shade400,
        size: size * 0.5,
      ),
    );
  }
}
