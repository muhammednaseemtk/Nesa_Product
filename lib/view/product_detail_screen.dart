import 'package:flutter/material.dart';
import 'package:product/view/widgets/add_to_cart_button.dart';
import 'package:product/view/widgets/detail_description_section.dart';
import 'package:product/view/widgets/detail_fetch_trigger.dart';
import 'package:product/view/widgets/detail_hero_image.dart';
import 'package:product/view/widgets/detail_rating_price_row.dart';
import 'package:product/view/widgets/detail_title_block.dart';
import 'package:product/view/widgets/error_body.dart';
import 'package:product/view/widgets/update_product_sheet.dart';
import 'package:provider/provider.dart';
import '../controller/product_controller.dart';
import '../model/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final int id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductController>();
    final Product? product = controller.selectedProduct;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0F8),
      appBar: _buildAppBar(
        context,
        title: product?.title ?? 'Product Detail',
        product: product,
      ),


      body: Stack(
        children: [
          DetailFetchTrigger(id: id),
          _buildBody(context, controller, product),
        ],
      ),
    );
  }

  
  AppBar _buildAppBar(
    BuildContext context, {
    required String title,
    Product? product,
  }) {
    return AppBar(
      backgroundColor: const Color(0xFFF5F0F8),
      elevation: 0,
      iconTheme: const IconThemeData(color: Color(0xFF1A1A2E)),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Color(0xFF1A1A2E),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        if (product != null)
          IconButton(
            tooltip: 'Edit product',
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF6B3FA0)),
            onPressed: () =>
                UpdateProductSheet.show(context, product: product),
          ),
        const SizedBox(width: 8),
      ],
    );
  }

 
  Widget _buildBody(
    BuildContext context,
    ProductController controller,
    Product? product,
  ) {
  
    if (controller.isLoadingDetail) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF6B3FA0)),
      );
    }

    
    if (product == null || product.id != id) {
      return ErrorBody(
        message: controller.error ?? 'Product not found.',
        onRetry: () => context.read<ProductController>().fetchProductById(id),
      );
    }

   
    return _DetailBody(product: product);
  }
}


class _DetailBody extends StatelessWidget {
  final Product product;
  const _DetailBody({required this.product});

  @override
  Widget build(BuildContext context) {
    final isUpdating = context.watch<ProductController>().isUpdating;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          DetailHeroImage(imageUrl: product.thumbnail),

          const SizedBox(height: 24),

          
          DetailTitleBlock(
            title: product.title,
            category: product.category,
          ),

          const SizedBox(height: 18),

          DetailRatingPriceRow(
            rating: product.rating,
            price: product.price,
          ),

          const SizedBox(height: 24),

          
          DetailDescriptionSection(description: product.description),

          const SizedBox(height: 32),

        
          AddToCartButton(
            isLoading: isUpdating,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.title} added to cart!'),
                  backgroundColor: const Color(0xFF6B3FA0),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}





