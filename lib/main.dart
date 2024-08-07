import 'package:flutter/material.dart';
import 'package:code_challenge/currency_converter_app.dart';
import 'package:code_challenge/core/injection.dart' as di;
import 'package:provider/provider.dart';
import 'package:code_challenge/features/supported_currencies/domain/use_cases/get_currencies.dart';

void main() {
  di.init();
  runApp(
    const CurrencyConverterApp(),
  );
}