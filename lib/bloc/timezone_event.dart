part of 'timezone_bloc.dart';

abstract class TimezoneEvent extends Equatable {
  const TimezoneEvent();

  @override
  List<Object> get props => [];
}

class NewTimeZoneRequestEvent extends TimezoneEvent {
  final String timezone;
  NewTimeZoneRequestEvent({required this.timezone});

  @override
  List<Object> get props => [this.timezone];
}
