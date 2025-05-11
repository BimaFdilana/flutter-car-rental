import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/response/login_response.dart';

part 'local_user_event.dart';
part 'local_user_state.dart';
part 'local_user_bloc.freezed.dart';

class LocalUserBloc extends Bloc<LocalUserEvent, LocalUserState> {
  final AuthlocalDatasource authlocalDatasource;
  LocalUserBloc({required this.authlocalDatasource}) : super(const _Initial()) {
    on<LocalUserEvent>((event, emit) {
      event.maybeWhen(
        orElse: () {},
        started: () {
          emit(const _Loading());
          authlocalDatasource.getLoginData().then((value) {
            emit(_Success(value));
          }).onError((error, stackTrace) {
            emit(_Error(error.toString()));
          });
        },
      );
    });
  }
}
