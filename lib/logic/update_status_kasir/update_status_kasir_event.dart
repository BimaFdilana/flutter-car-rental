part of 'update_status_kasir_bloc.dart';

@freezed
class UpdateStatusKasirEvent with _$UpdateStatusKasirEvent {
  const factory UpdateStatusKasirEvent.started(ChangeJadwalKasirRequest request) = _Started;
}