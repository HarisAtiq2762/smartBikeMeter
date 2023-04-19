import 'package:flutter/material.dart';
import 'package:smart_bike_meter/pages/auth/login.dart';
import '../../configs/screen_size_config.dart';
import '../../widgets/buttons.dart';
import '../../widgets/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = 'signup-screen';
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController email = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController licenseNumber = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    registration() async {
      print('registring');
      try {
        final db = FirebaseFirestore.instance;
        print(email.text);
        print(password.text);
        print(age.text);
        print(licenseNumber.text);
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);
        print(userCredential.user);
        print(userCredential.user?.email);
        print(userCredential.user?.uid);
        debugPrint(userCredential.toString());
        await db.doc('users/${userCredential.user?.uid}').set({
          'email': email.text,
          'age': age.text,
          'licenseNumber': licenseNumber.text
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Registered Successfully. Please Login..',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
        // Navigator.pushNamed(context, LoginScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          debugPrint('Password Provided is too Weak');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Password Provided is too Weak',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          debugPrint('Account Already exists');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                'Account Already exists',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFields.textField(
              controller: email,
              hint: 'Enter email',
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            TextFields.textField(
              controller: password,
              hint: 'Enter password',
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            TextFields.textField(
              controller: age,
              hint: 'Enter age',
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            TextFields.textField(
              controller: licenseNumber,
              hint: 'Enter license number',
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            Buttons.neopopButton(
              onTap: () {
                registration();
              },
              title: 'Get Started',
            ),
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.02),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
