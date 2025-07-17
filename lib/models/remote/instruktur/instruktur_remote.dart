import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/request/instruktur/update_status_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/instruktur/update_status.dart';
import 'package:kursus_mengemudi_nasional/models/response/instruktur/user_status.dart';
import 'package:kursus_mengemudi_nasional/utils/api.dart';

class InstrukturRemoteDatasource {
  Future<Either<String, UserStatusResponseModel>> userStatus() async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(ApiEndpoint.userStatus),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      final model = UserStatusResponseModel.fromMap(decodedJson);
      return Right(model);
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, UpdateStatusResponse>> updateStatus(
      UpdateRequestStatus request) async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };

    final url = ApiEndpoint.ubahJadwal
        .replaceFirst('{id}', request.idJadwal.toString());

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: json.encode(request.toJson()),
      );
      debugPrint('📥 Response body: ${response.body}');
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        final model = UpdateStatusResponse.fromJson(decodedJson);
        return Right(model);
      } else {
        return Left(response.body);
      }
    } catch (e) {
      debugPrint('❌ Exception during updateStatus: $e');
      return Left(e.toString());
    }
  }
}
