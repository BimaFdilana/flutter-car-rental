import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/request/login_request.dart';
import 'package:kursus_mengemudi_nasional/models/request/register_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:kursus_mengemudi_nasional/models/response/register_response.dart';
import 'package:kursus_mengemudi_nasional/utils/api.dart';

class LoginRemoteDatasource {
  Future<Either<LoginErrorResponseModel, LoginResponseModel>> login(
      LoginRequestModel requestModel) async {
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      Uri.parse(
        ApiEndpoint.login,
      ),
      body: requestModel.toJson(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return right(LoginResponseModel.fromJson(response.body));
    } else {
      return left(LoginErrorResponseModel.fromJson(response.body));
    }
  }

  Future<Either<RegisterErrorResponseModel, RegisterResponseModel>> register(
      RegisterRequestModel requestModel) async {
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      Uri.parse(
        ApiEndpoint.register,
      ),
      body: requestModel.toJson(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return right(RegisterResponseModel.fromJson(response.body));
    } else {
      return left(RegisterErrorResponseModel.fromJson(response.body));
    }
  }

  Future<Either<String, String>> logout() async {
    final loginData = await AuthlocalDatasource().getLoginData();
    final headers = {'Authorization': 'Bearer ${loginData.token}'};
    final response = await http.post(
      Uri.parse(ApiEndpoint.logout),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return right('Logout Berhasil');
    } else {
      return left('Logout Gagal');
    }
  }
}
