// lib/features/currencies_historical_data/data/data_sources/remote_historical_data_source.dart
import 'package:code_challenge/features/currencies_historical_data/domain/entities/currenciesHistoricalDataModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoteHistoricalDataSource {
  final http.Client client;

  RemoteHistoricalDataSource(this.client);

  Future<List<HistoricalData>> fetchHistoricalData(String currencyPair1, String currencyPair2) async {
    final response = await client.get(
      Uri.parse('https://free.currencyconverterapi.com/api/v6/convert?q=${currencyPair1},${currencyPair2}&compact=ultra&apiKey=0cb1978675179485354b'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<HistoricalData> historicalData = [];

      // Parse the response correctly
      data.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          value.forEach((date, rate) {
            historicalData.add(HistoricalData(date: date, rate: rate.toDouble()));
          });
        } else if (value is double) {
          historicalData.add(HistoricalData(date: key, rate: value));
        }
      });

      return historicalData;
    } else {
      throw Exception('Failed to load historical data');
    }
  }
}
