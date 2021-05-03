import 'package:flutter/material.dart';

import 'TextStyles.dart';
import 'colors.dart';
import 'colors.dart';
import 'colors.dart';
import 'colors.dart';

ElevatedButton yellowButton(String text, onPressed) {
  return ElevatedButton(
    style: ButtonStyle(
        elevation: MaterialStateProperty.all(0.0),
        backgroundColor: MaterialStateProperty.all(AppColors.secondary),
        foregroundColor: MaterialStateProperty.all(AppColors.brown),
        padding:
            MaterialStateProperty.all(EdgeInsets.only(top: 20.0, bottom: 20.0)),
        textStyle: MaterialStateProperty.all(TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            fontFamily: "BasisGrotesquePro"))),
    onPressed: onPressed,
    child: Text(
      text,
      //style: buttonText(color: AppColors.brown),
    ),
  );
}

Container gradientButton(String text, onPressed) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.08, 0.7],
            colors: [AppColors.primary, AppColors.primaryLight])),
    child: clearButton(text, onPressed, color: AppColors.white),
  );
}

TextButton backButton(onPressed) {
  return TextButton(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
      shape: MaterialStateProperty.all(BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)))),
    ),
    onPressed: onPressed,
    child: Image.asset(
      "images/back_button.png",
      height: 36,
    ),
  );
}

TextButton clearButton(String text, onPressed,
    {Color color = AppColors.white}) {
  return TextButton(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: buttonText(color: color),
    ),
  );
}
