import 'package:flutter/material.dart';
import 'package:product/model/product.dart';

import 'product_card.dart';
class HorizontalProductList extends StatelessWidget {
  final List<Product> products;
  final int maxItems;


  final void Function(Product product) onProductTap;

  const HorizontalProductList({
    super.key,
    required this.products,
    required this.onProductTap,
    this.maxItems = 6,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: products.isEmpty
          ? const Center(
              child: Text(
                'No products found',
                style: TextStyle(color: Color(0xFF9E9E9E)),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length.clamp(0, maxItems),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onTap: () => onProductTap(product),
                );
              },
            ),
    );
  }
}