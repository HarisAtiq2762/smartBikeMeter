import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';
import '../../configs/screen_size_config.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = 'signup-screen';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter username',
              ),
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter password',
              ),
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter age',
              ),
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter license number',
              ),
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            NeoPopTiltedButton(
              isFloating: true,
              color: Colors.blueGrey,
              floatingDelay: const Duration(microseconds: 20),
              floatingDuration: const Duration(seconds: 1),
              onTapUp: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Text('Signup'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
