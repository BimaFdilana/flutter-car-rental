import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/instruktur/instruktur_remote.dart';
import 'package:kursus_mengemudi_nasional/models/request/instruktur/update_status_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/instruktur/update_status.dart';

part 'update_status_instruktut_event.dart';
part 'update_status_instruktut_state.dart';
part 'update_status_instruktut_bloc.freezed.dart';

class UpdateStatusInstruktutBloc
    extends Bloc<UpdateStatusInstruktutEvent, UpdateStatusInstruktutState> {
  final InstrukturRemoteDatasource instrukturRemote;
  UpdateStatusInstruktutBloc({required this.instrukturRemote})
      : super(const _Initial()) {
    on<_UpdateStatusInstruktur>((event, emit) async {
      emit(UpdateStatusInstruktutState.loading());
      try {
        final model = UpdateRequestStatus(
          idJadwal: event.request.idJadwal,
          status: event.request.status,
        );
        final result = await instrukturRemote.updateStatus(model);
        result.fold(
          (l) => emit(UpdateStatusInstruktutState.error(l)),
          (r) => emit(UpdateStatusInstruktutState.success(r)),
        );
      } catch (e) {
        emit(UpdateStatusInstruktutState.error(e.toString()));
      }
    });
  }
}
