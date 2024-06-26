import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/core/usecases/usecase.dart';
import 'package:weather/features/weather_info/data/models/weather_model.dart';
import 'package:weather/features/weather_info/domain/repository/weather_domain_repository.dart';

class WeatherUsecase implements UseCase<WeatherModel, WeatherParams> {
  final WeatherDomainRepository weatherDomainRepository;
  WeatherUsecase(this.weatherDomainRepository);

  @override
  Future<Either<WeatherModel, Failure>> call(WeatherParams params) {
    return weatherDomainRepository.getWeatherData(params.city,params.locate);
  }
}

class WeatherParams {
  final String? city;
  final bool locate;

  WeatherParams({required this.city,required this.locate});
}
