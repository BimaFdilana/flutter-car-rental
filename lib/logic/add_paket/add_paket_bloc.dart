import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_paket_remote.dart';
import 'package:kursus_mengemudi_nasional/models/request/kasir/create_paket_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_paket_response.dart';

part 'add_paket_event.dart';
part 'add_paket_state.dart';
part 'add_paket_bloc.freezed.dart';

class AddPaketBloc extends Bloc<AddPaketEvent, AddPaketState> {
  final AllPaketRemoteDatasource paketRemoteDatasource;
  AddPaketBloc({required this.paketRemoteDatasource})
      : super(const _Initial()) {
    on<_Started>((event, emit) async {
      emit(_Loading());
      final result = await paketRemoteDatasource.createPaket(event.request);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
