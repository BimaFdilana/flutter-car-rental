part of 'all_pesanan_bloc.dart';

@freezed
class AllPesananState with _$AllPesananState {
  const factory AllPesananState.initial() = _Initial;
  const factory AllPesananState.loading() = _Loading;
  const factory AllPesananState.success(AllPesananKasirResponse dataAllPesanan) =
      _Success;
  const factory AllPesananState.error(String messageError) = _Error;
}
