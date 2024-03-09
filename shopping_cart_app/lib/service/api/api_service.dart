import 'dart:async';

import 'package:http/http.dart' as http;
import '/utils/constants.dart' as constants;

class ApiService {
  static Future<dynamic> createAppUser(String email) async {
    final response = await http.post(
      Uri.parse(constants.HOST + constants.PATH_CREATE_USER),
      body: {'email': email},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to create app user');
    }
  }

  static Future<dynamic> getProducts() async {
    final response = await http.get(
      Uri.parse(constants.HOST + constants.PATH_PRODUCTS),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<dynamic> getProductsByCategory(String category) async {
    final response = await http.get(
      Uri.parse(constants.HOST + constants.PATH_CATEGORY_PRODUCTS + category),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load products by category');
    }
  }

  static Future<dynamic> getCartProducts(String email) async {
    final response = await http.get(
      Uri.parse(constants.HOST + constants.PATH_USER_CART + email),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to get cart products');
    }
  }

  static Future<void> modifyCart(
      String email, String productId, int quantity) async {
    await http.post(
      Uri.parse(constants.HOST + constants.PATH_MODIFY_CART),
      body: {
        'userEmail': email,
        'productId': productId,
        'quantity': quantity,
      },
    );
  }
}
