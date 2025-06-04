import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_paket_remote.dart';

part 'deleted_paket_event.dart';
part 'deleted_paket_state.dart';
part 'deleted_paket_bloc.freezed.dart';

class DeletedPaketBloc extends Bloc<DeletedPaketEvent, DeletedPaketState> {
  final AllPaketRemoteDatasource allPaketRemoteDatasource;
  DeletedPaketBloc({required this.allPaketRemoteDatasource}) : super(_Initial()) {
    on<_Started>((event, emit) async {
      emit(_Loading());
      final result = await allPaketRemoteDatasource.deletePaket(event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded()),
      );
    });
  }
}
