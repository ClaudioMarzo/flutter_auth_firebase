import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class NotificationCustom {
  static void showSnackBar(BuildContext context, String title, String message, Color backgroundColor, ContentType contentType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: contentType,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
