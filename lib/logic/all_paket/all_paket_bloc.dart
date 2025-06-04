import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_paket_remote.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_paket_response.dart';

part 'all_paket_event.dart';
part 'all_paket_state.dart';
part 'all_paket_bloc.freezed.dart';

class AllPaketBloc extends Bloc<AllPaketEvent, AllPaketState> {
  final AllPaketRemoteDatasource remoteDatasource;
  AllPaketBloc({required this.remoteDatasource}) : super(const _Initial()) {
    on<_Started>((event, emit)async {
      emit(const _Loading());
      try {
        final result = await remoteDatasource.getAllPaket();
        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Loaded(r)),
        );
      } catch (e) {
        emit(const _Error('Terjadi Kesalahan: Error Memuat Data'));
      }
    });
  }
}
