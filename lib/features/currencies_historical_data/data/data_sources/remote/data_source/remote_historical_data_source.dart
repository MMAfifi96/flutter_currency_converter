import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../domain/entities/currenciesHistoricalDataModel.dart';

class RemoteHistoricalDataSource {
  final http.Client client;
  final String apiKey;

  RemoteHistoricalDataSource(this.client, this.apiKey);

  Future<Map<String, List<HistoricalData>>> fetchHistoricalData(String currencyPair1, String currencyPair2) async {
    final baseUrl = 'https://api.exchangeratesapi.io/v1';
    final url1 = '$baseUrl/timeseries?access_key=$apiKey&start_date=2023-08-01&end_date=2023-08-07&base=${currencyPair1.split('_')[0]}&symbols=${currencyPair1.split('_')[1]}';
    final url2 = '$baseUrl/timeseries?access_key=$apiKey&start_date=2023-08-01&end_date=2023-08-07&base=${currencyPair2.split('_')[0]}&symbols=${currencyPair2.split('_')[1]}';
    print("Request URL 1: $url1");
    print("Request URL 2: $url2");

    final response1 = await client.get(Uri.parse(url1));
    final response2 = await client.get(Uri.parse(url2));

    if (response1.statusCode == 200 && response2.statusCode == 200) {
      final Map<String, dynamic> data1 = json.decode(response1.body);
      final Map<String, dynamic> data2 = json.decode(response2.body);
      print("Fetched Data 1: $data1");
      print("Fetched Data 2: $data2");

      Map<String, List<HistoricalData>> historicalData = {
        currencyPair1: _parseData(data1, currencyPair1),
        currencyPair2: _parseData(data2, currencyPair2),
      };

      print("Parsed Data: $historicalData");
      return historicalData;
    } else {
      print("Failed to fetch data with status code: ${response1.statusCode} and ${response2.statusCode}");
      print("Error 1: ${response1.body}");
      print("Error 2: ${response2.body}");
      throw Exception('Failed to load historical data');
    }
  }

  List<HistoricalData> _parseData(Map<String, dynamic> data, String currencyPair) {
    List<HistoricalData> historicalDataList = [];
    data['rates'].forEach((date, rates) {
      if (rates is Map<String, dynamic> && rates.containsKey(currencyPair.split('_')[1])) {
        historicalDataList.add(HistoricalData(date: date, rate: rates[currencyPair.split('_')[1]].toDouble()));
      }
    });
    return historicalDataList;
  }
}
