import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_1/utilities/api_data.dart';

import '../bloc/quote_bloc.dart';

class FrontLayer extends StatelessWidget {
  final String? hour;
  final String? country;

  FrontLayer({required this.hour, required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            this.country != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${this.country}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  )
                : Text(""),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(
                this.hour != null ? "${this.hour}" : "13:45:49",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 64.0),
                child: Center(
                  child: BlocConsumer<QuoteBloc, QuoteState>(
                    listener: (context, state) {
                      if (state is LoadingQuoteState) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text("Cargando"),
                            ),
                          );
                      } else if (state is ErrorQuoteState) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text("Error"),
                            ),
                          );
                      }
                    },
                    builder: (context, state) {
                      if (state is SuccessQuoteState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${state.data[0]["q"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                            Text(
                              "- ${state.data[0]["a"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        );
                      } else if (state is LoadingQuoteState) {
                        return CircularProgressIndicator();
                      } else {
                        return Text(
                          "Error while getting data :(",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: NetworkImage(ApiData.getImageApi()),
          fit: BoxFit.cover,
          alignment: Alignment.center,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.dstATop,
          ),
        ),
      ),
    );
  }
}
