import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_pesanan_remote.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/pesanan_detail_response.dart';

part 'pesanan_detail_event.dart';
part 'pesanan_detail_state.dart';
part 'pesanan_detail_bloc.freezed.dart';

class PesananDetailBloc extends Bloc<PesananDetailEvent, PesananDetailState> {
  final AllPesananRemoteDatasource allPesananRemote;
  PesananDetailBloc({required this.allPesananRemote}) : super(const _Initial()) {
    on<_Started>((event, emit) async {
      emit(PesananDetailState.loading());
      try {
        final result = await allPesananRemote.getDetailPesanan(event.idDetail);
        result.fold(
          (l) => emit(PesananDetailState.error(l)),
          (r) => emit(PesananDetailState.loaded(r)),
        );
      } catch (e) {
        emit(PesananDetailState.error(e.toString()));
      }
    });
  }
}
