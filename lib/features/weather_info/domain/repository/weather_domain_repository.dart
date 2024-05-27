import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/weather_info/data/models/weather_model.dart';

abstract interface class WeatherDomainRepository {
  Future<Either<String,Failure>> getLocation();
  Future<Either<WeatherModel, Failure>> getWeatherData(String city);
}
