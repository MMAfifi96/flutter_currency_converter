import 'package:bloc/bloc.dart';
import 'package:code_challenge/core/failures.dart';
import 'package:code_challenge/features/currencies_historical_data/domain/use_cases/get_historical_data.dart';
import 'package:code_challenge/features/currencies_historical_data/presentation/manager/historical_data_events.dart';
import 'package:code_challenge/features/currencies_historical_data/presentation/manager/historical_data_states.dart';

class HistoricalDataBloc extends Bloc<HistoricalDataEvent, HistoricalDataState> {
  final GetHistoricalData getHistoricalData;

  HistoricalDataBloc({required this.getHistoricalData}) : super(HistoricalDataInitial()) {
    on<GetHistoricalDataEvent>(_onGetHistoricalData);
  }

  Future<void> _onGetHistoricalData(
      GetHistoricalDataEvent event,
      Emitter<HistoricalDataState> emit,
      ) async {
    emit(HistoricalDataLoading());
    final failureOrData = await getHistoricalData(event.currencyPair1, event.currencyPair2);
    emit(failureOrData.fold(
          (failure) => HistoricalDataError(message: _mapFailureToMessage(failure)),
          (data) => HistoricalDataLoaded(historicalData: data),
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    // Customize your error message based on the failure type
    return 'An error occurred';
  }
}
