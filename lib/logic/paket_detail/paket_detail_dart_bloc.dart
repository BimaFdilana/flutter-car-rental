import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_paket_remote.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_paket_response.dart';

part 'paket_detail_dart_event.dart';
part 'paket_detail_dart_state.dart';
part 'paket_detail_dart_bloc.freezed.dart';

class PaketDetailDartBloc
    extends Bloc<PaketDetailDartEvent, PaketDetailDartState> {
  final AllPaketRemoteDatasource remoteDatasource;
  PaketDetailDartBloc({required this.remoteDatasource})
      : super(const _Initial()) {
    on<_Started>((event, emit) async {
      emit(const _Loading());
      try {
        final result =
            await remoteDatasource.getDetailPaket(event.idDetailPaket);
        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Loaded(r)),
        );
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }
}
