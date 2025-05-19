part of 'update_status_instruktut_bloc.dart';

@freezed
class UpdateStatusInstruktutEvent with _$UpdateStatusInstruktutEvent {
  const factory UpdateStatusInstruktutEvent.started() = _Started;
  const factory UpdateStatusInstruktutEvent.updateStatus(UpdateRequestStatus request) = _UpdateStatusInstruktur;
}