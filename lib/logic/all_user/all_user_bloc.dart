import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kursus_mengemudi_nasional/models/remote/kasir/all_users_remote.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_user.dart';

part 'all_user_event.dart';
part 'all_user_state.dart';
part 'all_user_bloc.freezed.dart';

class AllUserBloc extends Bloc<AllUserEvent, AllUserState> {
  final AllUsersRemoteDatasource allUsersRemoteDatasource;

  AllUserBloc({required this.allUsersRemoteDatasource})
      : super(const _Initial()) {
    on<_Started>((event, emit) async {
      debugPrint('[AllUserBloc] _Started event triggered');
      emit(_Loading());

      debugPrint('[AllUserBloc] Fetching all users...');
      final result = await allUsersRemoteDatasource.getAllUsers();

      result.fold(
        (l) {
          debugPrint('[AllUserBloc] Error occurred: $l');
          emit(_Error(l));
        },
        (r) {
          debugPrint('[AllUserBloc] Loaded ${r.data.length} users');
          for (var user in r.data) {
            debugPrint('[AllUserBloc] User: ${user.name} (${user.username})');
          }
          emit(_Loaded(r));
        },
      );
    });
  }
}
