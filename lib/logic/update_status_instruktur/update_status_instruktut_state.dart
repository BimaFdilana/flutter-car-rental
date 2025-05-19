part of 'update_status_instruktut_bloc.dart';

@freezed
class UpdateStatusInstruktutState with _$UpdateStatusInstruktutState {
  const factory UpdateStatusInstruktutState.initial() = _Initial;
  const factory UpdateStatusInstruktutState.loading() = _Loading;
  const factory UpdateStatusInstruktutState.success(UpdateStatusResponse updateStatusResponse) = _Success;
  const factory UpdateStatusInstruktutState.error(String message) = _Error;
}
