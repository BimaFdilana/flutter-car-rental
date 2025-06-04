import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_users_remote.dart';

part 'deleted_user_event.dart';
part 'deleted_user_state.dart';
part 'deleted_user_bloc.freezed.dart';

class DeletedUserBloc extends Bloc<DeletedUserEvent, DeletedUserState> {
  final AllUsersRemoteDatasource allUsersRemoteDatasource;
  DeletedUserBloc({required this.allUsersRemoteDatasource})
      : super(const _Initial()) {
    on<_Started>((event, emit) async {
      emit(_Loading());
      final result = await allUsersRemoteDatasource.deleteUser(event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded()),
      );
    });
  }
}
