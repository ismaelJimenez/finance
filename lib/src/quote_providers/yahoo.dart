import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Yahoo {
  static Future<Map<String, Map<String, dynamic>>> downloadRaw(
      List<String> symbols, http.Client client, Logger logger) async {
    final Map<String, Map<String, dynamic>> retrieved =
        <String, Map<String, dynamic>>{};

    try {
      final String symbolList = symbols.join(',');

      final http.Response response = await client.get(
          'https://query1.finance.yahoo.com/v7/finance/quote?symbols=' +
              symbolList);

      if (response != null && response.statusCode == 200) {
        final Map<String, dynamic> quoteData = const JsonDecoder()
            .convert(response.body)['quoteResponse'] as Map<String, dynamic>;

        // Search in the answer obtained the data corresponding to the symbols.
        // If requested symbol data is found add it to [portfolioQuotePrices].
        for (String symbol in symbols) {
          for (dynamic marketData in quoteData['result']) {
            if (marketData['symbol'] == symbol) {
              // ignore: avoid_as
              retrieved[symbol] = marketData as Map<String, dynamic>;
            }
          }
        }
      } else {
        logger
            .e('Failed to download yahoo quote data for: ' + symbols.join(','));
      }
    } catch (e) {
      logger.e(
          'Exception caught while parsing downloaded yahoo quote data for: ' +
              symbols.join(','));
    }

    return retrieved;
  }

  static Map<String, String> parsePrice(Map<String, dynamic> rawQuote) {
    return <String, String>{
      'price': (rawQuote['regularMarketPrice'] as double).toStringAsFixed(2),
      'currency': (rawQuote['currency'] as String).toUpperCase(),
    };
  }
}
