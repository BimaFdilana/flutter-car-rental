import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/request/kasir/change_jadwal_status_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_jadwal_response.dart';
import 'package:kursus_mengemudi_nasional/utils/api.dart';

class AllJadwalRemoteDatasource {
  Future<Either<String, AllJadwalKasirResponse>> getAllJadwal() async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(ApiEndpoint.allJadwalKasir),
      headers: headers,
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = AllJadwalKasirResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, ChangeJadwalKasirResponse>> changeJadwalStatus(
    ChangeJadwalKasirRequest request,
  ) async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.put(
      Uri.parse(ApiEndpoint.changeStatusJadwalKasir
          .replaceFirst('{id}', request.id.toString())),
      headers: headers,
      body: jsonEncode(request.toMap()),
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = ChangeJadwalKasirResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }
}
