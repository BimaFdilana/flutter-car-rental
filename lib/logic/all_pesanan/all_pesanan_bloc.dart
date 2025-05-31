import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_pesanan_remote.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_pesanan_response.dart';

part 'all_pesanan_event.dart';
part 'all_pesanan_state.dart';
part 'all_pesanan_bloc.freezed.dart';

class AllPesananBloc extends Bloc<AllPesananEvent, AllPesananState> {
  final AllPesananRemoteDatasource remoteAllproduct;
  AllPesananBloc({required this.remoteAllproduct}) : super(const _Initial()) {
    on<AllPesananEvent>((event, emit) async {
      emit(const _Loading());
      try {
        final result = await remoteAllproduct.getAllPesanan();
        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Success(r)),
        );
      } catch (e) {
        emit(const _Error('Terjadi Kesalahan: Error Memuat Data Pesanan'));
      }
    });
  }
}
