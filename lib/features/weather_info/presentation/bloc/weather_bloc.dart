import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/features/weather_info/data/models/weather_model.dart';
import 'package:weather/features/weather_info/domain/usecases/weather_usecase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUsecase weatherUsecase;
  WeatherBloc(this.weatherUsecase) : super(WeatherLoading()) {
    on<WeatherGetData>(_getData);
  }

  Future<void> _getData(WeatherGetData event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final result = await weatherUsecase(WeatherParams());
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