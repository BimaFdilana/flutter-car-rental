part of 'user_status_bloc.dart';

@freezed
class UserStatusEvent with _$UserStatusEvent {
  const factory UserStatusEvent.started() = _Started;
  const factory UserStatusEvent.userStatus() = _UserStatus;
}