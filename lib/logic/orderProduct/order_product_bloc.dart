import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/siswa/order_product_remote.dart';
import 'package:kursus_mengemudi_nasional/models/request/siswa/order_product_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/add_order_product_response.dart';

part 'order_product_event.dart';
part 'order_product_state.dart';
part 'order_product_bloc.freezed.dart';

class OrderProductBloc extends Bloc<OrderProductEvent, OrderProductState> {
  final OrderProductRemoteDatasource remote;
  OrderProductBloc({required this.remote}) : super(const _Initial()) {
    on<_OrderProduct>((event, emit) async {

      emit(OrderProductState.loading());

      final result = await remote.orderProduct(event.request);

      result.fold(
        (l) => emit(OrderProductState.error(l)),
        (r) => emit(OrderProductState.success(r)),
      );
    });
  }
}
