part of 'add_user_bloc.dart';

@freezed
class AddUserState with _$AddUserState {
  const factory AddUserState.initial() = _Initial;
  const factory AddUserState.loading() = _Loading;
  const factory AddUserState.loaded(AddUserResponse response) = _Loaded;
  const factory AddUserState.error(String message) = _Error;
}
