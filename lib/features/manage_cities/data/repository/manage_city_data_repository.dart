import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/manage_cities/data/model/manage_city_model.dart';
import 'package:weather/features/manage_cities/data/resource/manage_data_resource.dart';
import 'package:weather/features/manage_cities/domain/repository/manage_city_domain.dart';

class ManageCityDataRepository implements ManageCityDomain {
  ManageDataResource manageDataResource;
  ManageCityDataRepository(this.manageDataResource);

  @override
  Future<Either<bool, Failure>> addCity(
      String city, String temp, String image) async {
    try {
      return left(await manageDataResource.addCity(city, temp, image));
    } on ServerException catch (e) {
      return right(Failure(e.message));
    }
  }

  @override
  Future<Either<List<ManageCityModel>, Failure>> getCities() async {
    try {
      return Left(await manageDataResource.getCities());
    } on ServerException catch (e) {
      return Right(Failure(e.message));
    }
  }

  @override
  Future<Either<bool, Failure>> deleteCity(String city) async {
    try {
      return left(await manageDataResource.deleteCity(city));
    } on ServerException catch (e) {
      return right(Failure(e.message));
    }
  }
}
