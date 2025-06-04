part of 'paket_detail_dart_bloc.dart';

@freezed
class PaketDetailDartState with _$PaketDetailDartState {
  const factory PaketDetailDartState.initial() = _Initial;
  const factory PaketDetailDartState.loading() = _Loading;
  const factory PaketDetailDartState.loaded(ShowPaketResponse data) = _Loaded;
  const factory PaketDetailDartState.error(String message) = _Error;
}
