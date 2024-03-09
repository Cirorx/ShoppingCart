import 'api_service.dart';

class AppUserService {
  static Future<String> createAppUser(String email) async {
    final response = await ApiService.createAppUser(email);

    return response;
  }
}
