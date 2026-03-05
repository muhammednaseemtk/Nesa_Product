import 'package:flutter/material.dart';
import 'package:product/view/widgets/category_tab_bar.dart';
import 'package:product/view/widgets/error_view.dart';
import 'package:product/view/widgets/product_grid.dart';
import 'package:product/view/widgets/product_hero_heading.dart';
import 'package:product/view/widgets/product_top_bar.dart';
import 'package:product/view/widgets/search_bar.dart';
import 'package:provider/provider.dart';
import '../controller/product_controller.dart';
import '../model/product.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().fetchProducts();
    });

    final controller = context.watch<ProductController>();

    void goToDetail(Product product) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailScreen(id: product.id),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0F8),
      body: SafeArea(
        child: controller.isLoading
            
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF6B3FA0)),
              )
            : controller.error != null
          
                ? ErrorView(message: controller.error!)
             
                : CustomScrollView(
                    slivers: [
                   
                      const SliverToBoxAdapter(
                        child: ProductTopBar(),
                      ),

              
                      const SliverToBoxAdapter(
                        child: ProductHeroHeading(),
                      ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: ProductSearchBar(
                            textController: controller.searchTextController,
                            searchQuery: controller.searchQuery,
                            onChanged: controller.onSearchChanged,
                            onClear: controller.clearSearch,
                          ),
                        ),
                      ),

           
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 12),
                          child: CategoryTabBar(
                            categories: kCategoryTabs,
                            selectedIndex: controller.selectedCategoryIndex,
                            onSelected: controller.selectCategory,
                            scrollController:
                                controller.categoryScrollController,
                          ),
                        ),
                      ),

                    
                      ProductGrid(
                        products: controller.paginatedProducts,
                        totalCount: controller.totalFiltered,
                        hasMore: controller.hasMorePages,
                        isLoadingMore: false,
                        onLoadMore: controller.loadMore,
                        onProductTap: goToDetail,
                      ),
                    ],
                  ),
      ),
    );
  }
}


