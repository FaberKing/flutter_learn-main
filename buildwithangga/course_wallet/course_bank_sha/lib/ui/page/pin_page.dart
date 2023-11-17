import 'package:course_bank_sha/blocs/auth/auth_bloc.dart';
import 'package:course_bank_sha/shared/shared_method.dart';
import 'package:course_bank_sha/shared/theme.dart';
import 'package:course_bank_sha/ui/widget/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  final TextEditingController pinController = TextEditingController(text: '');
  String pin = '';
  bool isError = false;

  addPin(String number) {
    if (pinController.text.length < 6) {
      setState(() {
        pinController.text = pinController.text + number;
      });
    }

    if (pinController.text.length == 6) {
      if (pinController.text == pin) {
        Navigator.pop(context, true);
      } else {
        setState(() {
          isError = true;
        });
        showCustomSnackbar(
            context, 'PIN yang ada masukan salah. Silahkan coba kembali');
      }
    }
  }

  deletePin() {
    if (pinController.text.isNotEmpty) {
      setState(
        () {
          isError = false;
          pinController.text = pinController.text.substring(
            0,
            pinController.text.length - 1,
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthSuccess) {
      pin = authState.user.pin!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 58,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sha Pin',
                style: whiteTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 72,
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  enabled: false,
                  controller: pinController,
                  obscureText: true,
                  cursorColor: greyColor,
                  obscuringCharacter: '*',
                  style: whiteTextStyle.copyWith(
                    fontSize: 36,
                    fontWeight: medium,
                    letterSpacing: 16,
                    color: isError ? redColor : whiteColor,
                  ),
                  decoration: InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: isError ? redColor : greyColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 66,
              ),
              Wrap(
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
                          addPin('0');
                        },
                      );
                    } else if (index + 1 == 12) {
                      return GestureDetector(
                        onTap: () {
                          deletePin();
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
                          addPin((index + 1).toString());
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
