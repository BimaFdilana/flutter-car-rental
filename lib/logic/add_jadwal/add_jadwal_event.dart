part of 'add_jadwal_bloc.dart';

@freezed
class AddJadwalEvent with _$AddJadwalEvent {
  const factory AddJadwalEvent.addJadwal(AddJadwalRequestModel request) =
      _AddJadwal;
}
