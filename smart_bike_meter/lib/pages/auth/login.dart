import 'package:flutter/material.dart';
import 'package:smart_bike_meter/pages/auth/signup.dart';
import 'package:smart_bike_meter/pages/dashboard.dart';
import 'package:smart_bike_meter/widgets/buttons.dart';
import 'package:smart_bike_meter/widgets/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../configs/screen_size_config.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login-screen';
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);

    userLogin() async {
      try {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: username.text, password: password.text);
        debugPrint(userCredential.user?.uid);
        // await _storage.write(key: 'uid', value: userCredential.user?.uid);
        // if (!mounted) return;
        Navigator.pushNamed(context, DashboardPage.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          debugPrint('No User Found for that Email');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'No User Found for that Email',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else if (e.code == 'wrong-password') {
          debugPrint('Wrong Password Provided by User');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Wrong Password Provided by User',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Smart Bike meter'),
              SizedBox(height: ScreenConfig.screenSizeHeight * 0.25),
              const SizedBox(height: 10),
              TextFields.textField(
                controller: TextEditingController(),
                hint: 'Enter username',
              ),
              SizedBox(height: ScreenConfig.screenSizeHeight * 0.04),
              TextFields.textField(
                controller: TextEditingController(),
                hint: 'Enter password',
              ),
              SizedBox(height: ScreenConfig.screenSizeHeight * 0.1),
              Buttons.neopopButton(
                onTap: () {
                  userLogin();
                },
                title: 'Let\'s Go...',
              ),
              SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SignupScreen.routeName);
                },
                child: const Text('Don\'t have an account? Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
