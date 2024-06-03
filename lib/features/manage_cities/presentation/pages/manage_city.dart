import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/theme/app_pallete.dart';
import 'package:weather/core/widgets/widgets.dart';
import 'package:weather/features/manage_cities/data/model/manage_city_model.dart';
import 'package:weather/features/manage_cities/presentation/cubit/manage_city_cubit.dart';
import 'package:weather/features/manage_cities/presentation/pages/search.dart';
import 'package:weather/features/manage_cities/presentation/widgets/widgets.dart';
import 'package:weather/features/weather_info/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weather_info/presentation/pages/home.dart';

class ManageCity extends StatelessWidget {
  const ManageCity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            showDragHandle: true,
            context: context,
            builder: (context) {
              return const SearchCity();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Manage cities"),
      ),
      body: BlocBuilder<ManageCityCubit, ManageCityState>(
        builder: (context, state) {
          if (state is ManageCityLoading) {
            return const LoadingScreen();
          }
          if (state is ManageCityFailure) {
            return ErrorPage(error: state.message);
          }
          if (state is ManageCityInitial) {
            return cityMessage;
          }
          if (state is ManageCitySucess) {
            if (state.model.isEmpty) {
              return cityMessage;
            } else {
              List<ManageCityModel> model = state.model.reversed.toList();
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: model.length,
                itemBuilder: (context, index) {
                  TextStyle? style = Theme.of(context).textTheme.titleLarge;
                  return Card(
                    color: AppPallete.cardColor,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          BlocProvider.of<WeatherBloc>(context)
                              .add(WeatherGetData(city: model[index].city));
                          return const MyHomePage();
                        }));
                      },
                      title: Text(model[index].city, style: style),
                      subtitle: Text(
                        "${model[index].temp}°C",
                        style: style,
                      ),
                      trailing: Image.asset(model[index].image),
                    ),
                  );
                },
              );
            }
          }
          return const ErrorPage(
            error: "something went wrong@",
          );
        },
      ),
    );
  }
}
