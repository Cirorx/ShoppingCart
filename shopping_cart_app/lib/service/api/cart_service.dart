import 'dart:convert';

import 'api_service.dart';
import 'product_service.dart';

class CartService {
  static Future<List<dynamic>> getCartProducts(String email) async {
    final response = await ApiService.getCartProducts(email);
    final List<dynamic> jsonList = json.decode(response);
    return jsonList;
  }

  static Future<void> modifyCart(
      String email, String productId, int quantity) async {
    await ApiService.modifyCart(email, productId, quantity);
    final updatedProduct = await ProductService.getProductById(productId);
    ProductService.updateStockStream(updatedProduct.stock);
  }
}
