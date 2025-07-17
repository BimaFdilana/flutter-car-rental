import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/response/pemilik/pemilik_response.dart';
import 'package:kursus_mengemudi_nasional/utils/api.dart';

class PemilikRemoteDatasource {
  Future<Either<String, PemilikDataResponse>> getAllPemilik() async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse(ApiEndpoint.dataOwner),
      headers: headers,
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = PemilikDataResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }
}
