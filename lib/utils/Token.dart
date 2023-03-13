import 'package:shared_preferences/shared_preferences.dart';

class TokenGetter {
  final String token;

  TokenGetter({required this.token});

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(token);
  }
}
