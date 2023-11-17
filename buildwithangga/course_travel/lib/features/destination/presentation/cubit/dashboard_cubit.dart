import 'package:course_travel/features/destination/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// part 'dashboard_state.dart';

class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super(0);

  change(int i) => emit(i);

  final List menuDashBoard = [
    [
      'Home',
      Icons.home,
      const HomePage(),
    ],
    [
      'Near',
      Icons.near_me,
      const Center(
        child: Text('near'),
      ),
    ],
    [
      'Favorite',
      Icons.favorite,
      const Center(
        child: Text('favorite'),
      ),
    ],
    [
      'Profile',
      Icons.person,
      const Center(
        child: Text('profile'),
      ),
    ],
  ];

  Widget get page => menuDashBoard[state][2];
}
