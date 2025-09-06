// lib/utils/text_style.dart

import 'package:flutter/material.dart';
import 'colors.dart';

Widget headingTwo({
  required String data,
  Color? textColor,
  FontWeight? fontWeight,
}) {
  return Text(
    data,
    style: TextStyle(
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: 28,
      color: textColor ?? AppColors.whiteColor,
    ),
  );
}

Widget headingThree({
  required String data,
  Color? textColor,
  FontWeight? fontWeight,
  TextOverflow? overflow,
}) {
  return Text(
    data,
    style: TextStyle(
      fontWeight: fontWeight ?? FontWeight.w400,
      fontSize: 18, // Changed to 18 to match your design
      color: textColor ?? AppColors.whiteColor,
      overflow: overflow,
    ),
  );
}