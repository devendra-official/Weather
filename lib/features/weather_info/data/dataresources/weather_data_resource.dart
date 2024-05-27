import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/secrets/private.dart';
import 'package:weather/features/weather_info/data/models/weather_model.dart';

abstract interface class WeatherDataResource {
  Future<String> getLocation();
  Future<WeatherModel> getWeatherData(String city);
}

class WeatherDataResourceImpl implements WeatherDataResource {
  final Client client;
  final SharedPreferences preferences;
  WeatherDataResourceImpl(this.client, this.preferences);

  Future<Position> determineposition() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw ServerException("Location permissions are denied");
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw ServerException(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      if (e is ServerException) {
        throw ServerException(e.message);
      }
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<String> getLocation() async {
    try {
      String geoapi = Private().geoapi;

      Position position = await determineposition();
      double lat = position.latitude;
      double lon = position.longitude;

      final uri = await client.get(Uri.parse(
          "https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$lon&lang=fr&apiKey=$geoapi"));
      final loc = jsonDecode(uri.body);
      await preferences.setString("city", loc["features"][0]["properties"]["city"]);
      return loc["features"][0]["properties"]["city"];
    } catch (e) {
      if (e is ServerException) {
        throw ServerException(e.message);
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<WeatherModel> getWeatherData(String city) async {
    try {
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
      if (e is ServerException) {
        throw ServerException(e.message);
      }
      throw ServerException("something went wrong!");
    }
  }
}
