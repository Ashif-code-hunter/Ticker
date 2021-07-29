import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'DOGE',
  'XRP',
  'LTC',
  'XMR',
  'ETC',
  'DASH',
  'MAID',
  'REP',
  'STEEM',
];
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'Enter-Your-API-KEY ';

class CoinData {
  Future getCoinData(String selectedCurrency, String cryptoCurrency) async {
    String requestURL =
        '$coinAPIURL/$cryptoCurrency/$selectedCurrency?apikey=$apiKey';
    http.Response response = await http.get(requestURL);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice.toStringAsFixed(3);
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
