import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/request/kasir/create_paket_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_paket_response.dart';
import 'package:kursus_mengemudi_nasional/utils/api.dart';

class AllPaketRemoteDatasource {
  Future<Either<String, AllPaketResponse>> getAllPaket() async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(ApiEndpoint.allPaket),
      headers: headers,
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = AllPaketResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, ShowPaketResponse>> getDetailPaket(int id) async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(ApiEndpoint.detailPaket.replaceFirst('{id}', id.toString())),
      headers: headers,
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = ShowPaketResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, CreatePaketResponse>> createPaket(
      CreatePaketRequest request) async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse(ApiEndpoint.createPaket),
      headers: headers,
      body: request.toJson(),
    );
    if (response.statusCode == 201) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = CreatePaketResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, DeletedPaketResponse>> deletePaket(int id) async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.delete(
      Uri.parse(ApiEndpoint.deletePaket.replaceFirst('{id}', id.toString())),
      headers: headers,
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = DeletedPaketResponse.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }
}
