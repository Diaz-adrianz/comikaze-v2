import 'package:flutter/material.dart';
import 'package:mobile/style/colors.dart';
import 'package:mobile/style/texts.dart';

Widget InputIcon(TextEditingController ctrl, ValueChanged<String> changeCtrl,
    String hint, IconData iconn) {
  return TextField(
    controller: ctrl,
    onChanged: (content) {
      changeCtrl(content);
    },
    cursorColor: MyColors().PRIMARY_TINT,
    style: MyTexts().text,
    decoration: InputDecoration(
        hintStyle: MyTexts().text,
        hintText: hint,
        prefixIcon: Icon(
          iconn,
          color: MyColors().PRIMARY,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors().PRIMARY),
            borderRadius: BorderRadius.circular(16)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors().SECONDARY),
            borderRadius: BorderRadius.circular(16))),
  );
}
