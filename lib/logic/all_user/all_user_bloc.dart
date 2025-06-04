import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_user.dart';

part 'all_user_event.dart';
part 'all_user_state.dart';
part 'all_user_bloc.freezed.dart';

class AllUserBloc extends Bloc<AllUserEvent, AllUserState> {
  final AllUsersRemoteDatasource allUsersRemoteDatasource;
  AllUserBloc({required this.allUsersRemoteDatasource}) : super(const _Initial()) {
    on<AllUserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
