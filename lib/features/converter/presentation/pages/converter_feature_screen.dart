// lib/features/converter/presentation/pages/conversion_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/bloc/conversion_bloc.dart';
import '../manager/bloc/conversion_event.dart';
import '../manager/bloc/conversion_state.dart';

class ConverterFeatureScreen extends StatefulWidget {
  @override
  _ConverterFeatureScreenState createState() => _ConverterFeatureScreenState();
}

class _ConverterFeatureScreenState extends State<ConverterFeatureScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _fromCurrency,
              onChanged: (value) {
                setState(() {
                  _fromCurrency = value!;
                });
              },
              items: <String>['USD', 'EUR', 'GBP', 'JPY']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _toCurrency,
              onChanged: (value) {
                setState(() {
                  _toCurrency = value!;
                });
              },
              items: <String>['USD', 'EUR', 'GBP', 'JPY']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_amountController.text.isEmpty ||
                    double.tryParse(_amountController.text) == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid amount')),
                  );
                } else {
                  BlocProvider.of<ConversionBloc>(context).add(
                    GetConversionRateEvent(_fromCurrency, _toCurrency),
                  );
                }
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height / 5,
              child: BlocBuilder<ConversionBloc, ConversionState>(
                builder: (context, state) {
                  if (state is ConversionLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ConversionLoaded) {
                    final amountText = _amountController.text;
                    if (amountText.isNotEmpty &&
                        double.tryParse(amountText) != null) {
                      final amount = double.parse(amountText);
                      final convertedAmount =
                          amount * state.conversionRate.rate;
                      return Text(
                        '$amount $_fromCurrency = $convertedAmount $_toCurrency',
                      );
                    } else {
                      return SizedBox();
                    }
                  } else if (state is ConversionError) {
                    return Text(state.message);
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}