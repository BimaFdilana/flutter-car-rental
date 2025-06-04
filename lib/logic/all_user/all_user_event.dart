part of 'all_user_bloc.dart';

@freezed
class AllUserEvent with _$AllUserEvent {
  const factory AllUserEvent.started() = _Started;
}