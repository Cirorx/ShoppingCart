import 'dart:async';
import 'dart:convert';

import 'package:shopping_cart_app/model/product_model.dart';

import 'api_service.dart';

class ProductService {
  static final _stockStreamController = StreamController<int>.broadcast();

  static Stream<int> get stockStream => _stockStreamController.stream;

  static void updateStockStream(int newStock) {
    _stockStreamController.add(newStock);
  }

  static Future<List<Product>> getProducts() async {
    final response = await ApiService.getProducts();
    return _parseProducts(response);
  }

  static Future<List<Product>> getProductsByCategory(String category) async {
    final response = await ApiService.getProductsByCategory(category);
    return _parseProducts(response);
  }

  static Future<Product> getProductById(productId) async {
    final response = await ApiService.getProductById(productId);
    final jsonProduct = json.decode(response);
    return Product.fromJson(jsonProduct);
  }

  static List<Product> _parseProducts(dynamic response) {
    final List<dynamic> jsonList = json.decode(response);
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  static Future<int> getInitialStock(String productId) async {
    final product = await getProductById(productId);
    final stock = product.stock;
    updateStockStream(stock);
    return stock;
  }
}
