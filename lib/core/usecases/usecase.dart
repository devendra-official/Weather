import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/failure.dart';

abstract interface class UseCase<SuccessType,Params> {
  Future<Either<SuccessType,Failure>> call(Params params);
}