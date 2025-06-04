part of 'add_paket_bloc.dart';

@freezed
class AddPaketEvent with _$AddPaketEvent {
  const factory AddPaketEvent.started(CreatePaketRequest request) = _Started;

}