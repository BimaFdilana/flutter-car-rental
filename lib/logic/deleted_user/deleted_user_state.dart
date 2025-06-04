part of 'deleted_user_bloc.dart';

@freezed
class DeletedUserState with _$DeletedUserState {
  const factory DeletedUserState.initial() = _Initial;
  const factory DeletedUserState.loading() = _Loading;
  const factory DeletedUserState.loaded() = _Loaded;
  const factory DeletedUserState.error(String message) = _Error;
}
