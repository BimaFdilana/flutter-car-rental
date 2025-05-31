import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_jadwal_remote.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_jadwal_response.dart';

part 'all_jadwal_event.dart';
part 'all_jadwal_state.dart';
part 'all_jadwal_bloc.freezed.dart';

class AllJadwalBloc extends Bloc<AllJadwalEvent, AllJadwalState> {
  final AllJadwalRemoteDatasource remoteAllproduct;
  AllJadwalBloc({required this.remoteAllproduct}) : super(const _Initial()) {
    on<AllJadwalEvent>((event, emit) async {
      emit(const _Loading());
      try {
        final result = await remoteAllproduct.getAllJadwal();
        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Success(r)),
        );
      } catch (e) {
        emit(const _Error('Terjadi Kesalahan: Error Memuat Data Jadwal'));
      }
    });
  }
}
