part of 'all_jadwal_bloc.dart';

@freezed
class AllJadwalEvent with _$AllJadwalEvent {
  const factory AllJadwalEvent.started() = _Started;
  const factory AllJadwalEvent.getAllJadwal() = _GetAllJadwal;
}