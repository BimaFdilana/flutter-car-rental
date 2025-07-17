import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/request/kasir/add_user.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_user.dart';
import 'package:kursus_mengemudi_nasional/utils/api.dart';

class AllUsersRemoteDatasource {
  Future<Either<String, UserResponse>> getAllUsers() async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(ApiEndpoint.allUsers),
      headers: headers,
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = UserResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, AddUserResponse>> addUser(UserRequest request) async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse(ApiEndpoint.addUser),
      headers: headers,
      body: request.toJson(),
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = AddUserResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, DeletedUserResponse>> deleteUser(int id) async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.delete(
      Uri.parse(ApiEndpoint.deleteUser.replaceFirst('{id}', id.toString())),
      headers: headers,
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = DeletedUserResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }
}
