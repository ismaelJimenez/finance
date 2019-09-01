import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Coinmarketcap {
  static Future<Map<String, Map<String, dynamic>>> downloadRaw(
      List<String> symbols, http.Client client, Logger logger) async {
    int _start = 1;
    const int _searchStep = 49;
    const int _numberOfCoins = 100;
    List<String> _symbolsRetrieved;
    final Map<String, Map<String, dynamic>> retrieved =
        <String, Map<String, dynamic>>{};

    do {
      try {
        _symbolsRetrieved = <String>[];

        final http.Response response = await client.get(
            'https://api.coinmarketcap.com/v2/ticker/?start=$_start&limit=${_start + _searchStep}');

        if (response != null && response.statusCode == 200) {
          final Map<String, dynamic> quoteData = const JsonDecoder()
              .convert(response.body)['data'] as Map<String, dynamic>;

          // Search in the answer obtained the data corresponding to the symbols.
          // If requested symbol data is found add it to [portfolioQuotePrices].
          for (String symbol in symbols) {
            for (dynamic marketData in quoteData.values) {
              if (marketData['symbol'] == symbol) {
                // ignore: avoid_as
                retrieved[symbol] = marketData as Map<String, dynamic>;
                _symbolsRetrieved.add(symbol);
              }
            }
          }
        } else {
          logger.e('Failed to download coinmarketcap quote data for: ' +
              symbols.join(','));
        }
      } catch (e) {
        logger.e(
            'Exception caught while parsing downloaded coinmarketcap quote data for: ' +
                symbols.join(','));
      }
      _start += _searchStep + 1;

      _symbolsRetrieved.forEach(symbols.remove);
    } while ((_start + _searchStep <= _numberOfCoins) && symbols.isNotEmpty);
    return retrieved;
  }

  static Map<String, String> parsePrice(Map<String, dynamic> rawQuote) {
    return <String, String>{
      'price':
          (rawQuote['quotes']['USD']['price'] as double).toStringAsFixed(2),
      'currency': (rawQuote['quotes'].keys.toList()[0] as String).toUpperCase(),
    };
  }
}
