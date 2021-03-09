import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reqruit_manager/model/app/app_colors.dart';
import 'package:reqruit_manager/model/app/app_text_size.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final Icon suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function onChanged;
  final TextEditingController controller;
  final Function suffixIconTaped;
  final bool autoFocus;
  final int maxLines;

  InputTextField({
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText,
    this.autoFocus = false,
    this.onChanged,
    this.suffixIconTaped,
    this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      cursorColor: AppColors.black,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: suffixIcon,
                onPressed: suffixIconTaped,
              )
            : null,
        hintText: hintText,
        hintStyle: TextStyle(
            color: AppColors.darkGray, fontSize: AppTextSize.smallText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.darkGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            width: 2.0,
            color: AppColors.black,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      ),
    );
  }
}
