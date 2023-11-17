import 'package:bloc/bloc.dart';
import 'package:course_bank_sha/model/data_plane_form_model.dart';
import 'package:course_bank_sha/services/transaction_service.dart';
import 'package:equatable/equatable.dart';

part 'data_plane_event.dart';
part 'data_plane_state.dart';

class DataPlaneBloc extends Bloc<DataPlaneEvent, DataPlaneState> {
  DataPlaneBloc() : super(DataPlaneInitial()) {
    on<DataPlaneEvent>((event, emit) async {
      if (event is DataPlanPost) {
        try {
          emit(DataPlaneLoading());

          await TransactionService().dataPlane(event.data);

          emit(DataPlaneSuccess());
        } catch (e) {
          emit(DataPlaneFailed(e.toString()));
        }
      }
    });
  }
}
