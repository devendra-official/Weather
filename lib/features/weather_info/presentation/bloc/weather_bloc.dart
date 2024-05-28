import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/features/weather_info/data/models/weather_model.dart';
import 'package:weather/features/weather_info/domain/usecases/weather_usecase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUsecase weatherUsecase;
  final GetLocationUseCase getLocationUseCase;
  final SharedPreferences preferences;
  WeatherBloc({
    required this.weatherUsecase,
    required this.getLocationUseCase,
    required this.preferences,
  }) : super(WeatherLoading()) {
    on<WeatherGetData>(_getData);
  }

  Future<void> _getData(
      WeatherGetData event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    late String? city;
    late String? error;
    city = preferences.getString("city");
    if ((event.city == null && city == null) || event.location) {
      final location = await getLocationUseCase.call(GetLocationParams());
      location.fold((value) {
        city = value;
      }, (failure) {
        error = failure.message;
      });
      if (error != null) {
        return emit(WeatherFailure(error!));
      }
    } else {
      event.city != null ? city = event.city : city;
    }
    
    final result = await weatherUsecase(WeatherParams(city: city!));
    result.fold((model) {
      Map<String, dynamic> obj = event.weatherConvert(model);
      emit(WeatherSuccess(
        direction: obj["dir"],
        speed: obj["speed"],
        cityName: obj["cityName"],
        dateTime: obj["time"],
        forecast: model.list,
        main: obj["desc"],
        sunrise: obj["sunrise"],
        sunset: obj["sunset"],
        temp: obj["temp"],
        weatherImage: obj["image"],
        weatherImg: event.weatherImg,
        convertTemp: event.temperature,
        convertTimeWithWeek: event.convertTimeWithWeek,
        convertTime: event.convertTime,
      ));
    }, (failure) => emit(WeatherFailure(failure.message)));
  }
}
