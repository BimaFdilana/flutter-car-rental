import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/request/siswa/add_jadwal_request.dart';
import 'package:kursus_mengemudi_nasional/models/request/siswa/order_product_request.dart';
import 'package:kursus_mengemudi_nasional/models/request/siswa/upload_bukti_pembayaran.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/add_jadwal_response.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/add_order_product_response.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/order_product_response.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/success_upload_response.dart';
import 'package:kursus_mengemudi_nasional/utils/api.dart';

class OrderProductRemoteDatasource {
  Future<Either<BasePesananResponseModel, BasePesananResponseModel>>
      orderProduct(
    OrderProdukRequestModel request,
  ) async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse(
        ApiEndpoint.orderProduct,
      ),
      headers: headers,
      body: request.toJson(),
    );
    if (response.statusCode == 201) {
      debugPrint("RESPONSE BODY: ${response.body}");
      final decodedJson = jsonDecode(response.body);
      final model = BasePesananResponseModel.fromMap(decodedJson);
      return Right(model);
    } else {
      return Left(BasePesananResponseModel.fromMap(jsonDecode(response.body)));
    }
  }

  Future<Either<String, OrderProdukResponseModel>> getOrderData() async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(
        ApiEndpoint.orderDataKeranjang,
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      try {
        final decodedJson = jsonDecode(response.body);
        final model = OrderProdukResponseModel.fromMap(decodedJson);
        return Right(model);
      } catch (e) {
        return Left('Error Parsing Json: $e');
      }
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, SuccessUploadResponseModel>> uploadBuktiPembayaran(
      UploadBuktiPembayaranRequestModel model) async {
    try {
      final authData = await AuthlocalDatasource().getLoginData();
      final headers = {
        'Authorization': 'Bearer ${authData.token}',
      };

      final String endpoint = ApiEndpoint.uploadBuktiPembayaran.replaceFirst(
        '{id}',
        model.pesananId.toString(),
      );

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(endpoint),
      )..headers.addAll(headers);

      request.files.add(await http.MultipartFile.fromPath(
        'bukti',
        model.bukti.path,
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return Right(SuccessUploadResponseModel.fromJson(response.body));
      } else {
        return Left("Gagal upload: ${response.body}");
      }
    } catch (e) {
      return Left("Terjadi kesalahan: $e");
    }
  }

  Future<Either<SuccessAddJadwalResponseModel, SuccessAddJadwalResponseModel>>
      addJadwal({
    required AddJadwalRequestModel request,
  }) async {
    try {
      final authData = await AuthlocalDatasource().getLoginData();
      final headers = {
        'Authorization': 'Bearer ${authData.token}',
        'Content-Type': 'application/json', // pastikan ini ada
      };

      final url = ApiEndpoint.addJadwal
          .replaceFirst('{id}', request.pesananId.toString());

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint("Berhasil tambah jadwal: ${response.body}");
        return Right(SuccessAddJadwalResponseModel.fromJson(data));
      } else {
        final data = json.decode(response.body);
        debugPrint("Gagal tambah jadwal: ${response.body}");
        return Left(SuccessAddJadwalResponseModel.fromJson(data));
      }
    } catch (e) {
      debugPrint("Exception saat tambah jadwal: $e");
      return Left(
          SuccessAddJadwalResponseModel(success: false, message: e.toString()));
    }
  }
}
