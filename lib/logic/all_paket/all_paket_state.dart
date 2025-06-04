part of 'all_paket_bloc.dart';

@freezed
class AllPaketState with _$AllPaketState {
  const factory AllPaketState.initial() = _Initial;
  const factory AllPaketState.loading() = _Loading;
  const factory AllPaketState.loaded(AllPaketResponse pakets) = _Loaded;
  const factory AllPaketState.error(String message) = _Error;
}
