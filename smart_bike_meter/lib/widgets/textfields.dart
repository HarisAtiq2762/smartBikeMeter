import 'package:flutter/material.dart';
import 'package:smart_bike_meter/configs/screen_size_config.dart';

class TextFields {
  static Widget textField(
      {required TextEditingController controller, required String hint}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ScreenConfig.theme.primaryColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
        ),
      ),
    );
  }
}
