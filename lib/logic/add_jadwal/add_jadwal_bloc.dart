import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/siswa/order_product_remote.dart';
import 'package:kursus_mengemudi_nasional/models/request/siswa/add_jadwal_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/add_jadwal_response.dart';

part 'add_jadwal_event.dart';
part 'add_jadwal_state.dart';
part 'add_jadwal_bloc.freezed.dart';

class AddJadwalBloc extends Bloc<AddJadwalEvent, AddJadwalState> {
  OrderProductRemoteDatasource orderProductRemoteDatasource;
  AddJadwalBloc({required this.orderProductRemoteDatasource})
      : super(const _Initial()) {
    on<_AddJadwal>((event, emit) async {
      emit(const AddJadwalState.loading());
      final result = await orderProductRemoteDatasource.addJadwal(
        request: event.request,
      );
      result.fold(
        (l) => emit(AddJadwalState.error(l)),
        (r) => emit(AddJadwalState.success(r)),
      );
    });
  }
}
