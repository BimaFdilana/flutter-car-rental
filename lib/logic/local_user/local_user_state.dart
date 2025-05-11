part of 'local_user_bloc.dart';

@freezed
class LocalUserState with _$LocalUserState {
  const factory LocalUserState.initial() = _Initial;
  const factory LocalUserState.loading() = _Loading;
  const factory LocalUserState.success(LoginResponseModel user) = _Success;
  const factory LocalUserState.error(String message) = _Error;
}
