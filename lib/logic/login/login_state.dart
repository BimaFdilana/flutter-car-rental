part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(LoginResponseModel data) = _Success;
  const factory LoginState.error(LoginErrorResponseModel error) = _Error;
}
