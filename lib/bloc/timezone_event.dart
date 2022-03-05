part of 'timezone_bloc.dart';

abstract class TimezoneEvent extends Equatable {
  const TimezoneEvent();

  @override
  List<Object> get props => [];
}

class NewTimeZoneRequestEvent extends TimezoneEvent {
  final String timezone;
  final String country;
  NewTimeZoneRequestEvent({required this.timezone, required this.country});

  @override
  List<Object> get props => [this.timezone, this.country];
}
