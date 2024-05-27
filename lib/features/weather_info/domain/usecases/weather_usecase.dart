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
    return weatherDomainRepository.getWeatherData(params.city);
  }
}

class GetLocationUseCase implements UseCase<String, GetLocationParams> {
  final WeatherDomainRepository weatherDomainRepository;
  GetLocationUseCase(this.weatherDomainRepository);

  @override
  Future<Either<String, Failure>> call(GetLocationParams params) {
    return weatherDomainRepository.getLocation();
  }
}

class GetLocationParams {}

class WeatherParams {
  final String city;

  WeatherParams({required this.city});
}
