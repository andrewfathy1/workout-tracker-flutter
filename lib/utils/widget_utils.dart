import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gympanion/views/data/constants.dart';

showFlushBar(BuildContext context, String message) {
  Flushbar(
    messageText: Text(
      message,
      style: AppTextStyles.titleLarge.copyWith(color: Colors.black87),
    ),
    duration: Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: AppColors.cardioColor,
    margin: EdgeInsets.all(12),
    borderRadius: BorderRadius.circular(12),
  ).show(context);
}

showSnackBar(BuildContext context, String message, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
          child: Text(
        message,
        style: AppTextStyles.titleLarge,
      )),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
    ),
  );
}
