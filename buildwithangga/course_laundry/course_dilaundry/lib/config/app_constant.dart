import 'package:course_dilaundry/page/dashboard_views/account_view.dart';
import 'package:course_dilaundry/page/dashboard_views/home_view.dart';
import 'package:course_dilaundry/page/dashboard_views/my_laundry_view.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static const appName = 'Di Laundry';

  static const _host = 'http://172.30.64.1:8000';

  /// ``` baseURL = '$_host/api' ```
  static const baseURL = '$_host/api';

  /// ``` baseImageURL = '$_host/storage' ```
  static const baseImageURL = '$_host/storage';

  static const laundryStatusCategory = [
    'All',
    'Pickup',
    'Queue',
    'Process',
    'Washing',
    'Dried',
    'Ironed',
    'Done',
    'Delivery',
  ];

  static List<Map> dashboardNavMenu = [
    {
      'view': const HomeView(),
      'icon': Icons.home_filled,
      'label': 'Home',
    },
    {
      'view': const MyLaundryView(),
      'icon': Icons.local_laundry_service,
      'label': 'My Laundry',
    },
    {
      'view': const AccountView(),
      'icon': Icons.account_circle,
      'label': 'Account',
    },
  ];

  static const homeCategories = [
    'All',
    'Regular',
    'Express',
    'Economical',
    'Exlusive',
  ];
}
