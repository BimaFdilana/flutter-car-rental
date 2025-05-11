part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.success(AllProductResponseModel dataProduct) = _Success;
  const factory ProductState.error(String message) = _Error;
}
