part of 'local_user_bloc.dart';

@freezed
class LocalUserEvent with _$LocalUserEvent {
  const factory LocalUserEvent.started() = _Started;
}