import 'dart:convert';

import 'package:shopping_cart_app/model/product_model.dart';

import 'api_service.dart';

class ProductService {
  static Future<List<Product>> getProducts() async {
    final response = await ApiService.getProducts();
    return _parseProducts(response);
  }

  static Future<List<Product>> getProductsByCategory(String category) async {
    final response = await ApiService.getProductsByCategory(category);
    return _parseProducts(response);
  }

  static List<Product> _parseProducts(dynamic response) {
    final List<dynamic> jsonList = json.decode(response);
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }
}
