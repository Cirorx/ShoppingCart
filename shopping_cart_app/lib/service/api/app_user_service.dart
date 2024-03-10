import 'api_service.dart';

class AppUserService {
  static Future<dynamic> checkUserOnDB(String email) async {
    return await ApiService.checkUser(email);
  }
}
