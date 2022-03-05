import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:practica_1/bloc/quote_bloc.dart';
import 'package:practica_1/bloc/timezone_bloc.dart';
import 'package:practica_1/country.dart';
import 'package:practica_1/screens/front_layer.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<QuoteBloc>(context).add(NewQuoteRequestEvent());
    super.initState();
  }

  String hour = "1:45:15";

  List<Country> countries = [
    Country(name: "Andorra", shortName: "ad", region: "Europe/Andorra"),
    Country(name: "México", shortName: "mx", region: "America/Mexico_City"),
    Country(name: "Perú", shortName: "pr", region: "America/Lima"),
    Country(name: "Canadá", shortName: "ca", region: "America/Vancouver"),
    Country(
        name: "Argentina",
        shortName: "ar",
        region: "America/Argentina/Buenos_Aires"),
  ];

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      appBar: AppBar(
        title: Text('Frase Diaria'),
        actions: [
          BackdropToggleButton(
            icon: AnimatedIcons.list_view,
          )
        ],
      ),
      backLayer: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  maxRadius: 15.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                    "https://flagcdn.com/128x96/${countries[index].shortName}.png",
                  ),
                ),
                title: Text("${countries[index].name}"),
                onTap: () {
                  BlocProvider.of<QuoteBloc>(context)
                      .add(NewQuoteRequestEvent());
                  BlocProvider.of<TimezoneBloc>(context).add(
                    NewTimeZoneRequestEvent(
                        timezone: countries[index].region,
                        country: countries[index].name),
                  );
                },
              );
            },
          ),
        ),
      ),
      frontLayer: BlocConsumer<TimezoneBloc, TimezoneState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SuccessTimeZoneState) {
            // "2022-03-04T18:05:09.945170-03:00"
            String dateStr = "${state.data["datetime"]}".substring(11, 18);
            return FrontLayer(hour: "${dateStr}", country: state.country);
          } else {
            return FrontLayer(
              hour: null,
              country: null,
            );
          }
        },
      ),
    );
  }
}
