import 'package:flutter/material.dart';
import 'package:hagglex/AppEngine/colors.dart';

TextStyle bigHeader({Color color = AppColors.white}) {
  return TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.w700,
    color: color,
    fontFamily: "BasisGrotesquePro",
  );
}

TextStyle small(Color color) {
  return TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: color);
}

TextStyle smallBold(Color color) {
  return TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: color);
}

TextStyle regular(Color color) {
  return TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: color);
}

TextStyle regularBold(Color color) {
  return TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: color);
}

TextStyle mediumHeader(Color color) {
  return TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600, color: color);
}

TextStyle header(Color color) {
  return TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: color);
}

TextStyle textField({Color color = AppColors.white}) {
  return TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: color);
}

TextStyle buttonText({Color color = AppColors.white}) {
  return TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: color);
}

final TextStyle buttonTextPrimary = TextStyle(
    fontSize: 15.0, fontWeight: FontWeight.w500, color: AppColors.primary);

final TextStyle logoText = TextStyle(fontSize: 20.0, color: AppColors.white);
