import 'package:code_challenge/features/currencies_historical_data/domain/entities/currenciesHistoricalDataModel.dart';
import 'package:dartz/dartz.dart';
import 'package:code_challenge/core/failures.dart';

abstract class HistoricalDataRepository {
  Future<Either<Failure, List<HistoricalData>>> getHistoricalData(String currencyPair1, String currencyPair2);
}
