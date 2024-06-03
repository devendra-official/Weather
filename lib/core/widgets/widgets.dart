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

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/error.png", height: 158),
          const SizedBox(height: 30),
          Text(
            error,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
