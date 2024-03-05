import 'package:http/http.dart' as http;
import '/utils/constants.dart' as constants;

class ApiService {
  static Future<dynamic> getProducts() async {
    final response =
        await http.get(Uri.parse(constants.HOST + constants.PATH_PRODUCTS));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
