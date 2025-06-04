part of 'deleted_paket_bloc.dart';

@freezed
class DeletedPaketEvent with _$DeletedPaketEvent {
  const factory DeletedPaketEvent.started(int id) = _Started;
}