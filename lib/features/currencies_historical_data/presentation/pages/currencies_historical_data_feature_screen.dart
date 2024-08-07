// lib/features/currencies_historical_data/presentation/pages/currencies_historical_data_feature_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/historical_data_bloc.dart';
import '../manager/historical_data_events.dart';
import '../manager/historical_data_states.dart';

class CurrenciesHistoricalDataFeatureScreen extends StatelessWidget {
  final String currencyPair1;
  final String currencyPair2;

  const CurrenciesHistoricalDataFeatureScreen({
    required this.currencyPair1,
    required this.currencyPair2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currencies Historical Data'),
        automaticallyImplyLeading: true, // Ensure the back button is shown
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<HistoricalDataBloc>(context),
        child: CurrenciesHistoricalDataView(currencyPair1: currencyPair1, currencyPair2: currencyPair2),
      ),
    );
  }
}

class CurrenciesHistoricalDataView extends StatefulWidget {
  final String currencyPair1;
  final String currencyPair2;

  const CurrenciesHistoricalDataView({
    required this.currencyPair1,
    required this.currencyPair2,
    super.key,
  });

  @override
  _CurrenciesHistoricalDataViewState createState() => _CurrenciesHistoricalDataViewState();
}

class _CurrenciesHistoricalDataViewState extends State<CurrenciesHistoricalDataView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HistoricalDataBloc>().add(GetHistoricalDataEvent(widget.currencyPair1, widget.currencyPair2));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoricalDataBloc, HistoricalDataState>(
      builder: (context, state) {
        if (state is HistoricalDataLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HistoricalDataLoaded) {
          // Display historical data
          return ListView(
            children: state.historicalData.map((data) {
              return ListTile(
                title: Text('${data.date}: ${data.rate}'),
              );
            }).toList(),
          );
        } else if (state is HistoricalDataError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('No historical data found'));
        }
      },
    );
  }
}
