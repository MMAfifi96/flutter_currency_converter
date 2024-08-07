// lib/features/currencies_historical_data/domain/entities/historical_data.dart
import 'package:equatable/equatable.dart';

class HistoricalData extends Equatable {
  final String date;
  final double rate;

  HistoricalData({required this.date, required this.rate});

  @override
  List<Object> get props => [date, rate];

  factory HistoricalData.fromJson(Map<String, dynamic> json) {
    return HistoricalData(
      date: json['date'],
      rate: json['rate'].toDouble(),
    );
  }
}
