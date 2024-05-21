import 'package:flutter/material.dart';
import 'package:weather/core/theme/app_pallete.dart';
import 'package:weather/features/weather_info/presentation/widgets/widgets.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppPallete.appThemeColor,
      appBar: AppBar(
        backgroundColor: AppPallete.appThemeColor,
        centerTitle: true,
        title: Text(
          "Hiriyur",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.location_city)),
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
                          "Clouds",
                          style: const TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        Text("37°C",
                            style: const TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold)),
                        Text("21/05/2024")
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          "assets/weather images/clouds.png",
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
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                index == 0 ? const Text("Now") : Text("week"),
                                Image.asset("assets/weather images/clouds.png",
                                    height: 74, width: 88),
                                Text("28°C")
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "NORTH",
                                    style: const TextStyle(fontSize: 19),
                                  ),
                                  Text(
                                    "43 mph",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "06:47 sunrise",
                                    style: const TextStyle(fontSize: 19),
                                  ),
                                  Text(
                                    "06:57 sunset",
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
                          RowWidget(title: "Humidity", value: "66%"),
                          RowWidget(title: "Feels like", value: "33°"),
                          RowWidget(title: "Visibility", value: "1000"),
                          RowWidget(title: "Pressure", value: "2787"),
                          RowWidget(title: "Ground level", value: "1042"),
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
  }
}
