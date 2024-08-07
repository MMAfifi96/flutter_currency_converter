import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_currencies.dart';
import '../manager/bloc/currency_event.dart';
import '../manager/bloc/currency_state.dart';
import '../manager/bloc/currency_bloc.dart';

class SupportedCurrenciesFeatureScreen extends StatelessWidget {
  const SupportedCurrenciesFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supported Currencies'),
      ),
      body: BlocProvider(
        create: (context) => CurrencyBloc(
          getCurrencies: context.read<GetCurrencies>(),
        ),
        child: SupportedCurrenciesView(),
      ),
    );
  }
}

class SupportedCurrenciesView extends StatefulWidget {
  @override
  _SupportedCurrenciesViewState createState() => _SupportedCurrenciesViewState();
}

class _SupportedCurrenciesViewState extends State<SupportedCurrenciesView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CurrencyBloc>().add(LoadSupportedCurrenciesEvent());
  }

  String getFlagUrl(String countryCode) {
    return 'https://flagcdn.com/48x36/${countryCode.toLowerCase()}.png';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        if (state is CurrencyLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CurrencyLoaded) {
          return ListView.builder(
            itemCount: state.currencies.length,
            itemBuilder: (context, index) {
              final currency = state.currencies[index];
              return ListTile(
                leading: Image.network(
                  getFlagUrl(currency.code.substring(0, 2)),
                  width: 48,
                  height: 36,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error);
                  },
                ),
                title: Text('${currency.name} (${currency.code})'),
              );
            },
          );
        } else if (state is CurrencyError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('No supported currencies found'));
        }
      },
    );
  }
}
