import 'package:http/http.dart' as http;

class DataApi {
  static Future getData() {
    return http.get(
      Uri.parse('https://free.currencyconverterapi.com/'),
    );
  }
}
