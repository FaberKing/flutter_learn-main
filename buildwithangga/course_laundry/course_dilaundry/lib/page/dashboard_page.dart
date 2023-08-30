import 'package:course_dilaundry/config/app_constant.dart';
import 'package:course_dilaundry/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (_, ref, __) {
          int navIndex = ref.watch(dashboardIndexProvider);

          return AppConstants.dashboardNavMenu[navIndex]['view'] as Widget;
        },
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(70, 0, 70, 20),
        child: Consumer(builder: (_, ref, __) {
          int navIndex = ref.watch(dashboardIndexProvider);
          return Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            child: BottomNavigationBar(
                currentIndex: navIndex,
                elevation: 0,
                backgroundColor: Colors.transparent,
                iconSize: 30,
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  ref.read(dashboardIndexProvider.notifier).state = value;
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                unselectedItemColor: Colors.grey[400],
                items: AppConstants.dashboardNavMenu.map((e) {
                  return BottomNavigationBarItem(
                    icon: Icon(e['icon']),
                    label: e['label'],
                  );
                }).toList()),
          );
        }),
      ),
    );
  }
}
