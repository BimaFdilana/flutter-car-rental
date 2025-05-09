import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kursus_mengemudi_nasional/models/response/login_response.dart';

class AuthlocalDatasource {
  Future<bool> saveLoginData(LoginResponseModel loginResponseModel) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(loginResponseModel.toJson()); // encode jadi String
    final result = await prefs.setString('login_data', jsonString);
    return result;
  }

  Future<void> removeLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('login_data');
  }

  Future<LoginResponseModel> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final loginData = prefs.getString('login_data');
    if (loginData != null) {
      final decoded = jsonDecode(loginData); // decode ke Map
      return LoginResponseModel.fromJson(decoded);
    } else {
      throw Exception('Login data not found');
    }
  }

  Future<bool> isLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('login_data');
  }
}
