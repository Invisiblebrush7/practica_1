import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:practica_1/utilities/api_data.dart';
part 'timezone_event.dart';
part 'timezone_state.dart';

class TimezoneBloc extends Bloc<TimezoneEvent, TimezoneState> {
  TimezoneBloc() : super(TimezoneInitial()) {
    on<TimezoneEvent>(_onNewRequest);
  }
  void _onNewRequest(TimezoneEvent event, Emitter<TimezoneState> emit) async {
    emit(LoadingTimeZoneState());
    var data = await _getData(event.props[0]);
    if (data != null) {
      emit(SuccessTimeZoneState(data: data, country: event.props[1]));
    } else {
      emit(ErrorTimeZoneState(errorMsg: "Failed to get timezone"));
    }
  }

  Future _getData(region) async {
    // http://worldtimeapi.org/api/timezone/America/Mexico_City
    String url = ApiData.getTimezoneApi(region);
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
