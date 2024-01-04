import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customTextField(
    {String? title, String? hint, controller, required bool obscure}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(orangeColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: orangeColor,
            ),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}
