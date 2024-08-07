// lib/features/currencies_historical_data/domain/use_cases/get_historical_data.dart
import 'package:code_challenge/features/currencies_historical_data/data/repositories/historical%20_data_repository.dart';
import 'package:code_challenge/features/currencies_historical_data/domain/entities/currenciesHistoricalDataModel.dart';
import 'package:dartz/dartz.dart';
import 'package:code_challenge/core/failures.dart';

class GetHistoricalData {
  final HistoricalDataRepository repository;

  GetHistoricalData(this.repository);

  Future<Either<Failure, List<HistoricalData>>> call(String currencyPair1, String currencyPair2) async {
    return await repository.getHistoricalData(currencyPair1, currencyPair2);
  }
}
