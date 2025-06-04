part of 'pesanan_detail_bloc.dart';

@freezed
class PesananDetailState with _$PesananDetailState {
  const factory PesananDetailState.initial() = _Initial;
  const factory PesananDetailState.loading() = _Loading;
  const factory PesananDetailState.loaded(DetailPesananKasirResponse data) =
      _Loaded;
  const factory PesananDetailState.error(String message) = _Error;
}
 