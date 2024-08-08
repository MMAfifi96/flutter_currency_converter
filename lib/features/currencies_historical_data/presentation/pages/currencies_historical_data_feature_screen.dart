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
        automaticallyImplyLeading: true,
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<HistoricalDataBloc>(context),
        child: CurrenciesHistoricalDataView(
            currencyPair1: currencyPair1, currencyPair2: currencyPair2),
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
  _CurrenciesHistoricalDataViewState createState() =>
      _CurrenciesHistoricalDataViewState();
}

class _CurrenciesHistoricalDataViewState
    extends State<CurrenciesHistoricalDataView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HistoricalDataBloc>().add(
        GetHistoricalDataEvent(widget.currencyPair1, widget.currencyPair2));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoricalDataBloc, HistoricalDataState>(
      builder: (context, state) {
        if (state is HistoricalDataLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HistoricalDataLoaded) {
          final dataPair1 = state.historicalData[widget.currencyPair1] ?? [];
          final dataPair2 = state.historicalData[widget.currencyPair2] ?? [];

          print("Data Pair 1: $dataPair1");
          print("Data Pair 2: $dataPair2");

          if (dataPair1.isEmpty && dataPair2.isEmpty) {
            return Center(child: Text('No historical data found'));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.currencyPair1,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      ...dataPair1
                          .map((data) => ListTile(
                                title: Text(data.date),
                                subtitle: Text(data.rate.toString()),
                              ))
                          .toList(),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.currencyPair2,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      ...dataPair2
                          .map((data) => ListTile(
                                title: Text(data.date),
                                subtitle: Text(data.rate.toString()),
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
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
