import 'package:dio/dio.dart';
import '../model/product.dart';

class ProductService {

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<Product>> fetchProducts() async {

    final response = await dio.get("products");

    List data = response.data['products'];

    return data.map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> getProductById(int id) async {

    final response = await dio.get("products/$id");

    return Product.fromJson(response.data);
  }

  Future<Product> updateProduct(int id, Map<String, dynamic> data) async {

    final response = await dio.put(
      "products/$id",
      data: data,
    );

    return Product.fromJson(response.data);
  }
}