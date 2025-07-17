import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_users_remote.dart';
import 'package:kursus_mengemudi_nasional/models/request/kasir/add_user.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_user.dart';

part 'add_user_event.dart';
part 'add_user_state.dart';
part 'add_user_bloc.freezed.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  final AllUsersRemoteDatasource allUsersRemoteDatasource;
  AddUserBloc({required this.allUsersRemoteDatasource}) : super(_Initial()) {
    on<_Started>((event, emit) async {
      emit(_Loading());
      final result = await allUsersRemoteDatasource.addUser(event.userRequest);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
