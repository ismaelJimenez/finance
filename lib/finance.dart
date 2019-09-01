library finance;

import 'package:finance/src/app_logger.dart';
import 'package:finance/src/quote_providers/coincap.dart';
import 'package:finance/src/quote_providers/coinmarketcap.dart';
import 'package:finance/src/quote_providers/morningstarDe.dart';
import 'package:finance/src/quote_providers/morningstarEs.dart';
import 'package:finance/src/quote_providers/yahoo.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final Logger logger = Logger(printer: AppLogger('Finance'));

enum QuoteProvider {
  yahoo,
  coincap,
  coinmarketcap,
  morningstarDe,
  morningstarEs
}

class Finance {
  /// Returns the list of symbols with the retrieved raw quotes.
  static Future<Map<String, Map<String, dynamic>>> downloadRawQuote(
      QuoteProvider quoteProvider, List<String> symbols,
      [http.Client client]) async {
    // If client is not provided, use http IO client
    client ??= http.Client();

    // Retrieved market data.
    Map<String, Map<String, dynamic>> retrievedQuoteData =
        <String, Map<String, dynamic>>{};

    switch (quoteProvider) {
      case QuoteProvider.yahoo:
        {
          retrievedQuoteData = await Yahoo.downloadRaw(symbols, client, logger);
        }
        break;
      case QuoteProvider.morningstarDe:
        {
          retrievedQuoteData =
              await MorningstarDe.downloadRaw(symbols, client, logger);
        }
        break;
      case QuoteProvider.morningstarEs:
        {
          retrievedQuoteData =
              await MorningstarEs.downloadRaw(symbols, client, logger);
        }
        break;
      case QuoteProvider.coinmarketcap:
        {
          retrievedQuoteData =
              await Coinmarketcap.downloadRaw(symbols, client, logger);
        }
        break;
      case QuoteProvider.coincap:
        {
          retrievedQuoteData =
              await Coincap.downloadRaw(symbols, client, logger);
        }
        break;
      default:
        {
          logger.e('Unknown Quote Source');
        }
        break;
    }

    return retrievedQuoteData;
  }

  /// Returns the list of symbols with the retrieved raw quotes.
  static Future<Map<String, Map<String, String>>> downloadQuotePrice(
      QuoteProvider quoteProvider, List<String> symbols,
      [http.Client client]) async {
    final Map<String, Map<String, String>> quotePrice =
        <String, Map<String, String>>{};
    final Map<String, Map<String, dynamic>> rawQuotes =
        await downloadRawQuote(quoteProvider, symbols, client);

    rawQuotes.forEach((String symbol, Map<String, dynamic> rawQuote) {
      switch (quoteProvider) {
        case QuoteProvider.yahoo:
          {
            quotePrice[symbol] = Yahoo.parsePrice(rawQuote);
          }
          break;
        case QuoteProvider.morningstarDe:
          {
            quotePrice[symbol] = MorningstarDe.parsePrice(rawQuote);
          }
          break;
        case QuoteProvider.morningstarEs:
          {
            quotePrice[symbol] = MorningstarEs.parsePrice(rawQuote);
          }
          break;
        case QuoteProvider.coinmarketcap:
          {
            quotePrice[symbol] = Coinmarketcap.parsePrice(rawQuote);
          }
          break;
        case QuoteProvider.coincap:
          {
            quotePrice[symbol] = Coincap.parsePrice(rawQuote);
          }
          break;
        default:
          {
            logger.e('Unknown Quote Source');
          }
          break;
      }
    });
    return quotePrice;
  }
}
