part of 'add_paket_bloc.dart';

@freezed
class AddPaketState with _$AddPaketState {
  const factory AddPaketState.initial() = _Initial;
  const factory AddPaketState.loading() = _Loading;
  const factory AddPaketState.loaded(CreatePaketResponse response) = _Loaded;
  const factory AddPaketState.error(String message) = _Error;
}
