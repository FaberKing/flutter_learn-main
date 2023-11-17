import 'package:bloc/bloc.dart';
import 'package:course_bank_sha/model/transaction_model.dart';
import 'package:course_bank_sha/services/transaction_service.dart';
import 'package:equatable/equatable.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) async {
      if (event is TransactionGet) {
        try {
          emit(TransactionLoading());

          final res = await TransactionService().getTransactions();

          emit(TransactionSuccess(res));
        } catch (e) {
          emit(TransactionFailed(e.toString()));
        }
      }
    });
  }
}
