import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/theme/app_pallete.dart';
import 'package:weather/core/widgets/widgets.dart';
import 'package:weather/features/manage_cities/presentation/cubit/manage_city_cubit.dart';
import 'package:weather/features/manage_cities/presentation/pages/manage_city.dart';
import 'package:weather/features/weather_info/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weather_info/presentation/widgets/widgets.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.appThemeColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                BlocProvider.of<ManageCityCubit>(context).getCity();
                return const ManageCity();
              }));
            },
            icon: const Icon(
              Icons.location_city,
              size: 26,
            ),
          ),
        ],
      ),
      backgroundColor: AppPallete.appThemeColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 8, right: 8, bottom: 8),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const LoadingScreen();
            }
            if (state is WeatherFailure) {
              return Center(child: ErrorPage(error: state.message));
            }
            if (state is WeatherSuccess) {
              BlocProvider.of<ManageCityCubit>(context).addCity(
                city: state.cityName,
                image: state.weatherImage,
                temp: state.temp,
              );
              return Column(
                children: [
                  ContainerBox(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.cityName,
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              "${state.temp}°C",
                              style: const TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(state.dateTime)
                          ],
                        ),
                        Image.asset(
                          state.weatherImage,
                          height: size.height / 6,
                          width: size.width / 3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ContainerBox(
                    padding: const EdgeInsets.all(16),
                    height: 200,
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.timer_sharp),
                            SizedBox(width: 10),
                            Text("HOURLY FORECAST",
                                style: TextStyle(letterSpacing: 2)),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 23,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    index == 0
                                        ? const Text("Now")
                                        : Text(state.convertTimeWithWeek(
                                            state.forecast[index].dttxt)),
                                    Image.asset(
                                        state.weatherImg(state
                                            .forecast[index].weather[0].id),
                                        height: 74,
                                        width: 88),
                                    Text(
                                        "${state.convertTemp(state.forecast[index].main.temp)}°C")
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 220,
                    child: GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 220,
                        crossAxisSpacing: 10,
                      ),
                      children: [
                        Column(
                          children: [
                            ContainerBox(
                              padding: const EdgeInsets.all(16),
                              height: 109,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        state.direction,
                                        style: const TextStyle(fontSize: 19),
                                      ),
                                      Text(
                                        "${state.speed} mph",
                                        style: const TextStyle(
                                          fontSize: 19,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            ContainerBox(
                              padding: const EdgeInsets.all(16),
                              height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${state.sunrise} sunrise",
                                        style: const TextStyle(fontSize: 19),
                                      ),
                                      Text(
                                        "${state.sunset} sunset",
                                        style: const TextStyle(fontSize: 19),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ContainerBox(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RowWidget(
                                  title: "Humidity",
                                  value: state.forecast[0].main.humidity),
                              RowWidget(
                                  title: "Feels like",
                                  value:
                                      "${state.convertTemp(state.forecast[0].main.feellike)}°C"),
                              RowWidget(
                                  title: "Visibility",
                                  value: state.forecast[0].visibility),
                              RowWidget(
                                  title: "Pressure",
                                  value: state.forecast[0].main.pressure),
                              RowWidget(
                                  title: "Ground level",
                                  value: state.forecast[0].main.grndLevel),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const ErrorPage(error: "something went wrong");
          },
        ),
      ),
    );
  }
}
