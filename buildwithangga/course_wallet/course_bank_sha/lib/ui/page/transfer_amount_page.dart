import 'package:course_bank_sha/blocs/transfer/transfer_bloc.dart';
import 'package:course_bank_sha/model/transfer_form_model.dart';
import 'package:course_bank_sha/shared/shared_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../shared/theme.dart';
import '../widget/buttons.dart';

class TransferAmountPage extends StatefulWidget {
  final TransferFormModel data;
  const TransferAmountPage({
    super.key,
    required this.data,
  });

  @override
  State<TransferAmountPage> createState() => _TransferAmountPageState();
}

class _TransferAmountPageState extends State<TransferAmountPage> {
  final TextEditingController amountController =
      TextEditingController(text: '0');

  addMount(String number) {
    if (amountController.text == '0') {
      amountController.text = '';
    }
    setState(() {
      amountController.text = amountController.text + number;
    });
  }

  deleteAmount() {
    if (amountController.text.isNotEmpty) {
      setState(
        () {
          amountController.text = amountController.text.substring(
            0,
            amountController.text.length - 1,
          );
          if (amountController.text == '') {
            amountController.text = '0';
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    amountController.addListener(() {
      final text = amountController.text;

      amountController.value = amountController.value.copyWith(
        text: NumberFormat.currency(
          locale: 'id',
          decimalDigits: 0,
          symbol: '',
        ).format(
          int.parse(
            text == '' ? '0' : text.replaceAll('.', ''),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => TransferBloc(),
          child: BlocConsumer<TransferBloc, TransferState>(
            listener: (context, state) {
              if (state is TransferFailed) {
                showCustomSnackbar(context, state.e);
              }
              if (state is TransferSuccess) {
                context.read<AuthBloc>().add(
                      AuthUpdateBalance(
                        int.parse(
                              amountController.text.replaceAll('.', ''),
                            ) *
                            -1,
                      ),
                    );

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/transfer-success',
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              if (state is TransferLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 58,
                ),
                children: [
                  Center(
                    child: Text(
                      'Total Amount',
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 67,
                  ),
                  Align(
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        enabled: false,
                        controller: amountController,
                        cursorColor: greyColor,
                        style: whiteTextStyle.copyWith(
                          fontSize: 36,
                          fontWeight: medium,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Text(
                            'Rp',
                            style: whiteTextStyle.copyWith(
                              fontSize: 36,
                              fontWeight: medium,
                            ),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: greyColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 66,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 40,
                    runSpacing: 40,
                    children: List.generate(
                      12,
                      (index) {
                        if (index + 1 == 10) {
                          return const SizedBox(
                            width: 60,
                            height: 60,
                          );
                        } else if (index + 1 == 11) {
                          return InputPinButton(
                            title: '0',
                            onTap: () {
                              addMount('0');
                            },
                          );
                        } else if (index + 1 == 12) {
                          return GestureDetector(
                            onTap: () {
                              deleteAmount();
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: numberBackgroundColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return InputPinButton(
                            title: (index + 1).toString(),
                            onTap: () {
                              addMount((index + 1).toString());
                            },
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomFilledButton(
                    title: 'Continue',
                    onPressed: () async {
                      if (await Navigator.pushNamed(context, '/pin') == true) {
                        final authState = context.read<AuthBloc>().state;

                        String pin = "";
                        if (authState is AuthSuccess) {
                          pin = authState.user.pin!;
                        }

                        context.read<TransferBloc>().add(
                              TransferPost(
                                widget.data.copyWith(
                                  pin: pin,
                                  amount:
                                      amountController.text.replaceAll('.', ''),
                                ),
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextButton(
                    title: 'Terms & Conditions',
                    onPressed: () {},
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
