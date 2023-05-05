

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AuthTextFromField extends StatelessWidget {
  AuthTextFromField({
    required this.controller,
    required this.obscureText,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.onTap,

  });
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller,
      obscureText:obscureText!,
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      validator: validator,
      onTap: onTap,
      style: TextStyle(
          color: Colors.black,
      ),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        prefixIcon:prefixIcon,
        suffixIcon:suffixIcon,
        hintText:hintText,
        hintStyle: TextStyle(
          color: Colors.black45,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),

    );
  }
}
