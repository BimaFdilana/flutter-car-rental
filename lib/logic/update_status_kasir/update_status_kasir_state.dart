part of 'update_status_kasir_bloc.dart';

@freezed
class UpdateStatusKasirState with _$UpdateStatusKasirState {
  const factory UpdateStatusKasirState.initial() = _Initial;
  const factory UpdateStatusKasirState.loading() = _Loading;
  const factory UpdateStatusKasirState.success(ChangeJadwalKasirResponse data) = _Success;
  const factory UpdateStatusKasirState.error(String message) = _Error;
}
