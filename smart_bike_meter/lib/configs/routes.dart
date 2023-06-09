import 'package:flutter/cupertino.dart';
import 'package:smart_bike_meter/pages/auth/login.dart';
import 'package:smart_bike_meter/pages/auth/signup.dart';
import 'package:smart_bike_meter/pages/dashboard.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  LoginScreen.routeName: (ctx) => LoginScreen(),
  SignupScreen.routeName: (ctx) => SignupScreen(),
  DashboardPage.routeName: (ctx) => const DashboardPage(),
};
