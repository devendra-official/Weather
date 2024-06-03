import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/manage_cities/data/model/manage_city_model.dart';

abstract interface class ManageCityDomain {
  Future<Either<bool, Failure>> addCity(String city, String temp, String image);
  Future<Either<bool, Failure>> deleteCity(String city);
  Future<Either<List<ManageCityModel>, Failure>> getCities();
}
