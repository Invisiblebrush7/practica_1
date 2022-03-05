import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_1/screens/home_page.dart';

import 'bloc/quote_bloc.dart';
import 'bloc/timezone_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      title: 'Material App',
      home: MultiBlocProvider(
        child: HomePage(),
        providers: [
          BlocProvider(
            create: (context) => QuoteBloc(),
          ),
          BlocProvider(
            create: (context) => TimezoneBloc(),
          ),
        ],
      ),
    );
  }
}
