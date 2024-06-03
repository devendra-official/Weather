part of 'manage_city_cubit.dart';

@immutable
sealed class ManageCityState {}

final class ManageCityInitial extends ManageCityState {}

final class ManageCityLoading extends ManageCityState {}

final class ManageCityDeleted extends ManageCityState {}

final class ManageCitySucess extends ManageCityState {
  final List<ManageCityModel> model;
  ManageCitySucess(this.model);
}

final class ManageCityFailure extends ManageCityState {
  final String message;
  ManageCityFailure(this.message);
}
