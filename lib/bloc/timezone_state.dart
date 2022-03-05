part of 'timezone_bloc.dart';

abstract class TimezoneState extends Equatable {
  const TimezoneState();

  @override
  List<Object> get props => [];
}

class TimezoneInitial extends TimezoneState {}

class LoadingTimeZoneState extends TimezoneState {}

class SuccessTimeZoneState extends TimezoneState {
  final data;
  final country;
  SuccessTimeZoneState({required this.data, required this.country});

  @override
  List<Object> get props => [data, country];
}

class ErrorTimeZoneState extends TimezoneState {
  final errorMsg;

  ErrorTimeZoneState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
