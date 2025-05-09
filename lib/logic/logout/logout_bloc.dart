import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/auth/auth_remote.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LoginRemoteDatasource logoutRemoteDatasource;
  LogoutBloc({required this.logoutRemoteDatasource}) : super(const _Initial()) {
    on<LogoutEvent>((event, emit) async {
      emit(const _Loading());
      final result = await logoutRemoteDatasource.logout();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
