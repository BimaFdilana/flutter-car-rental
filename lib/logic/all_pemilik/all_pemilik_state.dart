part of 'all_pemilik_bloc.dart';

@freezed
class AllPemilikState with _$AllPemilikState {
  const factory AllPemilikState.initial() = _Initial;
  const factory AllPemilikState.loading() = _Loading;
  const factory AllPemilikState.success(PemilikDataResponse data) = _Success;
  const factory AllPemilikState.error(String message) = _Error;
}
