part of 'deleted_user_bloc.dart';

@freezed
class DeletedUserEvent with _$DeletedUserEvent {
  const factory DeletedUserEvent.started(int id) = _Started;
}