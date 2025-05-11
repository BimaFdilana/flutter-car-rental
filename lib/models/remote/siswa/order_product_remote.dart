import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/request/siswa/order_product_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/order_product_response.dart';
import 'package:kursus_mengemudi_nasional/utils/api.dart';

class OrderProductRemoteDatasource {
  Future<Either<String, OrderProdukResponseModel>> orderProduct(
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

  Future<Either<String, OrderProdukResponseModel>> getOrderData() async {
    final authData = await AuthlocalDatasource().getLoginData();
    final headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(
        ApiEndpoint.orderData,
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
}
