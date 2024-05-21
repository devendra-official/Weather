// import 'package:fpdart/fpdart.dart';
// import 'package:weather/core/error/failure.dart';
// import 'package:weather/core/usecases/usecase.dart';
// import 'package:weather/features/weather_info/data/models/weather_model.dart';
// import 'package:weather/features/weather_info/domain/repository/weather_domain_repository.dart';

// class WeatherUsecase implements UseCase<WeatherModel,GetWeatherParams> {
//   final WeatherDomainRepository weatherDomainRepository;

//   WeatherUsecase(this.weatherDomainRepository);

//   @override
//   Future<Either<WeatherModel, Failure>> call(params) {
//     return weatherDomainRepository.getWeatherData();
//   }
// }
