part of 'order_product_bloc.dart';

@freezed
class OrderProductState with _$OrderProductState {
  const factory OrderProductState.initial() = _Initial;
  const factory OrderProductState.loading() = _Loading;
  const factory OrderProductState.success(OrderProdukResponseModel dataOrder) =
      _Success;
  const factory OrderProductState.error(String message) = _Error;
}
