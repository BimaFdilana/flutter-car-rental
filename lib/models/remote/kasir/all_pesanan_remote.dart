import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/request/kasir/edit_pesanan_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_pesanan_response.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/edit_pesanan_response.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/pesanan_detail_response.dart';
import 'package:kursus_mengemudi_nasional/utils/api.dart';

class AllPesananRemoteDatasource {
  Future<Either<String, AllPesananKasirResponse>> getAllPesanan() async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(ApiEndpoint.allPesanan),
      headers: headers,
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = AllPesananKasirResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, DetailPesananKasirResponse>> getDetailPesanan(
      int id) async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(ApiEndpoint.detailPesanan.replaceFirst('{id}', id.toString())),
      headers: headers,
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = DetailPesananKasirResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, UpdatePesananKasirResponse>> updatePesanan(
      EditPesananRequest request) async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.put(
      Uri.parse(
        ApiEndpoint.updatePesanan
            .replaceFirst('{id}', request.idPesanan.toString()),
      ),
      headers: headers,
      body: json.encode(request.toJson()),
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = UpdatePesananKasirResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }
}
