import 'package:flutter/material.dart';

class FlagImage extends StatelessWidget {
  final String countryCode;

  const FlagImage({Key? key, required this.countryCode}) : super(key: key);

  String getFlagUrl() {
    return 'https://flagcdn.com/48x36/${countryCode.toLowerCase()}.png';
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      getFlagUrl(),
      width: 48,
      height: 36,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.flag);
      },
    );
  }
}
