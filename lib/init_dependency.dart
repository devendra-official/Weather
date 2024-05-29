import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/features/weather_info/data/dataresources/weather_data_resource.dart';
import 'package:weather/features/weather_info/data/repository/weather_data_repository.dart';
import 'package:weather/features/weather_info/domain/repository/weather_domain_repository.dart';
import 'package:weather/features/weather_info/domain/usecases/weather_usecase.dart';
import 'package:weather/features/weather_info/presentation/bloc/weather_bloc.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initdependencyfun() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());
  serviceLocator.registerFactory(() => http.Client());
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => connectivityResult);
  serviceLocator.registerFactory<WeatherDataResource>(
    () => WeatherDataResourceImpl(
      client: serviceLocator(),
      connectivity: serviceLocator(),
      preferences: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<WeatherDomainRepository>(
      () => WeatherDataRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory(() => WeatherUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => WeatherBloc(
      weatherUsecase: serviceLocator(), preferences: serviceLocator()));
}
