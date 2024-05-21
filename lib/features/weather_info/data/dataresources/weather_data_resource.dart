import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/secrets/private.dart';
import 'package:weather/features/weather_info/data/models/weather_model.dart';

abstract interface class WeatherDataResource {
  Future<WeatherModel> getWeatherData();
}

class WeatherDataResourceImpl implements WeatherDataResource {
  final Client client;
  WeatherDataResourceImpl(this.client);

  @override
  Future<WeatherModel> getWeatherData() async {
    try {
      String city = "hiriyur";
      String openweather = Private().openweather;

      Response response = await client.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$openweather"));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(data);
      } else {
        throw ServerException(data["message"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
