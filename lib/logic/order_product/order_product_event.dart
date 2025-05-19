part of 'order_product_bloc.dart';

@freezed
class OrderProductEvent with _$OrderProductEvent {
  const factory OrderProductEvent.started() = _Started;
  const factory OrderProductEvent.orderProduct(OrderProdukRequestModel request) =
      _OrderProduct;
}