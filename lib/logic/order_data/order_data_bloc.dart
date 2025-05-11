import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/siswa/order_product_remote.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/order_product_response.dart';

part 'order_data_event.dart';
part 'order_data_state.dart';
part 'order_data_bloc.freezed.dart';

class OrderDataBloc extends Bloc<OrderDataEvent, OrderDataState> {
  final OrderProductRemoteDatasource remoteDatasource;
  OrderDataBloc({required this.remoteDatasource}) : super(const _Initial()) {
    on<OrderDataEvent>((event, emit) async {
      emit(const _Loading());
      try {
        final result = await remoteDatasource.getOrderData();
        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Loaded(r)),
        );
      } catch (e) {
        emit(const _Error('Terjadi Kesalahan: Error Memuat Data'));
      }
    });
  }
}
