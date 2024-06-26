import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/theme/app_pallete.dart';
import 'package:weather/features/weather_info/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weather_info/presentation/pages/home.dart';

class QuickSearch extends StatelessWidget {
  const QuickSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      runSpacing: 4,
      spacing: 8,
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

Widget cityMessage = SizedBox(
  width: double.infinity,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("assets/images/city.png",
          height: 64, color: AppPallete.cityIconColor),
      const SizedBox(height: 18),
      const Text("No City Added!")
    ],
  ),
);

class FamousCity extends StatelessWidget {
  const FamousCity(
      {super.key, required this.city, this.color, this.locate = false});

  final String city;
  final Color? color;
  final bool locate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          BlocProvider.of<WeatherBloc>(context)
              .add(WeatherGetData(city: city, location: locate));
          return const MyHomePage();
        }), (context) {
          return false;
        });
      },
      child: Chip(
        side: BorderSide.none,
        backgroundColor: Colors.black12,
        label: Text(city, style: TextStyle(color: color)),
      ),
    );
  }
}
