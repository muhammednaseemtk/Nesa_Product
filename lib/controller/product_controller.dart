import 'package:flutter/material.dart';
import 'package:product/service/product_service.dart';
import '../model/product.dart';


const List<String> kCategoryTabs = [
  'All',
  'Smartphones',
  'Laptops',
  'Beauty',
  'Skin Care',
  'Fragrances',
  'Tablets',
  'Mobile Accessories',
  'Fashion',
  'Furniture',
  'Groceries',
  'Vehicle',
  'Motorcycle',
  'Lighting',
];

const Map<String, List<String>> kCategorySlugMap = {
  'All': [],
  'Smartphones': ['smartphones'],
  'Laptops': ['laptops'],
  'Beauty': ['beauty'],
  'Skin Care': ['skin-care'],
  'Fragrances': ['fragrances'],
  'Tablets': ['tablets'],
  'Mobile Accessories': ['mobile-accessories'],
  'Fashion': [
    'mens-shirts',
    'mens-shoes',
    'mens-watches',
    'womens-dresses',
    'womens-shoes',
    'womens-watches',
    'womens-bags',
    'womens-jewellery',
    'tops',
    'sunglasses',
  ],
  'Furniture': ['furniture'],
  'Groceries': ['groceries'],
  'Vehicle': ['vehicle'],
  'Motorcycle': ['motorcycle'],
  'Lighting': ['lighting'],
};

const int kPageSize = 10;

class ProductController extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<Product> _allProducts = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get allProducts => _allProducts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  final TextEditingController searchTextController = TextEditingController();

  void onSearchChanged(String query) {
    _searchQuery = query.trim().toLowerCase();
    _currentPage = 1;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    searchTextController.clear();
    _currentPage = 1;
    notifyListeners();
  }

  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;
  String get selectedCategory => kCategoryTabs[_selectedCategoryIndex];

  final ScrollController categoryScrollController = ScrollController();

  void selectCategory(int index) {
    if (_selectedCategoryIndex == index) return;
    _selectedCategoryIndex = index;
    _searchQuery = '';
    _currentPage = 1;
    notifyListeners();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    categoryScrollController.dispose();
    super.dispose();
  }

  int _currentPage = 1;
  int get currentPage => _currentPage;

  List<Product> get filteredProducts {
    List<Product> result = _allProducts;

    if (_selectedCategoryIndex != 0) {
      final slugs = kCategorySlugMap[selectedCategory] ?? [];
      result = result.where((p) {
        final cat = p.category.toLowerCase();
        return slugs.any((s) => cat.contains(s));
      }).toList();
    }

    if (_searchQuery.isNotEmpty) {
      result = result.where((p) {
        return p.title.toLowerCase().contains(_searchQuery) ||
            p.category.toLowerCase().contains(_searchQuery) ||
            p.description.toLowerCase().contains(_searchQuery);
      }).toList();
    }

    return result;
  }

  List<Product> get paginatedProducts {
    final all = filteredProducts;
    final end = (_currentPage * kPageSize).clamp(0, all.length);
    return all.sublist(0, end);
  }

  bool get hasMorePages =>
      paginatedProducts.length < filteredProducts.length;

  int get totalFiltered => filteredProducts.length;

  void loadMore() {
    if (!hasMorePages) return;
    _currentPage++;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    if (_allProducts.isNotEmpty) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allProducts = await _service.fetchProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Product? _selectedProduct;
  bool _isLoadingDetail = false;

  Product? get selectedProduct => _selectedProduct;
  bool get isLoadingDetail => _isLoadingDetail;

  Future<void> fetchProductById(int id) async {
    _isLoadingDetail = true;
    _error = null;
    notifyListeners();

    try {
      _selectedProduct = await _service.getProductById(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingDetail = false;
      notifyListeners();
    }
  }

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  Future<bool> updateProduct(int id, Map<String, dynamic> data) async {
    _isUpdating = true;
    _error = null;
    notifyListeners();

    try {
      final updated = await _service.updateProduct(id, data);
      final index = _allProducts.indexWhere((p) => p.id == id);
      if (index != -1) _allProducts[index] = updated;
      if (_selectedProduct?.id == id) _selectedProduct = updated;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  List<Product> filterByCategories(List<String> keywords) {
    return _allProducts.where((p) {
      final cat = p.category.toLowerCase();
      return keywords.any((kw) => cat.contains(kw.toLowerCase()));
    }).toList();
  }
}

