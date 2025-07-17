part of 'update_pesanan_status_bloc.dart';

@freezed
class UpdatePesananStatusEvent with _$UpdatePesananStatusEvent {
  const factory UpdatePesananStatusEvent.started(EditPesananRequest request) = _Started;
}