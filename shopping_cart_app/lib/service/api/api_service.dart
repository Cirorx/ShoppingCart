import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '/utils/constants.dart' as constants;

class ApiService {
  static Future<dynamic> checkUser(String email) async {
    var map = {'email': email};
    var body = json.encode(map);
    final response = await http.post(
      headers: {"Content-Type": "application/json"},
      Uri.parse(constants.HOST + constants.PATH_CHECK_USER),
      body: body,
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to check user');
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
    var map = {'email': email};
    var body = json.encode(map);
    final response = await http.post(
      headers: {"Content-Type": "application/json"},
      Uri.parse(constants.HOST + constants.PATH_USER_CART),
      body: body,
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
    var map = {
      'userEmail': email,
      'productId': productId,
      'quantity': quantity
    };
    var body = json.encode(map);
    await http.post(
      headers: {"Content-Type": "application/json"},
      Uri.parse(constants.HOST + constants.PATH_MODIFY_CART),
      body: body,
    );
  }

  static getProductById(productId) async {
    final response = await http.get(
      Uri.parse(constants.HOST + constants.PATH_ONE_PRODUCT + productId),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load products by category');
    }
  }
}
