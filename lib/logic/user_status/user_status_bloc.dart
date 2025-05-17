import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/instruktur/instruktur_remote.dart';
import 'package:kursus_mengemudi_nasional/models/response/instruktur/user_status.dart';

part 'user_status_event.dart';
part 'user_status_state.dart';
part 'user_status_bloc.freezed.dart';

class UserStatusBloc extends Bloc<UserStatusEvent, UserStatusState> {
  final InstrukturRemoteDatasource remoteDatasource;
  UserStatusBloc({required this.remoteDatasource}) : super(const _Initial()) {
    on<UserStatusEvent>((event, emit) async {
      emit(const UserStatusState.loading());

      final result = await remoteDatasource.userStatus();
      result.fold(
        (l) => emit(UserStatusState.error(l)),
        (r) => emit(UserStatusState.success(r)),
      );
    });
  }
}
