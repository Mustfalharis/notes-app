

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../newtork/local/cache_helper.dart';

class TextUtils extends StatelessWidget {

  TextUtils({
    required this.text,
    required this.fontSize,
    this.fontWeight,
    required this.color,
    this.textDecoration,
  });
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? textDecoration;



  @override
  Widget build(BuildContext context) {
    return  Text(
      '${text!.toString()}',
      style: TextStyle(
        decoration: textDecoration,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
      ),
    );
  }

}
void showSnackBar(BuildContext context,String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
}

void shotToast({required String text, ToastStates? state,})=>Fluttertoast.showToast(
  msg:text,
  textColor: Colors.white, // message
  toastLength: Toast.LENGTH_SHORT, // length
  gravity: ToastGravity.BOTTOM,
  // backgroundColor: chooseToastColor(state),
  timeInSecForIosWeb: 5,
  fontSize: 16,// location
  // duration
);

enum ToastStates{SUCCESS,ERROR,WARNIG}

Color? chooseToastColor(ToastStates? state) {
  Color color=Colors.red;
  switch (state)
  {
    case ToastStates.SUCCESS:
      {
        color = Colors.green;
        break;
      }
    case ToastStates.ERROR:
      {
        color = Colors.red;
        break;
      }
    case ToastStates.WARNIG:
      {
        color = Colors.amber;
        break;
      }
  }
  return color;
}
