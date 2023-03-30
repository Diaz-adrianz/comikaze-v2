import 'package:flutter/material.dart';

// mine
import 'package:mobile/style/colors.dart';
import 'package:mobile/style/texts.dart';

class MyInput {
  InputDecoration basic(hint) {
    return InputDecoration(
        hintStyle: MyTexts().text,
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors().PRIMARY),
            borderRadius: BorderRadius.circular(16)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors().SECONDARY),
            borderRadius: BorderRadius.circular(16)));
  }
}
