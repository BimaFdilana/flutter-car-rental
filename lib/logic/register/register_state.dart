part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = _Initial;
  const factory RegisterState.loading() = _Loading;
  const factory RegisterState.success(RegisterResponseModel registerResponseModel) = _SuccessRegister;
  const factory RegisterState.error(RegisterErrorResponseModel registerErrorResponseModel) = _ErrorRegister;
}
