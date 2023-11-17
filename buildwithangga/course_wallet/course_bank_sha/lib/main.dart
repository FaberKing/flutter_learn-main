import 'package:course_bank_sha/blocs/auth/auth_bloc.dart';
import 'package:course_bank_sha/blocs/user/user_bloc.dart';
import 'package:course_bank_sha/shared/theme.dart';
import 'package:course_bank_sha/ui/page/data_provider_page.dart';
import 'package:course_bank_sha/ui/page/data_success.dart';
import 'package:course_bank_sha/ui/page/home_page.dart';
import 'package:course_bank_sha/ui/page/onboarding_page.dart';
import 'package:course_bank_sha/ui/page/pin_page.dart';
import 'package:course_bank_sha/ui/page/profile_edit_page.dart';
import 'package:course_bank_sha/ui/page/profile_edit_pin_page.dart';
import 'package:course_bank_sha/ui/page/profile_edit_success_page.dart';
import 'package:course_bank_sha/ui/page/profile_page.dart';
import 'package:course_bank_sha/ui/page/sign_in_page.dart';
import 'package:course_bank_sha/ui/page/sign_up_page.dart';
import 'package:course_bank_sha/ui/page/sign_up_success_page.dart';
import 'package:course_bank_sha/ui/page/splash_page.dart';
import 'package:course_bank_sha/ui/page/topup_page.dart';
import 'package:course_bank_sha/ui/page/topup_success_page.dart';
import 'package:course_bank_sha/ui/page/transfer_page.dart';
import 'package:course_bank_sha/ui/page/transfer_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()
            ..add(
              AuthGetCurrentUser(),
            ),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: lightBackgroundColor,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: blackColor,
            ),
            titleTextStyle: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          scaffoldBackgroundColor: lightBackgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        // home: SplashPage(),
        routes: {
          '/': (context) => const SplashPage(),
          '/onboarding': (context) => const OnboardingPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/sign-up-success': (context) => const SignUpSuccessPage(),
          '/home': (context) => const HomePage(),
          '/profile': (context) => const ProfilePage(),
          '/pin': (context) => const PinPage(),
          '/profile-edit': (context) => const ProfileEditPage(),
          '/profile-edit-pin': (context) => const ProfileEditPinPage(),
          '/profile-edit-success': (context) => const ProfileEditSuccessPage(),
          '/topup': (context) => const TopupPage(),
          '/topup-success': (context) => const TopupSuccessPage(),
          '/transfer': (context) => const TransferPage(),
          '/transfer-success': (context) => const TransferSuccessPage(),
          '/data-provider': (context) => const DataProviderPage(),
          '/data-success': (context) => const DataSuccessPage(),
        },
      ),
    );
  }
}
