import 'dart:io';

class UploadBuktiPembayaranRequestModel {
  final int pesananId;
  final File bukti;

  UploadBuktiPembayaranRequestModel({
    required this.pesananId,
    required this.bukti,
  });
}
