import 'dart:convert';

import 'package:shopping_cart_app/model/product_model.dart';

import 'api_service.dart';

class ProductService {
  static Future<List<Product>> getProducts() async {
    final response = await ApiService.getProducts();
    final List<dynamic> jsonList = json.decode(response);
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }
}
