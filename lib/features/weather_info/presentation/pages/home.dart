import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/theme/app_pallete.dart';
import 'package:weather/features/manage_cities/presentation/pages/manage_city.dart';
import 'package:weather/features/weather_info/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weather_info/presentation/pages/error.dart';
import 'package:weather/features/weather_info/presentation/widgets/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<WeatherBloc>().add(WeatherGetData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is WeatherFailure) {
          return ErrorPage(error: state.message);
        }
        if (state is WeatherSuccess) {
          return Scaffold(
            backgroundColor: AppPallete.appThemeColor,
            appBar: AppBar(
              backgroundColor: AppPallete.appThemeColor,
              centerTitle: true,
              title: Text(
                state.cityName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const ManageCity();
                      }));
                    },
                    icon: const Icon(Icons.location_city)),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
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
                                state.main,
                                style: const TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 30),
                              Text("${state.temp}°C",
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold)),
                              Text(state.dateTime)
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                state.weatherImage,
                                height: height / 6,
                                width: width / 3,
                              ),
                            ],
                          )
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
                                itemCount: state.forecast.length,
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
                ),
              ),
            ),
          );
        } else {
          return const ManageCity();
        }
      },
    );
  }
}
