part of 'deleted_paket_bloc.dart';

@freezed
class DeletedPaketState with _$DeletedPaketState {
  const factory DeletedPaketState.initial() = _Initial;
  const factory DeletedPaketState.loading() = _Loading;
  const factory DeletedPaketState.loaded() = _Loaded;
  const factory DeletedPaketState.error(String message) = _Error;
}
