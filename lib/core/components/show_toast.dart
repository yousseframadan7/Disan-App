import 'package:another_flushbar/flushbar.dart';
import 'package:disan/app/my_app.dart';
import 'package:flutter/material.dart';

void showToast( String message) {
  Flushbar(
    message: message,
    duration: Duration(seconds: 2),
    margin: EdgeInsets.all(12),
    borderRadius: BorderRadius.circular(8),
    backgroundColor: Colors.black87,
    messageColor: Colors.white,
    flushbarPosition: FlushbarPosition.BOTTOM,
    animationDuration: Duration(milliseconds: 300),
  ).show(navigatorKey.currentState!.context);
}
