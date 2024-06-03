import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/core/usecases/usecase.dart';
import 'package:weather/features/manage_cities/data/model/manage_city_model.dart';
import 'package:weather/features/manage_cities/domain/repository/manage_city_domain.dart';

class AddCityUsecase implements UseCase<bool, AddCityParam> {
  ManageCityDomain manageCityDomain;
  AddCityUsecase(this.manageCityDomain);

  @override
  Future<Either<bool, Failure>> call(AddCityParam params) async {
    return await manageCityDomain.addCity(
        params.city, params.temp, params.image);
  }
}

class GetCityUseCase implements UseCase<List<ManageCityModel>, NoParam> {
  ManageCityDomain manageCityDomain;
  GetCityUseCase(this.manageCityDomain);
  @override
  Future<Either<List<ManageCityModel>, Failure>> call(NoParam params) async {
    return await manageCityDomain.getCities();
  }
}

class DeleteCityUsecase implements UseCase<bool, CityParam> {
  ManageCityDomain manageCityDomain;
  DeleteCityUsecase(this.manageCityDomain);

  @override
  Future<Either<bool, Failure>> call(CityParam params) async {
    return await manageCityDomain.deleteCity(params.city);
  }
}

class CityParam {
  final String city;
  CityParam(this.city);
}

class NoParam {}

class AddCityParam {
  final String city;
  final String temp;
  final String image;

  AddCityParam({
    required this.city,
    required this.image,
    required this.temp,
  });
}
