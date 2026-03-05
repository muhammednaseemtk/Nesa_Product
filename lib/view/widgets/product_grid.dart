import 'package:flutter/material.dart';
import 'package:product/model/product.dart';

import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final void Function(Product) onProductTap;
  final int totalCount;

  const ProductGrid({
    super.key,
    required this.products,
    required this.hasMore,
    required this.onLoadMore,
    required this.onProductTap,
    required this.totalCount,
    this.isLoadingMore = false,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search_off_rounded,
                  size: 48, color: Color(0xFFCCCCCC)),
              SizedBox(height: 12),
              Text(
                'No products found',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
         
          Padding(
            padding: const EdgeInsets.only(bottom: 12, top: 4),
            child: Text(
              'Showing ${products.length} of $totalCount results',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9E9E9E),
              ),
            ),
          ),

          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: products[index],
                onTap: () => onProductTap(products[index]),
              );
            },
          ),

          const SizedBox(height: 16),

          
          if (hasMore)
            Center(
              child: GestureDetector(
                onTap: isLoadingMore ? null : onLoadMore,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B3FA0),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B3FA0).withOpacity(0.30),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: isLoadingMore
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Load More',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),

          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}