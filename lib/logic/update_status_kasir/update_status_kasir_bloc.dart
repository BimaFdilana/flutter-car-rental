import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_jadwal_remote.dart';
import 'package:kursus_mengemudi_nasional/models/request/kasir/change_jadwal_status_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_jadwal_response.dart';

part 'update_status_kasir_event.dart';
part 'update_status_kasir_state.dart';
part 'update_status_kasir_bloc.freezed.dart';

class UpdateStatusKasirBloc
    extends Bloc<UpdateStatusKasirEvent, UpdateStatusKasirState> {
  final AllJadwalRemoteDatasource allJadwalRemoteDatasource;
  UpdateStatusKasirBloc({required this.allJadwalRemoteDatasource})
      : super(const _Initial()) {
    on<_Started>((event, emit) async {
      emit(_Loading());
      final result =
          await allJadwalRemoteDatasource.changeJadwalStatus(event.request);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
