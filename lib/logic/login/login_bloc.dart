import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/request/login_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/login_response.dart';
import 'package:kursus_mengemudi_nasional/models/remote/auth/auth_remote.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRemoteDatasource loginRemoteDatasource;
  LoginBloc({required this.loginRemoteDatasource}) : super(const _Initial()) {
    on<_LoginRequest>((event, emit) async {
      emit(const _Loading());
      final result = await loginRemoteDatasource.login(event.requestModel);
      result.fold(
        (error) => emit(_Error(error)),
        (success) {
          debugPrint(success.user.name);
          emit(_Success(success));
        },
      );
    });
  }
}
