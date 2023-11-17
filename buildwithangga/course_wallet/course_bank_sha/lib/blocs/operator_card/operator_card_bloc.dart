import 'package:bloc/bloc.dart';
import 'package:course_bank_sha/model/operator_card_model.dart';
import 'package:course_bank_sha/services/operator_card_services.dart';
import 'package:equatable/equatable.dart';

part 'operator_card_event.dart';
part 'operator_card_state.dart';

class OperatorCardBloc extends Bloc<OperatorCardEvent, OperatorCardState> {
  OperatorCardBloc() : super(OperatorCardInitial()) {
    on<OperatorCardEvent>((event, emit) async {
      if (event is OperatorCardGet) {
        try {
          emit(OperatorCardLoading());

          final operatorCard = await OperatorCardService().getOperatorCards();

          emit(OperatorCardSuccess(operatorCard));
        } catch (e) {
          emit(OperatorCardFailed(e.toString()));
        }
      }
    });
  }
}
