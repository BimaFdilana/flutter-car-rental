import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/siswa/product_remote.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/product_response.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource remoteDatasource;
  ProductBloc({required this.remoteDatasource}) : super(const _Initial()) {
    on<ProductEvent>((event, emit) async {
      emit(const _Loading());
      try {
        final result = await remoteDatasource.getShopProducts();
        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Success(r)),
        );
      } catch (e) {
        emit(const _Error('Terjadi Kesalahan: Error Memuat Data'));
      }
    });
  }
}
