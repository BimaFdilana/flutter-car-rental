part of 'order_data_bloc.dart';

@freezed
class OrderDataEvent with _$OrderDataEvent {
  const factory OrderDataEvent.started() = _Started;
  const factory OrderDataEvent.getOrderData() = _GetOrderData;
}