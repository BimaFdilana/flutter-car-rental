import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/pemilik/pemilik_remote.dart';
import 'package:kursus_mengemudi_nasional/models/response/pemilik/pemilik_response.dart';

part 'all_pemilik_event.dart';
part 'all_pemilik_state.dart';
part 'all_pemilik_bloc.freezed.dart';

class AllPemilikBloc extends Bloc<AllPemilikEvent, AllPemilikState> {
  final PemilikRemoteDatasource pemilikRemoteDatasource;
  AllPemilikBloc({required this.pemilikRemoteDatasource})
      : super(const _Initial()) {
    on<_Started>((event, emit) async {
      emit(_Loading());
      final result = await pemilikRemoteDatasource.getAllPemilik();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
