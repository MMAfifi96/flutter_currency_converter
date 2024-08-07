// lib/features/supported_currencies/data/repositories/currency_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:code_challenge/features/supported_currencies/domain/entities/currency.dart';
import 'package:code_challenge/features/supported_currencies/domain/repositories/currency_repository.dart';
import 'package:code_challenge/features/supported_currencies/data/remote/data_sources/remote_currency_data_source.dart';
import 'package:code_challenge/features/supported_currencies/data/local/data_sources/local_currency_data_source.dart';

import '../../../../core/failures.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final RemoteCurrencyDataSource remoteDataSource;
  final LocalCurrencyDataSource localDataSource;

  CurrencyRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Currency>>> getSupportedCurrencies() async {
    try {
      final remoteCurrencies = await remoteDataSource.fetchCurrencies();
      await localDataSource.cacheCurrencies(remoteCurrencies);
      return Right(remoteCurrencies);
    } catch (e) {
      // Return a failure here based on your error handling logic
      return Left(ServerFailure('Failed to fetch supported currencies'));
    }
  }
}
