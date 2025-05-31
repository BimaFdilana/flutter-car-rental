part of 'all_pesanan_bloc.dart';

@freezed
class AllPesananEvent with _$AllPesananEvent {
  const factory AllPesananEvent.started() = _Started;
  const factory AllPesananEvent.getAllPesanan() = _GetAllPesanan;
}