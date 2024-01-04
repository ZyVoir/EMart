import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';

Widget bgWidget({Widget? child}) {
  return Stack(
    children: [
      Image.asset(
        imgBackground,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      if (child != null) Positioned.fill(child: child),
    ],
  );
}
