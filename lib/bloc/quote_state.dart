part of 'quote_bloc.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

class QuoteInitial extends QuoteState {}

class LoadingQuoteState extends QuoteState {}

class ErrorQuoteState extends QuoteState {
  final String errorMsg;

  ErrorQuoteState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

class SuccessQuoteState extends QuoteState {
  final data;

  SuccessQuoteState({required this.data});
  @override
  List<Object> get props => [data];
}
