import 'dart:convert';
import 'package:shopping_cart_app/model/product_model.dart';
import 'api_service.dart';

class CartService {
  static Future<List<Product>> getCartProducts(String email) async {
    final response = await ApiService.getCartProducts(email);
    final List<dynamic> jsonList = json.decode(response);
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  static Future<void> modifyCart(
      String email, String productId, int quantity) async {
    await ApiService.modifyCart(email, productId, quantity);
  }
}
