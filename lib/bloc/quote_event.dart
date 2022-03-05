part of 'quote_bloc.dart';

@immutable
abstract class QuoteEvent {}

class NewQuoteRequestEvent extends QuoteEvent {}
