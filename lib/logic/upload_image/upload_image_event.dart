part of 'upload_image_bloc.dart';

@freezed
class UploadImageEvent with _$UploadImageEvent {
  const factory UploadImageEvent.started() = _Started;
  const factory UploadImageEvent.upload(UploadBuktiPembayaranRequestModel requestUpload) = _Upload;
}