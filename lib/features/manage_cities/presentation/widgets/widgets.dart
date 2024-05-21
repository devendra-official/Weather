import 'package:flutter/material.dart';

class QuickSearch extends StatelessWidget {
  const QuickSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      runSpacing: 10,
      spacing: 10,
      children: [
        FamousCity(city: "Locate", color: Colors.blue, locate: true),
        FamousCity(city: "Bengaluru"),
        FamousCity(city: "Kolkata"),
        FamousCity(city: "Delhi"),
        FamousCity(city: "Mumbai"),
        FamousCity(city: "Chennai"),
        FamousCity(city: "Pune"),
        FamousCity(city: "Patna"),
        FamousCity(city: "Chandigarh"),
        FamousCity(city: "Raipur"),
        FamousCity(city: "Jaipur"),
        FamousCity(city: "Faridabad"),
      ],
    );
  }
}

class FamousCity extends StatelessWidget {
  const FamousCity(
      {super.key, required this.city, this.color, this.locate = false});

  final String city;
  final Color? color;
  final bool locate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // TODO: write functionality
      onTap: () {},
      child: Chip(
        side: BorderSide.none,
        backgroundColor: Colors.black12,
        label: Text(city, style: TextStyle(color: color)),
      ),
    );
  }
}
