part of 'all_jadwal_bloc.dart';

@freezed
class AllJadwalState with _$AllJadwalState {
  const factory AllJadwalState.initial() = _Initial;
  const factory AllJadwalState.loading() = _Loading;
  const factory AllJadwalState.success(AllJadwalKasirResponse dataAllJadwal) =
      _Success;
  const factory AllJadwalState.error(String messageError) = _Error;
}
