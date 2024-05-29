import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/weather_info/data/dataresources/weather_data_resource.dart';
import 'package:weather/features/weather_info/data/models/weather_model.dart';
import 'package:weather/features/weather_info/domain/repository/weather_domain_repository.dart';

class WeatherDataRepositoryImpl implements WeatherDomainRepository {
  final WeatherDataResource weatherDataResource;
  WeatherDataRepositoryImpl(this.weatherDataResource);

  @override
  Future<Either<WeatherModel, Failure>> getWeatherData(String? city,bool locate) async {
    try {
      return left(await weatherDataResource.getWeatherData(city,locate));
    } on ServerException catch (e) {
      return right(Failure(e.message));
    }
  }
}
