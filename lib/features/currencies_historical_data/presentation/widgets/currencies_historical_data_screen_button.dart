import 'package:code_challenge/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:code_challenge/core/utils/app_colors.dart';
import 'package:code_challenge/shared/reusable_components/reusable_elevated_button.dart';

class CurrenciesHistoricalDataScreenButton extends StatelessWidget {
  const CurrenciesHistoricalDataScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ReusableButton(
        buttonColor: AppColors.homePageButtonBackGround,
        height: MediaQuery.sizeOf(context).height / 20,
        width: MediaQuery.sizeOf(context).width / 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Currencies Historical Data',
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.currenciesHistoricalDataPageRoute,
            arguments: {
              'currencyPair1': 'USD_EUR',
              'currencyPair2': 'GBP_USD',
            },
          );
        },
      ),
    );
  }
}
