part of 'pesanan_detail_bloc.dart';

@freezed
class PesananDetailEvent with _$PesananDetailEvent {
  const factory PesananDetailEvent.started(int idDetail) = _Started;
}