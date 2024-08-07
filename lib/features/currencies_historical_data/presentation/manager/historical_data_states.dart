import 'package:code_challenge/features/currencies_historical_data/domain/entities/currenciesHistoricalDataModel.dart';
import 'package:equatable/equatable.dart';

abstract class HistoricalDataState extends Equatable {
  const HistoricalDataState();

  @override
  List<Object> get props => [];
}

class HistoricalDataInitial extends HistoricalDataState {}

class HistoricalDataLoading extends HistoricalDataState {}

class HistoricalDataLoaded extends HistoricalDataState {
  final List<HistoricalData> historicalData;

  const HistoricalDataLoaded({required this.historicalData});

  @override
  List<Object> get props => [historicalData];
}

class HistoricalDataError extends HistoricalDataState {
  final String message;

  const HistoricalDataError({required this.message});

  @override
  List<Object> get props => [message];
}
