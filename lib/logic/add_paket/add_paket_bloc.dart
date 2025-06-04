import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_paket_event.dart';
part 'add_paket_state.dart';
part '../bloc/add_paket_bloc.freezed.dart';

class AddPaketBloc extends Bloc<AddPaketEvent, AddPaketState> {
  AddPaketBloc() : super(_Initial()) {
    on<AddPaketEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
