import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/widgets/widgets.dart';
import 'package:weather/features/manage_cities/data/model/manage_city_model.dart';
import 'package:weather/features/manage_cities/domain/usecase/manage_city_usecase.dart';

part 'manage_city_state.dart';

class ManageCityCubit extends Cubit<ManageCityState> {
  ManageCityCubit({
    required this.addCityUsecase,
    required this.getCitiesUseCase,
    required this.deleteCityUsecase,
  }) : super(ManageCityInitial());
  final AddCityUsecase addCityUsecase;
  final GetCityUseCase getCitiesUseCase;
  final DeleteCityUsecase deleteCityUsecase;

  void addCity({
    required String city,
    required String image,
    required String temp,
  }) async {
    await addCityUsecase
        .call(AddCityParam(city: city, image: image, temp: temp));
  }

  void getCity() async {
    emit(ManageCityLoading());
    final result = await getCitiesUseCase.call(NoParam());
    result.fold((model) => emit(ManageCitySucess(model)),
        (failure) => emit(ManageCityFailure(failure.message)));
  }

  void deleteCity(BuildContext context, String city) async {
    final result = await deleteCityUsecase.call(CityParam(city));
    result.fold((isDeleted) {
      showMessage(context, "Removed sucessfully");
      getCity();
    }, (failure) {
      showMessage(context, failure.message);
    });
  }
}
