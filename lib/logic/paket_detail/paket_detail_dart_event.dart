part of 'paket_detail_dart_bloc.dart';

@freezed
class PaketDetailDartEvent with _$PaketDetailDartEvent {
  const factory PaketDetailDartEvent.started(int idDetailPaket) = _Started;
}