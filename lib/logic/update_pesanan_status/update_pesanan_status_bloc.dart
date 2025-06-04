import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_pesanan_remote.dart';
import 'package:kursus_mengemudi_nasional/models/request/kasir/edit_pesanan_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/edit_pesanan_response.dart';

part 'update_pesanan_status_event.dart';
part 'update_pesanan_status_state.dart';
part 'update_pesanan_status_bloc.freezed.dart';

class UpdatePesananStatusBloc extends Bloc<UpdatePesananStatusEvent, UpdatePesananStatusState> {
  final AllPesananRemoteDatasource allPesananRemote;
  UpdatePesananStatusBloc({required this.allPesananRemote}) : super(const _Initial()) {
    on<_Started>((event, emit) async {
      emit(const UpdatePesananStatusState.loading());
      try {
        final model = EditPesananRequest(
          idPesanan: event.request.idPesanan,
          status: event.request.status,
        );
        final result = await allPesananRemote.updatePesanan(model);
        result.fold(
          (l) => emit(UpdatePesananStatusState.error(l)),
          (r) => emit(UpdatePesananStatusState.success(r)),
        );
      } catch (e) {
        emit(UpdatePesananStatusState.error(e.toString()));
      }
    });
  }
}
