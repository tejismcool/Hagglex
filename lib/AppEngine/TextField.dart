import 'package:flutter/material.dart';

import 'Borders.dart';
import 'Colors.dart';
import 'TextStyles.dart';

TextField searchTextField({hint = "", onChanged}) {
  return TextField(
      autocorrect: false,
      style: textField(),
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.search,
          color: AppColors.white,
          size: 20,
        ),
        hintText: hint,
        hintStyle: textField(),
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(21.0, 16, 21.0, 16.0),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: appOutlineBorder2(),
        enabledBorder: appOutlineBorder2(),
        focusedBorder: appOutlineBorder2(),
        errorBorder: appOutlineBorder2(),
        disabledBorder: appOutlineBorder2(),
      ));
}

TextField appTextField(
    {String hint = "", Color color = AppColors.white, onChanged}) {
  return TextField(
      autocorrect: false,
      style: textField(color: color),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: textField(color: color),
        isDense: true,
        contentPadding: EdgeInsets.only(bottom: 9.5),
        enabledBorder: appOutlineBorder(color),
        focusedBorder: appOutlineBorder(color),
        errorBorder: appOutlineBorder(AppColors.error),
        disabledBorder: appOutlineBorder(AppColors.grey),
      ));
}

TextFormField appFormTextField(
    {String hint = "",
    Color color = AppColors.white,
    TextInputType keytype = TextInputType.text,
    @required onSubmit,
    @required validator}) {
  return TextFormField(
      autocorrect: false,
      onSaved: onSubmit,
      validator: validator,
      keyboardType: keytype,
      style: textField(color: color),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: textField(color: color),
        isDense: true,
        contentPadding: EdgeInsets.only(bottom: 9.5),
        enabledBorder: appOutlineBorder(color),
        focusedBorder: appOutlineBorder(color),
        errorBorder: appOutlineBorder(AppColors.error),
        disabledBorder: appOutlineBorder(AppColors.grey),
      ));
}

Stack appPasswordField({hint = ""}) {
  return Stack(
    children: [
      TextField(
          autocorrect: false,
          obscureText: true,
          //style: textField,
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            contentPadding: EdgeInsets.all(15.0),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: appOutlineBorder(AppColors.primary),
            focusedBorder: appOutlineBorder(AppColors.primaryLight),
            errorBorder: appOutlineBorder(AppColors.error),
            disabledBorder: appOutlineBorder(AppColors.grey),
          )),
      Positioned(
        //top: 15,
        right: 0,
        child: IconButton(
            splashColor: Colors.white,
            icon: Icon(Icons.visibility_off),
            iconSize: 20,
            color: AppColors.grey,
            onPressed: () {
              print("blur");
            }),
      )
    ],
  );
}
