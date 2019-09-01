import 'package:finance/finance.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.
class MockClient extends Mock implements http.Client {}

void main() {
  group('downloadQuotePrice/downloadRawQuote Test [Finance] - Real API', () {
    test('Yahoo', () async {
      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.yahoo, <String>['KO']);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['KO'].keys.length, 2);
    });

    test('MorningstarDe', () async {
      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.morningstarDe, <String>['0P000001BW']);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['0P000001BW'].keys.length, 2);
    });

    test('MorningstarEs', () async {
      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.morningstarEs, <String>['0P000001BW']);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['0P000001BW'].keys.length, 2);
    });

    test('CoinMarketCap', () async {
      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.coinmarketcap, <String>['BTC']);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['BTC'].keys.length, 2);
    });

    test('Coincap', () async {
      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.coincap, <String>['bitcoin']);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['bitcoin'].keys.length, 2);
    });
  });
}
