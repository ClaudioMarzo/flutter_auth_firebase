import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class NotificationCustom {
  static SnackBar createSnackBar(
    String title,
    String message,
    Color backgroundColor,
    ContentType contentType,
    Duration time,
  ) {
    return SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
      duration: time,
    );
  }
}