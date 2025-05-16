import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/siswa/order_product_remote.dart';
import 'package:kursus_mengemudi_nasional/models/request/siswa/upload_bukti_pembayaran.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/success_upload_response.dart';

part 'upload_image_event.dart';
part 'upload_image_state.dart';
part 'upload_image_bloc.freezed.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  final OrderProductRemoteDatasource orderProductRemote;
  UploadImageBloc(this.orderProductRemote) : super(_Initial()) {
    on<UploadImageEvent>((event, emit) {

    });
  }
}
