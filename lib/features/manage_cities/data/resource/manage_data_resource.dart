import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/features/manage_cities/data/model/manage_city_model.dart';

abstract interface class ManageDataResource {
  Future<bool> addCity(String city, String temp, String image);
  Future<List<ManageCityModel>> getCities();
  Future<bool> deleteCity(String city);
}

class ManageDataResourceImpl implements ManageDataResource {
  final SharedPreferences preferences;
  ManageDataResourceImpl(this.preferences);

  @override
  Future<bool> addCity(String city, String temp, String image) async {
    try {
      List<String>? cityList = preferences.getStringList("city");
      cityList ??= [];

      List<ManageCityModel> conData = await getCities();
      for (int i = 0; i < conData.length; i++) {
        if (conData[i].city == city) {
          return await editCity(city: city, temp: temp, image: image);
        }
      }
      String data = jsonEncode({"city": city, "temp": temp, "image": image});
      return await preferences.setStringList("city", [...cityList, data]);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> deleteCity(String city) async {
    try {
      List<String>? cityList = preferences.getStringList("city");
      if (cityList != null) {
        cityList.removeWhere((item) {
          var decodedItem = jsonDecode(item);
          return decodedItem['city'] == city;
        });
        await preferences.setStringList("city", cityList);
        return true;
      }
      return false;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<bool> editCity({
    required String city,
    required String temp,
    required String image,
  }) async {
    try {
      List<String>? addedCity = preferences.getStringList("city");
      addedCity ??= addedCity = [];

      List<ManageCityModel> cityList = await getCities();
      for (int i = 0; i < cityList.length; i++) {
        if (city == cityList[i].city) {
          addedCity[i] =
              jsonEncode({"city": city, "temp": temp, "image": image});
        }
      }
      return await preferences.setStringList("city", addedCity);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ManageCityModel>> getCities() async {
    try {
      List<String>? cityList = preferences.getStringList("city");
      cityList ??= cityList = [];
      return cityList
          .map((city) => ManageCityModel.fromJson(jsonDecode(city)))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
