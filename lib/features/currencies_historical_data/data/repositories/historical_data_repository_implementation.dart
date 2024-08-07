// lib/features/currencies_historical_data/data/repositories/historical_data_repository_impl.dart
import 'package:code_challenge/features/currencies_historical_data/data/data_sources/remote/data_source/remote_historical_data_source.dart';
import 'package:code_challenge/features/currencies_historical_data/domain/entities/currenciesHistoricalDataModel.dart';
import 'package:dartz/dartz.dart';
import 'package:code_challenge/core/failures.dart';

import 'historical _data_repository.dart';

class HistoricalDataRepositoryImpl implements HistoricalDataRepository {
  final RemoteHistoricalDataSource remoteDataSource;

  HistoricalDataRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HistoricalData>>> getHistoricalData(String currencyPair1, String currencyPair2) async {
    try {
      final data = await remoteDataSource.fetchHistoricalData(currencyPair1, currencyPair2);
      return Right(data);
    } catch (e) {
      print('Error: $e'); // Add this line to print the error
      return Left(ServerFailure('Failed to fetch historical data'));
    }
  }}
