import 'package:recipe_app/models/user.dart';
import 'package:recipe_app/services/http_services.dart';

class AuthServices {
  static final AuthServices _singleton = AuthServices._internal();
  final _httpService = HTTPservices();

  User? user;
  factory AuthServices() {
    return _singleton;
  }
  AuthServices._internal();
  Future<bool> login(String username, String password) async {
    try {
      var response = await _httpService.post('auth/login', {
        "username": username,
        "password": password,
      });
      if (response?.statusCode == 200 && response?.data != null) {
        user = User.fromJson(response!.data);
        HTTPservices().setup(bearerToken: user!.token);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
