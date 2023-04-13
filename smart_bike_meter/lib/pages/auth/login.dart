import 'package:flutter/material.dart';
import 'package:smart_bike_meter/pages/auth/signup.dart';
import 'package:smart_bike_meter/pages/dashboard.dart';
import 'package:neopop/neopop.dart';

import '../../configs/screen_size_config.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('Smart Bike meter'),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.25),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter username',
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter password',
              ),
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.1),
            NeoPopTiltedButton(
              isFloating: true,
              color: Colors.blueGrey,
              floatingDelay: const Duration(microseconds: 20),
              floatingDuration: const Duration(seconds: 1),
              onTapUp: () {
                Navigator.pushNamed(context, DashboardPage.routeName);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Text('Login'),
              ),
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SignupScreen.routeName);
              },
              child: const Text('Don\'t have an account? Signup'),
            ),
            // ElevatedButton.icon(
            //   onPressed: () {
            //     Navigator.pushNamed(context, DashboardPage.routeName);
            //   },
            //   icon: const Icon(Icons.lock),
            //   label: const Text('LogIn'),
            // )
          ],
        ),
      ),
    );
  }
}
