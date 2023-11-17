import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:course_bank_sha/model/payment_method_model.dart';
import 'package:course_bank_sha/services/payment_method_service.dart';
import 'package:equatable/equatable.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc() : super(PaymentMethodInitial()) {
    on<PaymentMethodEvent>((event, emit) async {
      if (event is PaymentMethodGet) {
        try {
          emit(PaymentMethodLoading());

          final paymentMethods =
              await PaymentMethodService().getPaymentMedthods();

          emit(PaymentMethodSuccess(paymentMethods));
        } catch (e) {
          emit(PaymentMethodFailed(e.toString()));
        }
      }
    });
  }
}
