part of 'add_jadwal_bloc.dart';

@freezed
class AddJadwalState with _$AddJadwalState {
  const factory AddJadwalState.initial() = _Initial;
  const factory AddJadwalState.loading() = _Loading;
  const factory AddJadwalState.success(SuccessAddJadwalResponseModel addJadwalResponseSuccess) = _Success;
  const factory AddJadwalState.error(SuccessAddJadwalResponseModel addJadwalResponseError) = _Error;
}
