// lib/features/supported_currencies/data/local/data_sources/local_currency_data_source.dart
import 'package:code_challenge/features/supported_currencies/domain/entities/currency.dart';

class LocalCurrencyDataSource {
  static final LocalCurrencyDataSource _instance = LocalCurrencyDataSource._internal();

  factory LocalCurrencyDataSource() {
    return _instance;
  }

  LocalCurrencyDataSource._internal();

  Future<void> cacheCurrencies(List<Currency> currencies) async {
    // Cache the list of currencies locally (e.g., using SharedPreferences or Hive)
  }
}
