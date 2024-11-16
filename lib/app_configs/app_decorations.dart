import 'package:flutter/material.dart';

import 'app_colors.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppDecorations {
  static const introLinearGradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xff312A87), Color(0xff213068)]);

  static InputDecoration textFieldDecoration(BuildContext context,
      {double radius = 12}) {
    return InputDecoration(
        // fillColor: Colors.grey.shade200,
        filled: false,
        contentPadding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
        prefixIconConstraints: const BoxConstraints.tightFor(width: 64),
        labelStyle: const TextStyle(
          color: Color(0xff7e7e7e),
          fontSize: 14,
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : AppColors.borderColor,
              width: 1.2,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : AppColors.borderColor,
              width: 1.2,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.2,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : AppColors.borderColor,
              width: 1.2,
            )));
  }
}
