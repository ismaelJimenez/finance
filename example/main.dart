import 'package:finance/finance.dart';

Future<void> main(List<String> arguments) async {
  final Map<String, Map<String, dynamic>> quoteRaw =
      await Finance.downloadRawQuote(
          QuoteProvider.yahoo, <String>['KO', 'GOOG']);

  print('Number of quotes retrieved: ${quoteRaw.keys.length}.');
  print(
      'Number of attributes retrieved for KO: ${quoteRaw['KO'].keys.length}.');
  print(
      'Current market price for KO: ${quoteRaw['GOOG']['regularMarketPrice']}.');
  print(
      'Number of attributes retrieved for GOOG: ${quoteRaw['GOOG'].keys.length}.');
  print(
      'Current market price for KO: ${quoteRaw['GOOG']['regularMarketPrice']}.');

  final Map<String, Map<String, dynamic>> quotePrice =
      await Finance.downloadQuotePrice(
          QuoteProvider.yahoo, <String>['KO', 'GOOG']);

  print('Number of quotes retrieved: ${quotePrice.keys.length}.');
  print(
      'Number of attributes retrieved for KO: ${quotePrice['KO'].keys.length}.');
  print('Current market price for KO: ${quotePrice['KO']['price']}.');
  print(
      'Number of attributes retrieved for GOOG: ${quotePrice['GOOG'].keys.length}.');
  print('Current market price for KO: ${quotePrice['GOOG']['price']}.');

  final Map<String, Map<String, dynamic>> cryptoQuoteRaw =
      await Finance.downloadRawQuote(
          QuoteProvider.coincap, <String>['bitcoin', 'ethereum']);

  print('Number of quotes retrieved: ${cryptoQuoteRaw.keys.length}.');
  print(
      'Number of attributes retrieved for bitcoin: ${cryptoQuoteRaw['bitcoin'].keys.length}.');
  print(
      'Current market price for bitcoin: ${cryptoQuoteRaw['bitcoin']['priceUsd']}.');
  print(
      'Number of attributes retrieved for ethereum: ${cryptoQuoteRaw['ethereum'].keys.length}.');
  print(
      'Current market price for ethereum: ${cryptoQuoteRaw['ethereum']['priceUsd']}.');
}
