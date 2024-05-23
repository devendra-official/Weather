import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/manage_cities/presentation/widgets/widgets.dart';
import 'package:weather/features/weather_info/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weather_info/presentation/pages/home.dart';

class SearchCity extends StatefulWidget {
  const SearchCity({super.key});

  @override
  State<SearchCity> createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  TextEditingController search = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Text(
            "Add city",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: search,
            onSubmitted: (value) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(WeatherGetData(city: value.trim()));
                return const MyHomePage();
              }));
            },
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: "Search City",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const QuickSearch()
        ],
      ),
    );
  }
}
