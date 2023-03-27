import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Colors.dart';

Widget letters(String character, bool hidden) {
  return Container(
    height: 55,
    width: 55,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppColor.primaryColorDark,
      borderRadius: BorderRadius.circular(10),

    ),
    child: Visibility(
      visible: !hidden,
      child: Text(
        character,
        style: TextStyle(
          color: Colors.white,

          fontWeight: FontWeight.bold,
          fontSize: 35,
        ),
      ),
    ),
  );
}