import 'package:flutter/material.dart';
import 'package:weather/core/theme/app_pallete.dart';

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      content: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: AppPallete.notificationTextColor,
            borderRadius: BorderRadius.circular(24)),
        child: Text(message),
      ),
    ),
  );
}
