part of 'update_pesanan_status_bloc.dart';

@freezed
class UpdatePesananStatusState with _$UpdatePesananStatusState {
  const factory UpdatePesananStatusState.initial() = _Initial;
  const factory UpdatePesananStatusState.loading() = _Loading;
  const factory UpdatePesananStatusState.success(
      UpdatePesananKasirResponse updatePesananKasirResponse) = _Success;
  const factory UpdatePesananStatusState.error(String message) = _Error;
}
