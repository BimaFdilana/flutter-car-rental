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
  UploadImageBloc({required this.orderProductRemote}) : super(_Initial()) {
    on<_Upload>((event, emit) async {
      emit(const UploadImageState.loading());

      try {
        final model = UploadBuktiPembayaranRequestModel(
          pesananId: event.requestUpload.pesananId,
          bukti: event.requestUpload.bukti,
        );
        final result = await orderProductRemote.uploadBuktiPembayaran(model);
        result.fold(
          (l) => emit(UploadImageState.error(l)),
          (r) => emit(UploadImageState.success(r)),
        );
      } catch (e) {
        emit(UploadImageState.error(e.toString()));
      }
    });
  }
}
