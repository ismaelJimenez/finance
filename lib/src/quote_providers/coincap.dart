import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Coincap {
  static Future<Map<String, Map<String, dynamic>>> downloadRaw(
      List<String> symbols, http.Client client, Logger logger) async {
    final Map<String, Map<String, dynamic>> retrieved =
        <String, Map<String, dynamic>>{};

    for (String symbol in symbols) {
      try {
        final http.Response response =
            await client.get('https://api.coincap.io/v2/assets/' + symbol);

        if (response != null && response.statusCode == 200) {
          final Map<String, dynamic> quoteData = const JsonDecoder()
              .convert(response.body)['data'] as Map<String, dynamic>;

          if (quoteData.isNotEmpty) {
            retrieved[symbol] = quoteData;
          }
        } else {
          logger.e('Failed to download Coincap quote data for: ' + symbol);
        }
      } catch (e) {
        logger.e(
            'Exception caught while parsing downloaded Coincap quote data for: ' +
                symbol);
      }
    }

    return retrieved;
  }

  static Map<String, String> parsePrice(Map<String, dynamic> rawQuote) {
    return <String, String>{
      'price': double.parse(rawQuote['priceUsd'] as String).toStringAsFixed(2),
      'currency': 'USD',
    };
  }
}
