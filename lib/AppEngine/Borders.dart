import 'package:flutter/material.dart';

InputBorder appOutlineBorder(color) {
  return UnderlineInputBorder(
    borderSide: BorderSide(
      width: 1.0,
      style: BorderStyle.solid,
      color: color,
    ),
  );
}

InputBorder appOutlineBorder2() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.5,
      style: BorderStyle.solid,
      color: Colors.transparent,
    ),
    borderRadius: const BorderRadius.all(
      const Radius.circular(100),
    ),
  );
}
