import 'package:flutter/material.dart';
import 'package:weather/features/manage_cities/presentation/pages/manage_city.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            child: Text(
              error,
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              )),
              onPressed: () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return const ManageCity();
                }), (context) {
                  return false;
                });
              },
              child: const Text("Search"))
        ],
      ),
    );
  }
}
