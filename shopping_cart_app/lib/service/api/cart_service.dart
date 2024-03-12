import 'dart:async';
import 'dart:convert';

import 'api_service.dart';
import 'product_service.dart';

class CartService {
  static final StreamController<Map<String, int>> _quantityStreamController =
      StreamController<Map<String, int>>.broadcast();

  static Stream<Map<String, int>> get quantityStream =>
      _quantityStreamController.stream;

  static void updateQuantityStream(email, productId) async {
    final updatedCart = await getCartProducts(email);
    final Map<String, int> updatedQuantityMap = {};
    for (var item in updatedCart) {
      updatedQuantityMap[item['productInfo']['productId']] = item['quantity'];
    }
    _quantityStreamController.add(updatedQuantityMap);
  }

  static Future<List<dynamic>> getCartProducts(String email) async {
    final response = await ApiService.getCartProducts(email);
    final List<dynamic> jsonList = json.decode(response);
    return jsonList;
  }

  static Future<void> modifyCart(
      String email, String productId, int quantity) async {
    await ApiService.modifyCart(email, productId, quantity);
    ProductService.updateStockStream(productId);
    updateQuantityStream(email, productId);
  }
}
