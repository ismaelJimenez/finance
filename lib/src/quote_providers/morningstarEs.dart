import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class MorningstarEs {
  static Future<Map<String, Map<String, dynamic>>> downloadRaw(
      List<String> symbols, http.Client client, Logger logger) async {
// Retrieved market data.
    final Map<String, Map<String, dynamic>> retrieved =
        <String, Map<String, dynamic>>{};

    final NumberFormat f = NumberFormat.decimalPattern('es_ES');

    for (String symbol in symbols) {
      try {
        final http.Response response = await client.get(
            'http://tools.morningstar.es/es/stockreport/default.aspx?id=' +
                symbol);

        if (response != null && response.statusCode == 200) {
          final Document document = parse(response.body);

          final double price = f
              .parse((document.querySelector('.price').nodes[0] as Text).data)
              .toDouble();

          final String currency =
              (document.querySelector('.priceInformation').nodes[4] as Text)
                  .data
                  .split(' | ')[1]
                  .split('\n')[0]
                  .trim();

          retrieved[symbol] = <String, String>{
            'price': price.toStringAsFixed(2),
            'currency': currency.toUpperCase(),
          };
        } else {
          logger
              .e('Failed to download morningstarEs quote data for: ' + symbol);
        }
      } catch (e) {
        logger.e(
            'Exception caught while parsing downloaded morningstarEs quote data for: ' +
                symbol);
      }
    }

    return retrieved;
  }

  static Map<String, String> parsePrice(Map<String, dynamic> rawQuote) {
    return <String, String>{
      'price': rawQuote['price'] as String,
      'currency': rawQuote['currency'] as String,
    };
  }
}
