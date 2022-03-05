import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteInitial()) {
    on<QuoteEvent>(onNewRequest);
  }

  void onNewRequest(event, emit) async {
    emit(LoadingQuoteState());
    var body = await _getData();
    if (body != null) {
      emit(SuccessQuoteState(data: body));
    } else {
      emit(ErrorQuoteState(errorMsg: "Error while getting data"));
    }
  }

  Future _getData() async {
    final String url = "https://zenquotes.io/api/random";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
