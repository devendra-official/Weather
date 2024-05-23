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
      String city = "hgdahg";
      String openweather = Private().openweather;

      Response response = await client.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$openweather"));
      // Response response = await client.get(Uri.parse("http://localhost:8080"));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(data);
      } else {
        throw ServerException(data["message"]);
      }
    } catch (e) {
      if (e is ServerException) {
        throw ServerException(e.message);
      } else {
        throw ServerException("something went wrong!");
      }
    }
  }
}
