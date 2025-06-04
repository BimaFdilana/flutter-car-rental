part of 'add_user_bloc.dart';

@freezed
class AddUserEvent with _$AddUserEvent {
  const factory AddUserEvent.started(UserRequest userRequest) = _Started;
}