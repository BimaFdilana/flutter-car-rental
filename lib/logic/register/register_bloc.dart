import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/auth/auth_remote.dart';
import 'package:kursus_mengemudi_nasional/models/request/register_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/register_response.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final LoginRemoteDatasource registerRemoteDatasource;
  RegisterBloc({required this.registerRemoteDatasource})
      : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const RegisterState.loading());
      final result =
          await registerRemoteDatasource.register(event.requestModel);
      result.fold(
        (l) => emit(RegisterState.error(l)),
        (r) => emit(RegisterState.success(r)),
      );
    });
  }
}
