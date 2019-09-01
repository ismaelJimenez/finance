import 'package:finance/finance.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.
class MockClient extends Mock implements http.Client {}

void main() {
  group('downloadRawQuote Test [Finance] - Yahoo', () {
    test('Yahoo: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .thenAnswer((_) async => http.Response(
              '{"quoteResponse":{"result":[{"language":"en-US","region":"US","quoteType":"EQUITY","quoteSourceName":"Nasdaq Real Time Price","currency":"USD","regularMarketPrice":53.985,"regularMarketTime":1566409386,"regularMarketChange":0.10499954,"regularMarketOpen":54.25,"regularMarketDayHigh":54.41,"regularMarketDayLow":53.94,"regularMarketVolume":2718994,"regularMarketChangePercent":0.19487666,"regularMarketDayRange":"53.94 - 54.41","regularMarketPreviousClose":53.88,"bid":54.02,"ask":54.03,"bidSize":11,"askSize":14,"messageBoardId":"finmb_26642","fullExchangeName":"NYSE","longName":"The Coca-Cola Company","financialCurrency":"USD","averageDailyVolume3Month":12406673,"averageDailyVolume10Day":11250333,"fiftyTwoWeekLowChange":9.735001,"fiftyTwoWeekLowChangePercent":0.22000001,"fiftyTwoWeekRange":"44.25 - 54.82","fiftyTwoWeekHighChange":-0.8349991,"fiftyTwoWeekHighChangePercent":-0.01523165,"fiftyTwoWeekLow":44.25,"fiftyTwoWeekHigh":54.82,"dividendDate":1569888000,"earningsTimestamp":1563899400,"earningsTimestampStart":1572280200,"earningsTimestampEnd":1572625800,"trailingAnnualDividendRate":1.58,"trailingPE":32.917683,"trailingAnnualDividendYield":0.029324425,"epsTrailingTwelveMonths":1.64,"epsForward":2.29,"esgPopulated":false,"tradeable":true,"triggerable":true,"twoHundredDayAverageChangePercent":0.09685095,"marketCap":227422601216,"market":"us_market","exchangeDataDelayedBy":0,"marketState":"REGULAR","exchange":"NYQ","shortName":"Coca-Cola Company (The)","sharesOutstanding":4266119936,"bookValue":4.253,"fiftyDayAverage":52.757942,"fiftyDayAverageChange":1.2270584,"fiftyDayAverageChangePercent":0.023258269,"twoHundredDayAverage":49.218174,"twoHundredDayAverageChange":4.7668266,"forwardPE":23.574236,"priceToBook":12.693394,"sourceInterval":15,"exchangeTimezoneName":"America/New_York","exchangeTimezoneShortName":"EDT","gmtOffSetMilliseconds":-14400000,"priceHint":2,"symbol":"KO"}],"error":null}}',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.yahoo, <String>['KO'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['KO'].keys.length, 66);
      expect(quote['KO']['symbol'], 'KO');
      expect(quote['KO']['regularMarketPrice'], 53.985);

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .called(1);
    });

    test('Yahoo: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO,GOOG,AIR.PA'))
          .thenAnswer((_) async => http.Response(
              '{"quoteResponse":{"result":[{"language":"en-US","region":"US","quoteType":"EQUITY","quoteSourceName":"Nasdaq Real Time Price","currency":"USD","market":"us_market","shortName":"Coca-Cola Company (The)","exchangeDataDelayedBy":0,"regularMarketPrice":54.75,"regularMarketTime":1566929670,"regularMarketChange":0.20999908,"regularMarketOpen":54.7,"regularMarketDayHigh":54.835,"regularMarketDayLow":54.41,"regularMarketVolume":5243563,"priceHint":2,"regularMarketChangePercent":0.3850368,"regularMarketDayRange":"54.41 - 54.835","regularMarketPreviousClose":54.54,"bid":54.75,"ask":54.76,"bidSize":8,"askSize":14,"messageBoardId":"finmb_26642","fullExchangeName":"NYSE","sharesOutstanding":4266119936,"bookValue":4.253,"fiftyDayAverage":53.009167,"fiftyDayAverageChange":1.7408333,"fiftyDayAverageChangePercent":0.03284023,"twoHundredDayAverage":49.394566,"twoHundredDayAverageChange":5.3554344,"twoHundredDayAverageChangePercent":0.108421534,"marketCap":234112647168,"forwardPE":23.908297,"priceToBook":12.873266,"sourceInterval":15,"esgPopulated":false,"tradeable":true,"triggerable":true,"marketState":"REGULAR","longName":"The Coca-Cola Company","financialCurrency":"USD","averageDailyVolume3Month":12287168,"averageDailyVolume10Day":10142433,"fiftyTwoWeekLowChange":10.5,"fiftyTwoWeekLowChangePercent":0.23728813,"fiftyTwoWeekRange":"44.25 - 54.835","fiftyTwoWeekHighChange":-0.084999084,"fiftyTwoWeekHighChangePercent":-0.0015500882,"fiftyTwoWeekLow":44.25,"fiftyTwoWeekHigh":54.835,"dividendDate":1569888000,"earningsTimestamp":1563899400,"earningsTimestampStart":1572280200,"earningsTimestampEnd":1572625800,"trailingAnnualDividendRate":1.58,"trailingPE":33.384148,"trailingAnnualDividendYield":0.028969564,"epsTrailingTwelveMonths":1.64,"epsForward":2.29,"exchangeTimezoneName":"America/New_York","exchangeTimezoneShortName":"EDT","gmtOffSetMilliseconds":-14400000,"exchange":"NYQ","symbol":"KO"},{"language":"en-US","region":"US","quoteType":"EQUITY","quoteSourceName":"Nasdaq Real Time Price","currency":"USD","market":"us_market","shortName":"Alphabet Inc.","exchangeDataDelayedBy":0,"regularMarketPrice":1163.5787,"regularMarketTime":1566929642,"regularMarketChange":-5.3112793,"regularMarketOpen":1180.53,"regularMarketDayHigh":1182.4,"regularMarketDayLow":1163.2001,"regularMarketVolume":624758,"priceHint":2,"regularMarketChangePercent":-0.45438656,"regularMarketDayRange":"1163.2001 - 1182.4","regularMarketPreviousClose":1168.89,"bid":1164.7,"ask":1165.19,"bidSize":8,"askSize":8,"messageBoardId":"finmb_29096","fullExchangeName":"NasdaqGS","sharesOutstanding":348264000,"bookValue":276.914,"fiftyDayAverage":1170.5172,"fiftyDayAverageChange":-6.9384766,"fiftyDayAverageChangePercent":-0.0059277015,"twoHundredDayAverage":1156.6758,"twoHundredDayAverageChange":6.902954,"twoHundredDayAverageChangePercent":0.005967925,"marketCap":807612121088,"forwardPE":20.856403,"priceToBook":4.2019496,"sourceInterval":15,"esgPopulated":false,"tradeable":true,"triggerable":true,"marketState":"REGULAR","longName":"Alphabet Inc.","financialCurrency":"USD","averageDailyVolume3Month":1518654,"averageDailyVolume10Day":1124733,"fiftyTwoWeekLowChange":193.46875,"fiftyTwoWeekLowChangePercent":0.1994297,"fiftyTwoWeekRange":"970.11 - 1289.27","fiftyTwoWeekHighChange":-125.691284,"fiftyTwoWeekHighChangePercent":-0.09749027,"fiftyTwoWeekLow":970.11,"fiftyTwoWeekHigh":1289.27,"trailingPE":23.490032,"epsTrailingTwelveMonths":49.535,"epsForward":55.79,"exchangeTimezoneName":"America/New_York","exchangeTimezoneShortName":"EDT","gmtOffSetMilliseconds":-14400000,"exchange":"NMS","symbol":"GOOG"},{"language":"en-US","region":"US","quoteType":"EQUITY","currency":"EUR","market":"fr_market","shortName":"AIRBUS","exchangeDataDelayedBy":0,"regularMarketPrice":122.56,"regularMarketTime":1566920121,"regularMarketChange":-0.27999878,"regularMarketOpen":122.94,"regularMarketDayHigh":123.2,"regularMarketDayLow":121.76,"regularMarketVolume":797067,"priceHint":2,"regularMarketChangePercent":-0.2279378,"regularMarketDayRange":"121.76 - 123.2","regularMarketPreviousClose":122.84,"bid":0.0,"ask":0.0,"bidSize":0,"askSize":0,"messageBoardId":"finmb_561001","fullExchangeName":"Paris","sharesOutstanding":777459968,"bookValue":9.561,"fiftyDayAverage":126.71333,"fiftyDayAverageChange":-4.1533356,"fiftyDayAverageChangePercent":-0.032777414,"twoHundredDayAverage":120.029434,"twoHundredDayAverageChange":2.5305634,"twoHundredDayAverageChangePercent":0.021082856,"marketCap":95290032128,"forwardPE":21.964157,"priceToBook":12.818743,"sourceInterval":15,"esgPopulated":false,"tradeable":false,"triggerable":false,"marketState":"POSTPOST","longName":"Airbus SE","financialCurrency":"EUR","averageDailyVolume3Month":1108838,"averageDailyVolume10Day":899513,"fiftyTwoWeekLowChange":45.059998,"fiftyTwoWeekLowChangePercent":0.58141935,"fiftyTwoWeekRange":"77.5 - 133.86","fiftyTwoWeekHighChange":-11.300003,"fiftyTwoWeekHighChangePercent":-0.084416576,"fiftyTwoWeekLow":77.5,"fiftyTwoWeekHigh":133.86,"earningsTimestamp":1572413400,"earningsTimestampStart":1550017800,"earningsTimestampEnd":1550467800,"trailingAnnualDividendRate":1.65,"trailingPE":25.48025,"trailingAnnualDividendYield":0.013432107,"epsTrailingTwelveMonths":4.81,"epsForward":5.58,"exchangeTimezoneName":"Europe/Paris","exchangeTimezoneShortName":"CEST","gmtOffSetMilliseconds":7200000,"exchange":"PAR","symbol":"AIR.PA"}],"error":null}}',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.yahoo, <String>['KO', 'GOOG', 'AIR.PA'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 3);
      expect(quote['KO'].keys.length, 66);
      expect(quote['KO']['symbol'], 'KO');
      expect(quote['KO']['regularMarketPrice'], 54.75);
      expect(quote['GOOG'].keys.length, 60);
      expect(quote['GOOG']['symbol'], 'GOOG');
      expect(quote['GOOG']['regularMarketPrice'], 1163.5787);
      expect(quote['AIR.PA'].keys.length, 64);
      expect(quote['AIR.PA']['symbol'], 'AIR.PA');
      expect(quote['AIR.PA']['regularMarketPrice'], 122.56);

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO,GOOG,AIR.PA'))
          .called(1);
    });

    test('Yahoo: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .thenAnswer((_) async => http.Response(
              '{"quoteResponse":{"result":[],"error":null}}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.yahoo, <String>['KO'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .called(1);
    });

    test('Yahoo: 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .thenAnswer((_) async => http.Response(
              '{"description":"NotFoundException: HTTP 404 Not Found","detail":{"content":["NotFoundException: HTTP 404 Not Found"]},"uri":"http://yahoo.com","lang":"en-US"}',
              404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.yahoo, <String>['KO'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .called(1);
    });
  });

  group('downloadQuotePrice Test [Finance] - Yahoo', () {
    test('Yahoo: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .thenAnswer((_) async => http.Response(
              '{"quoteResponse":{"result":[{"language":"en-US","region":"US","quoteType":"EQUITY","quoteSourceName":"Nasdaq Real Time Price","currency":"USD","regularMarketPrice":53.985,"regularMarketTime":1566409386,"regularMarketChange":0.10499954,"regularMarketOpen":54.25,"regularMarketDayHigh":54.41,"regularMarketDayLow":53.94,"regularMarketVolume":2718994,"regularMarketChangePercent":0.19487666,"regularMarketDayRange":"53.94 - 54.41","regularMarketPreviousClose":53.88,"bid":54.02,"ask":54.03,"bidSize":11,"askSize":14,"messageBoardId":"finmb_26642","fullExchangeName":"NYSE","longName":"The Coca-Cola Company","financialCurrency":"USD","averageDailyVolume3Month":12406673,"averageDailyVolume10Day":11250333,"fiftyTwoWeekLowChange":9.735001,"fiftyTwoWeekLowChangePercent":0.22000001,"fiftyTwoWeekRange":"44.25 - 54.82","fiftyTwoWeekHighChange":-0.8349991,"fiftyTwoWeekHighChangePercent":-0.01523165,"fiftyTwoWeekLow":44.25,"fiftyTwoWeekHigh":54.82,"dividendDate":1569888000,"earningsTimestamp":1563899400,"earningsTimestampStart":1572280200,"earningsTimestampEnd":1572625800,"trailingAnnualDividendRate":1.58,"trailingPE":32.917683,"trailingAnnualDividendYield":0.029324425,"epsTrailingTwelveMonths":1.64,"epsForward":2.29,"esgPopulated":false,"tradeable":true,"triggerable":true,"twoHundredDayAverageChangePercent":0.09685095,"marketCap":227422601216,"market":"us_market","exchangeDataDelayedBy":0,"marketState":"REGULAR","exchange":"NYQ","shortName":"Coca-Cola Company (The)","sharesOutstanding":4266119936,"bookValue":4.253,"fiftyDayAverage":52.757942,"fiftyDayAverageChange":1.2270584,"fiftyDayAverageChangePercent":0.023258269,"twoHundredDayAverage":49.218174,"twoHundredDayAverageChange":4.7668266,"forwardPE":23.574236,"priceToBook":12.693394,"sourceInterval":15,"exchangeTimezoneName":"America/New_York","exchangeTimezoneShortName":"EDT","gmtOffSetMilliseconds":-14400000,"priceHint":2,"symbol":"KO"}],"error":null}}',
              200));

      Map<String, Map<String, String>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.yahoo, <String>['KO'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['KO'].keys.length, 2);
      expect(quote['KO']['price'], '53.98');
      expect(quote['KO']['currency'], 'USD');

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .called(1);
    });

    test('Yahoo: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO,GOOG,AIR.PA'))
          .thenAnswer((_) async => http.Response(
              '{"quoteResponse":{"result":[{"language":"en-US","region":"US","quoteType":"EQUITY","quoteSourceName":"Nasdaq Real Time Price","currency":"USD","market":"us_market","shortName":"Coca-Cola Company (The)","exchangeDataDelayedBy":0,"regularMarketPrice":54.75,"regularMarketTime":1566929670,"regularMarketChange":0.20999908,"regularMarketOpen":54.7,"regularMarketDayHigh":54.835,"regularMarketDayLow":54.41,"regularMarketVolume":5243563,"priceHint":2,"regularMarketChangePercent":0.3850368,"regularMarketDayRange":"54.41 - 54.835","regularMarketPreviousClose":54.54,"bid":54.75,"ask":54.76,"bidSize":8,"askSize":14,"messageBoardId":"finmb_26642","fullExchangeName":"NYSE","sharesOutstanding":4266119936,"bookValue":4.253,"fiftyDayAverage":53.009167,"fiftyDayAverageChange":1.7408333,"fiftyDayAverageChangePercent":0.03284023,"twoHundredDayAverage":49.394566,"twoHundredDayAverageChange":5.3554344,"twoHundredDayAverageChangePercent":0.108421534,"marketCap":234112647168,"forwardPE":23.908297,"priceToBook":12.873266,"sourceInterval":15,"esgPopulated":false,"tradeable":true,"triggerable":true,"marketState":"REGULAR","longName":"The Coca-Cola Company","financialCurrency":"USD","averageDailyVolume3Month":12287168,"averageDailyVolume10Day":10142433,"fiftyTwoWeekLowChange":10.5,"fiftyTwoWeekLowChangePercent":0.23728813,"fiftyTwoWeekRange":"44.25 - 54.835","fiftyTwoWeekHighChange":-0.084999084,"fiftyTwoWeekHighChangePercent":-0.0015500882,"fiftyTwoWeekLow":44.25,"fiftyTwoWeekHigh":54.835,"dividendDate":1569888000,"earningsTimestamp":1563899400,"earningsTimestampStart":1572280200,"earningsTimestampEnd":1572625800,"trailingAnnualDividendRate":1.58,"trailingPE":33.384148,"trailingAnnualDividendYield":0.028969564,"epsTrailingTwelveMonths":1.64,"epsForward":2.29,"exchangeTimezoneName":"America/New_York","exchangeTimezoneShortName":"EDT","gmtOffSetMilliseconds":-14400000,"exchange":"NYQ","symbol":"KO"},{"language":"en-US","region":"US","quoteType":"EQUITY","quoteSourceName":"Nasdaq Real Time Price","currency":"USD","market":"us_market","shortName":"Alphabet Inc.","exchangeDataDelayedBy":0,"regularMarketPrice":1163.5787,"regularMarketTime":1566929642,"regularMarketChange":-5.3112793,"regularMarketOpen":1180.53,"regularMarketDayHigh":1182.4,"regularMarketDayLow":1163.2001,"regularMarketVolume":624758,"priceHint":2,"regularMarketChangePercent":-0.45438656,"regularMarketDayRange":"1163.2001 - 1182.4","regularMarketPreviousClose":1168.89,"bid":1164.7,"ask":1165.19,"bidSize":8,"askSize":8,"messageBoardId":"finmb_29096","fullExchangeName":"NasdaqGS","sharesOutstanding":348264000,"bookValue":276.914,"fiftyDayAverage":1170.5172,"fiftyDayAverageChange":-6.9384766,"fiftyDayAverageChangePercent":-0.0059277015,"twoHundredDayAverage":1156.6758,"twoHundredDayAverageChange":6.902954,"twoHundredDayAverageChangePercent":0.005967925,"marketCap":807612121088,"forwardPE":20.856403,"priceToBook":4.2019496,"sourceInterval":15,"esgPopulated":false,"tradeable":true,"triggerable":true,"marketState":"REGULAR","longName":"Alphabet Inc.","financialCurrency":"USD","averageDailyVolume3Month":1518654,"averageDailyVolume10Day":1124733,"fiftyTwoWeekLowChange":193.46875,"fiftyTwoWeekLowChangePercent":0.1994297,"fiftyTwoWeekRange":"970.11 - 1289.27","fiftyTwoWeekHighChange":-125.691284,"fiftyTwoWeekHighChangePercent":-0.09749027,"fiftyTwoWeekLow":970.11,"fiftyTwoWeekHigh":1289.27,"trailingPE":23.490032,"epsTrailingTwelveMonths":49.535,"epsForward":55.79,"exchangeTimezoneName":"America/New_York","exchangeTimezoneShortName":"EDT","gmtOffSetMilliseconds":-14400000,"exchange":"NMS","symbol":"GOOG"},{"language":"en-US","region":"US","quoteType":"EQUITY","currency":"EUR","market":"fr_market","shortName":"AIRBUS","exchangeDataDelayedBy":0,"regularMarketPrice":122.56,"regularMarketTime":1566920121,"regularMarketChange":-0.27999878,"regularMarketOpen":122.94,"regularMarketDayHigh":123.2,"regularMarketDayLow":121.76,"regularMarketVolume":797067,"priceHint":2,"regularMarketChangePercent":-0.2279378,"regularMarketDayRange":"121.76 - 123.2","regularMarketPreviousClose":122.84,"bid":0.0,"ask":0.0,"bidSize":0,"askSize":0,"messageBoardId":"finmb_561001","fullExchangeName":"Paris","sharesOutstanding":777459968,"bookValue":9.561,"fiftyDayAverage":126.71333,"fiftyDayAverageChange":-4.1533356,"fiftyDayAverageChangePercent":-0.032777414,"twoHundredDayAverage":120.029434,"twoHundredDayAverageChange":2.5305634,"twoHundredDayAverageChangePercent":0.021082856,"marketCap":95290032128,"forwardPE":21.964157,"priceToBook":12.818743,"sourceInterval":15,"esgPopulated":false,"tradeable":false,"triggerable":false,"marketState":"POSTPOST","longName":"Airbus SE","financialCurrency":"EUR","averageDailyVolume3Month":1108838,"averageDailyVolume10Day":899513,"fiftyTwoWeekLowChange":45.059998,"fiftyTwoWeekLowChangePercent":0.58141935,"fiftyTwoWeekRange":"77.5 - 133.86","fiftyTwoWeekHighChange":-11.300003,"fiftyTwoWeekHighChangePercent":-0.084416576,"fiftyTwoWeekLow":77.5,"fiftyTwoWeekHigh":133.86,"earningsTimestamp":1572413400,"earningsTimestampStart":1550017800,"earningsTimestampEnd":1550467800,"trailingAnnualDividendRate":1.65,"trailingPE":25.48025,"trailingAnnualDividendYield":0.013432107,"epsTrailingTwelveMonths":4.81,"epsForward":5.58,"exchangeTimezoneName":"Europe/Paris","exchangeTimezoneShortName":"CEST","gmtOffSetMilliseconds":7200000,"exchange":"PAR","symbol":"AIR.PA"}],"error":null}}',
              200));

      Map<String, Map<String, String>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.yahoo, <String>['KO', 'GOOG', 'AIR.PA'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 3);
      expect(quote['KO'].keys.length, 2);
      expect(quote['KO']['price'], '54.75');
      expect(quote['KO']['currency'], 'USD');
      expect(quote['GOOG'].keys.length, 2);
      expect(quote['GOOG']['price'], '1163.58');
      expect(quote['GOOG']['currency'], 'USD');
      expect(quote['AIR.PA'].keys.length, 2);
      expect(quote['AIR.PA']['price'], '122.56');
      expect(quote['AIR.PA']['currency'], 'EUR');

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO,GOOG,AIR.PA'))
          .called(1);
    });

    test('Yahoo: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .thenAnswer((_) async => http.Response(
              '{"quoteResponse":{"result":[],"error":null}}', 200));

      Map<String, Map<String, String>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.yahoo, <String>['KO'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .called(1);
    });

    test('Yahoo: 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .thenAnswer((_) async => http.Response(
              '{"description":"NotFoundException: HTTP 404 Not Found","detail":{"content":["NotFoundException: HTTP 404 Not Found"]},"uri":"http://yahoo.com","lang":"en-US"}',
              404));

      Map<String, Map<String, String>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.yahoo, <String>['KO'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .called(1);
    });
  });

  group('downloadRawQuote Test [Finance] - MorningstarDe', () {
    test('MorningstarDe: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">55,04</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.morningstarDe, <String>['0P000001BW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['0P000001BW'].keys.length, 2);
      expect(quote['0P000001BW']['price'], '55.04');
      expect(quote['0P000001BW']['currency'], 'USD');

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });

    test('MorningstarDe: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">55,04</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00012BBI'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">1.188,10</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00009QPB'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">125,30</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | EUR ',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(QuoteProvider.morningstarDe,
            <String>['0P000001BW', '0P00012BBI', '0P00009QPB'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 3);
      expect(quote['0P000001BW'].keys.length, 2);
      expect(quote['0P000001BW']['price'], '55.04');
      expect(quote['0P000001BW']['currency'], 'USD');
      expect(quote['0P00012BBI'].keys.length, 2);
      expect(quote['0P00012BBI']['price'], '1188.10');
      expect(quote['0P00012BBI']['currency'], 'USD');
      expect(quote['0P00009QPB'].keys.length, 2);
      expect(quote['0P00009QPB']['price'], '125.30');
      expect(quote['0P00009QPB']['currency'], 'EUR');

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00012BBI'))
          .called(1);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00009QPB'))
          .called(1);
    });

    test('MorningstarDe: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response('', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.morningstarDe, <String>['0P000001BW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });

    test('MorningstarDe: 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response('', 404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.morningstarDe, <String>['0P000001BW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });
  });

  group('downloadQuotePrice Test [Finance] - MorningstarDe', () {
    test('MorningstarDe: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">55,04</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.morningstarDe, <String>['0P000001BW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['0P000001BW'].keys.length, 2);
      expect(quote['0P000001BW']['price'], '55.04');
      expect(quote['0P000001BW']['currency'], 'USD');

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });

    test('MorningstarDe: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">55,04</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00012BBI'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">1.188,10</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00009QPB'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">125,30</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | EUR ',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(QuoteProvider.morningstarDe,
            <String>['0P000001BW', '0P00012BBI', '0P00009QPB'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 3);
      expect(quote['0P000001BW'].keys.length, 2);
      expect(quote['0P000001BW']['price'], '55.04');
      expect(quote['0P000001BW']['currency'], 'USD');
      expect(quote['0P00012BBI'].keys.length, 2);
      expect(quote['0P00012BBI']['price'], '1188.10');
      expect(quote['0P00012BBI']['currency'], 'USD');
      expect(quote['0P00009QPB'].keys.length, 2);
      expect(quote['0P00009QPB']['price'], '125.30');
      expect(quote['0P00009QPB']['currency'], 'EUR');

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00012BBI'))
          .called(1);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00009QPB'))
          .called(1);
    });

    test('MorningstarDe: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response('', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.morningstarDe, <String>['0P000001BW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });

    test('MorningstarDe: 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response('', 404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.morningstarDe, <String>['0P000001BW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });
  });

  group('downloadRawQuote Test [Finance] - MorningstarEs', () {
    test('MorningstarEs: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">55,04</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.morningstarEs, <String>['0P000001BW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['0P000001BW'].keys.length, 2);
      expect(quote['0P000001BW']['price'], '55.04');
      expect(quote['0P000001BW']['currency'], 'USD');

      verify(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });

    test('MorningstarEs: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">55,04</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      when(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P00012BBI'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">1.188,10</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      when(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P00009QPB'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">125,30</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | EUR ',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(QuoteProvider.morningstarEs,
            <String>['0P000001BW', '0P00012BBI', '0P00009QPB'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 3);
      expect(quote['0P000001BW'].keys.length, 2);
      expect(quote['0P000001BW']['price'], '55.04');
      expect(quote['0P000001BW']['currency'], 'USD');
      expect(quote['0P00012BBI'].keys.length, 2);
      expect(quote['0P00012BBI']['price'], '1188.10');
      expect(quote['0P00012BBI']['currency'], 'USD');
      expect(quote['0P00009QPB'].keys.length, 2);
      expect(quote['0P00009QPB']['price'], '125.30');
      expect(quote['0P00009QPB']['currency'], 'EUR');

      verify(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .called(1);

      verify(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P00012BBI'))
          .called(1);

      verify(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P00009QPB'))
          .called(1);
    });

    test('MorningstarEs: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response('', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.morningstarEs, <String>['0P000001BW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });

    test('MorningstarEs: 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response('', 404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.morningstarEs, <String>['0P000001BW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });
  });

  group('downloadRawQuote Test [Finance] - CoinMarketCap', () {
    const String first50Coins = '''
{ "attention": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", 
    "data": {
        "1": { "id": 1, "name": "Bitcoin", "symbol": "BTC", "website_slug": "bitcoin", "rank": 1, "circulating_supply": 17909062.0, "total_supply": 17909062.0, "max_supply": 21000000.0, "quotes": { "USD": { "price": 9639.69917373, "volume_24h": 11006169341.8662, "market_cap": 172637970164.0, "percent_change_1h": 0.05, "percent_change_24h": 0.18, "percent_change_7d": -4.83 } }, "last_updated": 1567321592 }, 
        "1027": { "id": 1027, "name": "Ethereum", "symbol": "ETH", "website_slug": "ethereum", "rank": 2, "circulating_supply": 107558550.0, "total_supply": 107558550.0, "max_supply": null, "quotes": { "USD": { "price": 172.744354503, "volume_24h": 5632184548.49067, "market_cap": 18580132280.0, "percent_change_1h": 0.0, "percent_change_24h": 2.0, "percent_change_7d": -9.15 } }, "last_updated": 1567321584 }, 
        "52": { "id": 52, "name": "XRP", "symbol": "XRP", "website_slug": "ripple", "rank": 3, "circulating_supply": 42984656144.0, "total_supply": 99991362294.0, "max_supply": 100000000000.0, "quotes": { "USD": { "price": 0.2578479266, "volume_24h": 839949897.795398, "market_cap": 11083504463.0, "percent_change_1h": -0.15, "percent_change_24h": -0.0, "percent_change_7d": -5.13 } }, "last_updated": 1567321566 }, 
        "1831": { "id": 1831, "name": "Bitcoin Cash", "symbol": "BCH", "website_slug": "bitcoin-cash", "rank": 4, "circulating_supply": 17978813.0, "total_supply": 17978813.0, "max_supply": 21000000.0, "quotes": { "USD": { "price": 280.285728356, "volume_24h": 1098892132.5171, "market_cap": 5039204557.0, "percent_change_1h": -0.01, "percent_change_24h": 0.5, "percent_change_7d": -8.86 } }, "last_updated": 1567321567 }, 
        "2": { "id": 2, "name": "Litecoin", "symbol": "LTC", "website_slug": "litecoin", "rank": 5, "circulating_supply": 63157874.0, "total_supply": 63157874.0, "max_supply": 84000000.0, "quotes": { "USD": { "price": 64.9030874753, "volume_24h": 2313149619.18215, "market_cap": 4099141021.0, "percent_change_1h": 0.0, "percent_change_24h": 1.39, "percent_change_7d": -11.63 } }, "last_updated": 1567321566 }, 
        "825": { "id": 825, "name": "Tether", "symbol": "USDT", "website_slug": "tether", "rank": 6, "circulating_supply": 4007869728.0, "total_supply": 4095057493.0, "max_supply": null, "quotes": { "USD": { "price": 1.0027730256, "volume_24h": 13029279417.1742, "market_cap": 4018983653.0, "percent_change_1h": -0.03, "percent_change_24h": -0.05, "percent_change_7d": 0.03 } }, "last_updated": 1567321578 }, 
        "1839": { "id": 1839, "name": "Binance Coin", "symbol": "BNB", "website_slug": "binance-coin", "rank": 7, "circulating_supply": 155536713.0, "total_supply": 187536713.0, "max_supply": 187536713.0, "quotes": { "USD": { "price": 21.6954981833, "volume_24h": 175163700.577192, "market_cap": 3374446474.0, "percent_change_1h": -0.16, "percent_change_24h": -2.46, "percent_change_7d": -17.52 } }, "last_updated": 1567321565 }, 
        "1765": { "id": 1765, "name": "EOS", "symbol": "EOS", "website_slug": "eos", "rank": 8, "circulating_supply": 929859805.0, "total_supply": 1026559816.0, "max_supply": null, "quotes": { "USD": { "price": 3.3162341058, "volume_24h": 1177966780.96319, "market_cap": 3083632798.0, "percent_change_1h": 0.01, "percent_change_24h": 3.3, "percent_change_7d": -8.99 } }, "last_updated": 1567321568 }, 
        "3602": { "id": 3602, "name": "Bitcoin SV", "symbol": "BSV", "website_slug": "bitcoin-sv", "rank": 9, "circulating_supply": 17854986.0, "total_supply": 17854986.0, "max_supply": 21000000.0, "quotes": { "USD": { "price": 128.733879773, "volume_24h": 262364073.696393, "market_cap": 2298541589.0, "percent_change_1h": 0.07, "percent_change_24h": -0.22, "percent_change_7d": -3.25 } }, "last_updated": 1567321572 }, 
        "512": { "id": 512, "name": "Stellar", "symbol": "XLM", "website_slug": "stellar", "rank": 10, "circulating_supply": 19639376193.0, "total_supply": 105283157145.0, "max_supply": null, "quotes": { "USD": { "price": 0.063150381, "volume_24h": 82159148.6753219, "market_cap": 1240234089.0, "percent_change_1h": -0.37, "percent_change_24h": 0.75, "percent_change_7d": -9.46 } }, "last_updated": 1567321564 }, 
        "2010": { "id": 2010, "name": "Cardano", "symbol": "ADA", "website_slug": "cardano", "rank": 11, "circulating_supply": 25927070538.0, "total_supply": 31112483745.0, "max_supply": 45000000000.0, "quotes": { "USD": { "price": 0.0449502989, "volume_24h": 36500147.8310537, "market_cap": 1165429569.0, "percent_change_1h": -0.23, "percent_change_24h": -0.56, "percent_change_7d": -12.92 } }, "last_updated": 1567321564 }, 
        "328": { "id": 328, "name": "Monero", "symbol": "XMR", "website_slug": "monero", "rank": 12, "circulating_supply": 17185092.0, "total_supply": 17185092.0, "max_supply": null, "quotes": { "USD": { "price": 67.5620852528, "volume_24h": 47063372.0674461, "market_cap": 1161060642.0, "percent_change_1h": -0.04, "percent_change_24h": -0.12, "percent_change_7d": -16.13 } }, "last_updated": 1567321562 }, 
        "3957": { "id": 3957, "name": "UNUS SED LEO", "symbol": "LEO", "website_slug": "unus-sed-leo", "rank": 13, "circulating_supply": 999498893.0, "total_supply": 999498893.0, "max_supply": null, "quotes": { "USD": { "price": 1.1417797649, "volume_24h": 5746133.99481908, "market_cap": 1141207611.0, "percent_change_1h": 0.06, "percent_change_24h": 0.1, "percent_change_7d": -3.47 } }, "last_updated": 1567321573 }, 
        "1958": { "id": 1958, "name": "TRON", "symbol": "TRX", "website_slug": "tron", "rank": 14, "circulating_supply": 66682072191.0, "total_supply": 99281283754.0, "max_supply": null, "quotes": { "USD": { "price": 0.0155420937, "volume_24h": 461015424.583107, "market_cap": 1036379016.0, "percent_change_1h": -0.06, "percent_change_24h": -0.1, "percent_change_7d": -13.52 } }, "last_updated": 1567321566 }, 
        "2502": { "id": 2502, "name": "Huobi Token", "symbol": "HT", "website_slug": "huobi-token", "rank": 15, "circulating_supply": 245880576.0, "total_supply": 500000000.0, "max_supply": null, "quotes": { "USD": { "price": 3.9055706304, "volume_24h": 59514519.9821509, "market_cap": 960303956.0, "percent_change_1h": -0.01, "percent_change_24h": 1.11, "percent_change_7d": -18.7 } }, "last_updated": 1567321567 }, 
        "131": { "id": 131, "name": "Dash", "symbol": "DASH", "website_slug": "dash", "rank": 16, "circulating_supply": 9015502.0, "total_supply": 9015502.0, "max_supply": 18900000.0, "quotes": { "USD": { "price": 80.2612639794, "volume_24h": 202270769.476056, "market_cap": 723595600.0, "percent_change_1h": 0.2, "percent_change_24h": 0.15, "percent_change_7d": -13.08 } }, "last_updated": 1567321563 }, 
        "1321": { "id": 1321, "name": "Ethereum Classic", "symbol": "ETC", "website_slug": "ethereum-classic", "rank": 17, "circulating_supply": 113128277.0, "total_supply": 113128277.0, "max_supply": 210000000.0, "quotes": { "USD": { "price": 6.2704752926, "volume_24h": 567814757.245327, "market_cap": 709368066.0, "percent_change_1h": -0.01, "percent_change_24h": -0.28, "percent_change_7d": -11.75 } }, "last_updated": 1567321564 }, 
        "2011": { "id": 2011, "name": "Tezos", "symbol": "XTZ", "website_slug": "tezos", "rank": 18, "circulating_supply": 660373612.0, "total_supply": 801312599.0, "max_supply": null, "quotes": { "USD": { "price": 1.0510432864, "volume_24h": 11552530.84368, "market_cap": 694081251.0, "percent_change_1h": 0.08, "percent_change_24h": -2.11, "percent_change_7d": -8.9 } }, "last_updated": 1567321564 }, 
        "1720": { "id": 1720, "name": "IOTA", "symbol": "MIOTA", "website_slug": "iota", "rank": 19, "circulating_supply": 2779530283.0, "total_supply": 2779530283.0, "max_supply": 2779530283.0, "quotes": { "USD": { "price": 0.2480872936, "volume_24h": 4373304.27591743, "market_cap": 689566145.0, "percent_change_1h": 0.11, "percent_change_24h": -0.22, "percent_change_7d": -6.7 } }, "last_updated": 1567321563 }, 
        "1376": { "id": 1376, "name": "NEO", "symbol": "NEO", "website_slug": "neo", "rank": 20, "circulating_supply": 70538831.0, "total_supply": 100000000.0, "max_supply": 100000000.0, "quotes": { "USD": { "price": 8.8617574978, "volume_24h": 218236421.481627, "market_cap": 625098015.0, "percent_change_1h": 0.12, "percent_change_24h": 0.95, "percent_change_7d": -11.04 } }, "last_updated": 1567321564 }, 
        "1975": { "id": 1975, "name": "Chainlink", "symbol": "LINK", "website_slug": "chainlink", "rank": 21, "circulating_supply": 350000000.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 1.7811232784, "volume_24h": 47041736.7378079, "market_cap": 623393147.0, "percent_change_1h": 0.52, "percent_change_24h": -2.35, "percent_change_7d": -17.85 } }, "last_updated": 1567321564 }, 
        "1518": { "id": 1518, "name": "Maker", "symbol": "MKR", "website_slug": "maker", "rank": 22, "circulating_supply": 1000000.0, "total_supply": 1000000.0, "max_supply": null, "quotes": { "USD": { "price": 475.308975773, "volume_24h": 14760852.5575129, "market_cap": 475308976.0, "percent_change_1h": -0.29, "percent_change_24h": 0.52, "percent_change_7d": -5.39 } }, "last_updated": 1567321563 }, 
        "3408": { "id": 3408, "name": "USD Coin", "symbol": "USDC", "website_slug": "usd-coin", "rank": 23, "circulating_supply": 452413946.0, "total_supply": 453785690.0, "max_supply": null, "quotes": { "USD": { "price": 1.0015133152, "volume_24h": 84709734.6891402, "market_cap": 453098591.0, "percent_change_1h": -0.05, "percent_change_24h": -0.12, "percent_change_7d": -0.0 } }, "last_updated": 1567321571 }, 
        "873": { "id": 873, "name": "NEM", "symbol": "XEM", "website_slug": "nem", "rank": 24, "circulating_supply": 8999999999.0, "total_supply": 8999999999.0, "max_supply": null, "quotes": { "USD": { "price": 0.0486315659, "volume_24h": 6050818.98823844, "market_cap": 437684093.0, "percent_change_1h": 0.15, "percent_change_24h": -2.58, "percent_change_7d": -13.18 } }, "last_updated": 1567321562 }, 
        "3794": { "id": 3794, "name": "Cosmos", "symbol": "ATOM", "website_slug": "cosmos", "rank": 25, "circulating_supply": 190688439.0, "total_supply": 237928231.0, "max_supply": null, "quotes": { "USD": { "price": 2.0174505985, "volume_24h": 109332344.438112, "market_cap": 384704506.0, "percent_change_1h": 0.02, "percent_change_24h": -5.47, "percent_change_7d": -25.49 } }, "last_updated": 1567321574 }, 
        "2566": { "id": 2566, "name": "Ontology", "symbol": "ONT", "website_slug": "ontology", "rank": 26, "circulating_supply": 533483170.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.7099745752, "volume_24h": 38675240.8154258, "market_cap": 378759487.0, "percent_change_1h": -0.28, "percent_change_24h": -2.54, "percent_change_7d": -15.48 } }, "last_updated": 1567321568 }, 
        "3635": { "id": 3635, "name": "Crypto.com Chain", "symbol": "CRO", "website_slug": "crypto-com-chain", "rank": 27, "circulating_supply": 9363013699.0, "total_supply": 100000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0393348036, "volume_24h": 6366871.55356049, "market_cap": 368292304.0, "percent_change_1h": -1.96, "percent_change_24h": 0.55, "percent_change_7d": -8.37 } }, "last_updated": 1567321572 }, 
        "3085": { "id": 3085, "name": "INO COIN", "symbol": "INO", "website_slug": "ino-coin", "rank": 28, "circulating_supply": 180003180.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 1.8789240532, "volume_24h": 16581.231153932, "market_cap": 338212305.0, "percent_change_1h": -0.01, "percent_change_24h": -0.4, "percent_change_7d": -6.7 } }, "last_updated": 1567321570 }, 
        "1437": { "id": 1437, "name": "Zcash", "symbol": "ZEC", "website_slug": "zcash", "rank": 29, "circulating_supply": 7316594.0, "total_supply": 7316594.0, "max_supply": null, "quotes": { "USD": { "price": 45.3152052483, "volume_24h": 96160841.0952205, "market_cap": 331552947.0, "percent_change_1h": -0.08, "percent_change_24h": 1.04, "percent_change_7d": -9.81 } }, "last_updated": 1567321564 }, 
        "74": { "id": 74, "name": "Dogecoin", "symbol": "DOGE", "website_slug": "dogecoin", "rank": 30, "circulating_supply": 121023412767.0, "total_supply": 121023412767.0, "max_supply": null, "quotes": { "USD": { "price": 0.0024731731, "volume_24h": 22706731.119574, "market_cap": 299311853.0, "percent_change_1h": -0.0, "percent_change_24h": -0.03, "percent_change_7d": -9.12 } }, "last_updated": 1567321563 }, 
        "3662": { "id": 3662, "name": "HedgeTrade", "symbol": "HEDG", "website_slug": "hedgetrade", "rank": 31, "circulating_supply": 288393355.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.8860969387, "volume_24h": 477292.955305605, "market_cap": 255544469.0, "percent_change_1h": -0.19, "percent_change_24h": 0.39, "percent_change_7d": 8.56 } }, "last_updated": 1567321572 }, 
        "3704": { "id": 3704, "name": "V Systems", "symbol": "VSYS", "website_slug": "v-systems", "rank": 32, "circulating_supply": 1793659087.0, "total_supply": 3698517551.0, "max_supply": null, "quotes": { "USD": { "price": 0.1370140347, "volume_24h": 10286163.444376, "market_cap": 245756468.0, "percent_change_1h": -0.44, "percent_change_24h": -12.68, "percent_change_7d": -26.57 } }, "last_updated": 1567321573 }, 
        "1168": { "id": 1168, "name": "Decred", "symbol": "DCR", "website_slug": "decred", "rank": 33, "circulating_supply": 10320230.0, "total_supply": 10320230.0, "max_supply": 21000000.0, "quotes": { "USD": { "price": 22.9907962881, "volume_24h": 5823284.78570473, "market_cap": 237270315.0, "percent_change_1h": -0.06, "percent_change_24h": -0.18, "percent_change_7d": -7.48 } }, "last_updated": 1567321562 }, 
        "1697": { "id": 1697, "name": "Basic Attention Token", "symbol": "BAT", "website_slug": "basic-attention-token", "rank": 34, "circulating_supply": 1329225522.0, "total_supply": 1500000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1781833684, "volume_24h": 16819589.1817381, "market_cap": 236845881.0, "percent_change_1h": 0.02, "percent_change_24h": 0.15, "percent_change_7d": -11.98 } }, "last_updated": 1567321564 }, 
        "3077": { "id": 3077, "name": "VeChain", "symbol": "VET", "website_slug": "vechain", "rank": 35, "circulating_supply": 55454734800.0, "total_supply": 86712634466.0, "max_supply": null, "quotes": { "USD": { "price": 0.004077464, "volume_24h": 24706149.5272744, "market_cap": 226114685.0, "percent_change_1h": 0.03, "percent_change_24h": -2.22, "percent_change_7d": -15.45 } }, "last_updated": 1567321570 }, 
        "3916": { "id": 3916, "name": "ThoreNext", "symbol": "THX", "website_slug": "thorenext", "rank": 36, "circulating_supply": 21652254.0, "total_supply": 210000000.0, "max_supply": 210000000.0, "quotes": { "USD": { "price": 9.6240797028, "volume_24h": 199466.098539167, "market_cap": 208383018.0, "percent_change_1h": 0.03, "percent_change_24h": 0.08, "percent_change_7d": 147.2 } }, "last_updated": 1567321573 }, 
        "1684": { "id": 1684, "name": "Qtum", "symbol": "QTUM", "website_slug": "qtum", "rank": 37, "circulating_supply": 95984416.0, "total_supply": 101734436.0, "max_supply": 107822406.0, "quotes": { "USD": { "price": 2.1160064246, "volume_24h": 124093780.341369, "market_cap": 203103641.0, "percent_change_1h": 0.07, "percent_change_24h": 0.46, "percent_change_7d": -17.86 } }, "last_updated": 1567321565 }, 
        "3330": { "id": 3330, "name": "Paxos Standard Token", "symbol": "PAX", "website_slug": "paxos-standard-token", "rank": 38, "circulating_supply": 200065037.0, "total_supply": 200065117.0, "max_supply": null, "quotes": { "USD": { "price": 1.0028825111, "volume_24h": 251272489.410458, "market_cap": 200641726.0, "percent_change_1h": 0.0, "percent_change_24h": -0.0, "percent_change_7d": 0.08 } }, "last_updated": 1567321571 }, 
        "2563": { "id": 2563, "name": "TrueUSD", "symbol": "TUSD", "website_slug": "trueusd", "rank": 39, "circulating_supply": 199718110.0, "total_supply": 199718110.0, "max_supply": null, "quotes": { "USD": { "price": 1.0015410545, "volume_24h": 300045629.666058, "market_cap": 200025886.0, "percent_change_1h": -0.02, "percent_change_24h": -0.08, "percent_change_7d": -0.09 } }, "last_updated": 1567321568 }, 
        "2083": { "id": 2083, "name": "Bitcoin Gold", "symbol": "BTG", "website_slug": "bitcoin-gold", "rank": 40, "circulating_supply": 17513924.0, "total_supply": 17513924.0, "max_supply": 21000000.0, "quotes": { "USD": { "price": 10.743834904, "volume_24h": 12620199.0801744, "market_cap": 188166704.0, "percent_change_1h": -0.09, "percent_change_24h": -3.5, "percent_change_7d": -22.62 } }, "last_updated": 1567321566 }, 
        "3364": { "id": 3364, "name": "PLATINCOIN", "symbol": "PLC", "website_slug": "platincoin", "rank": 41, "circulating_supply": 5001073.0, "total_supply": 600027190.0, "max_supply": null, "quotes": { "USD": { "price": 31.1183386006, "volume_24h": 3030605.86194949, "market_cap": 155625083.0, "percent_change_1h": 0.59, "percent_change_24h": 1.26, "percent_change_7d": -2.69 } }, "last_updated": 1567321571 }, 
        "1808": { "id": 1808, "name": "OmiseGO", "symbol": "OMG", "website_slug": "omisego", "rank": 42, "circulating_supply": 140245398.0, "total_supply": 140245398.0, "max_supply": null, "quotes": { "USD": { "price": 1.1005264822, "volume_24h": 33398778.6184898, "market_cap": 154343775.0, "percent_change_1h": -0.04, "percent_change_24h": 1.74, "percent_change_7d": -14.02 } }, "last_updated": 1567321565 }, 
        "3351": { "id": 3351, "name": "ZB", "symbol": "ZB", "website_slug": "zb", "rank": 43, "circulating_supply": 463288810.0, "total_supply": 2100000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.3261431621, "volume_24h": 34916269.4937734, "market_cap": 151098477.0, "percent_change_1h": -0.03, "percent_change_24h": -0.43, "percent_change_7d": -4.87 } }, "last_updated": 1567321570 }, 
        "3144": { "id": 3144, "name": "ThoreCoin", "symbol": "THR", "website_slug": "thorecoin", "rank": 44, "circulating_supply": 86686.0, "total_supply": 100000.0, "max_supply": null, "quotes": { "USD": { "price": 1731.10197135, "volume_24h": 197975.927457662, "market_cap": 150062343.0, "percent_change_1h": 0.08, "percent_change_24h": 0.13, "percent_change_7d": -3.82 } }, "last_updated": 1567321569 }, 
        "2577": { "id": 2577, "name": "Ravencoin", "symbol": "RVN", "website_slug": "ravencoin", "rank": 45, "circulating_supply": 4321295000.0, "total_supply": 4321295000.0, "max_supply": 21000000000.0, "quotes": { "USD": { "price": 0.0312979222, "volume_24h": 5393683.01338635, "market_cap": 135247555.0, "percent_change_1h": -2.14, "percent_change_24h": -2.24, "percent_change_7d": -18.32 } }, "last_updated": 1567321568 }, 
        "1214": { "id": 1214, "name": "Lisk", "symbol": "LSK", "website_slug": "lisk", "rank": 46, "circulating_supply": 119774240.0, "total_supply": 134870653.0, "max_supply": null, "quotes": { "USD": { "price": 1.1177690613, "volume_24h": 2168637.36045072, "market_cap": 133879940.0, "percent_change_1h": 0.0, "percent_change_24h": 2.11, "percent_change_7d": -6.85 } }, "last_updated": 1567321562 }, 
        "1567": { "id": 1567, "name": "Nano", "symbol": "NANO", "website_slug": "nano", "rank": 47, "circulating_supply": 133248297.0, "total_supply": 133248297.0, "max_supply": 133248297.0, "quotes": { "USD": { "price": 0.9460421505, "volume_24h": 2124704.70400195, "market_cap": 126058506.0, "percent_change_1h": -0.6, "percent_change_24h": -2.17, "percent_change_7d": -8.79 } }, "last_updated": 1567321563 }, 
        "2087": { "id": 2087, "name": "KuCoin Shares", "symbol": "KCS", "website_slug": "kucoin-shares", "rank": 48, "circulating_supply": 88165556.0, "total_supply": 178165556.0, "max_supply": null, "quotes": { "USD": { "price": 1.3693203217, "volume_24h": 15879085.5810089, "market_cap": 120726888.0, "percent_change_1h": 0.24, "percent_change_24h": -1.75, "percent_change_7d": -10.81 } }, "last_updated": 1567321564 }, 
        "3116": { "id": 3116, "name": "Insight Chain", "symbol": "INB", "website_slug": "insight-chain", "rank": 49, "circulating_supply": 349902689.0, "total_supply": 10000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.3428095439, "volume_24h": 8879896.45754702, "market_cap": 119949981.0, "percent_change_1h": 0.18, "percent_change_24h": -1.63, "percent_change_7d": 0.93 } }, "last_updated": 1567321570 }, 
        "4030": { "id": 4030, "name": "Algorand", "symbol": "ALGO", "website_slug": "algorand", "rank": 50, "circulating_supply": 283429365.0, "total_supply": 2814701208.0, "max_supply": null, "quotes": { "USD": { "price": 0.4118276534, "volume_24h": 54118184.0287721, "market_cap": 116724050.0, "percent_change_1h": 0.11, "percent_change_24h": -2.17, "percent_change_7d": -28.29 } }, "last_updated": 1567321573 }
    }, 
    "metadata": { "timestamp": 1567321226, "warning": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", "num_cryptocurrencies": 2341, "error": null } }
''';
    const String second50Coins = '''
{ "attention": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", 
    "data": {
        "1274": { "id": 1274, "name": "Waves", "symbol": "WAVES", "website_slug": "waves", "rank": 51, "circulating_supply": 100000000.0, "total_supply": 100000000.0, "max_supply": null, "quotes": { "USD": { "price": 1.1147279745, "volume_24h": 8517749.4305706, "market_cap": 111472797.0, "percent_change_1h": 0.41, "percent_change_24h": -1.09, "percent_change_7d": -14.8 } }, "last_updated": 1567323183 }, 
        "3718": { "id": 3718, "name": "BitTorrent", "symbol": "BTT", "website_slug": "bittorrent", "rank": 52, "circulating_supply": 212116500000.0, "total_supply": 990000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0005237442, "volume_24h": 37989268.608981, "market_cap": 111094782.0, "percent_change_1h": 0.03, "percent_change_24h": -2.0, "percent_change_7d": -16.32 } }, "last_updated": 1567323192 }, 
        "2682": { "id": 2682, "name": "Holo", "symbol": "HOT", "website_slug": "holo", "rank": 53, "circulating_supply": 133214575156.0, "total_supply": 177619433541.0, "max_supply": null, "quotes": { "USD": { "price": 0.0008126105, "volume_24h": 7062769.95498654, "market_cap": 108251562.0, "percent_change_1h": 0.61, "percent_change_24h": -0.97, "percent_change_7d": -6.91 } }, "last_updated": 1567323187 }, 
        "2222": { "id": 2222, "name": "Bitcoin Diamond", "symbol": "BCD", "website_slug": "bitcoin-diamond", "rank": 54, "circulating_supply": 186492898.0, "total_supply": 189492898.0, "max_supply": 210000000.0, "quotes": { "USD": { "price": 0.5782523205, "volume_24h": 2800944.60287876, "market_cap": 107839951.0, "percent_change_1h": 0.06, "percent_change_24h": -8.11, "percent_change_7d": -19.34 } }, "last_updated": 1567323185 }, 
        "3218": { "id": 3218, "name": "Energi", "symbol": "NRG", "website_slug": "energi", "rank": 55, "circulating_supply": 20161403.0, "total_supply": 20161403.0, "max_supply": null, "quotes": { "USD": { "price": 5.2375043857, "volume_24h": 632284.719886202, "market_cap": 105595435.0, "percent_change_1h": 0.07, "percent_change_24h": -3.1, "percent_change_7d": -15.81 } }, "last_updated": 1567323189 }, 
        "2416": { "id": 2416, "name": "THETA", "symbol": "THETA", "website_slug": "theta", "rank": 56, "circulating_supply": 870502690.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1209318428, "volume_24h": 652477.295437248, "market_cap": 105271494.0, "percent_change_1h": 0.25, "percent_change_24h": 2.42, "percent_change_7d": -6.89 } }, "last_updated": 1567323186 }, 
        "3657": { "id": 3657, "name": "Lambda", "symbol": "LAMB", "website_slug": "lambda", "rank": 57, "circulating_supply": 634522659.0, "total_supply": 6000000000.0, "max_supply": 10000000000.0, "quotes": { "USD": { "price": 0.1644764262, "volume_24h": 45950518.5400265, "market_cap": 104364019.0, "percent_change_1h": -2.73, "percent_change_24h": 3.25, "percent_change_7d": -2.22 } }, "last_updated": 1567323191 }, 
        "2453": { "id": 2453, "name": "EDUCare", "symbol": "EKT", "website_slug": "educare", "rank": 58, "circulating_supply": 750000000.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1389956326, "volume_24h": 8693318.9352266, "market_cap": 104246724.0, "percent_change_1h": 0.88, "percent_change_24h": 2.91, "percent_change_7d": -0.1 } }, "last_updated": 1567323186 }, 
        "2349": { "id": 2349, "name": "Mixin", "symbol": "XIN", "website_slug": "mixin", "rank": 59, "circulating_supply": 457186.0, "total_supply": 1000000.0, "max_supply": 1000000.0, "quotes": { "USD": { "price": 222.766807412, "volume_24h": 3110168.38360125, "market_cap": 101845928.0, "percent_change_1h": -0.98, "percent_change_24h": 6.9, "percent_change_7d": -3.6 } }, "last_updated": 1567323185 }, 
        "2099": { "id": 2099, "name": "ICON", "symbol": "ICX", "website_slug": "icon", "rank": 60, "circulating_supply": 491195432.0, "total_supply": 800460000.0, "max_supply": null, "quotes": { "USD": { "price": 0.2061107333, "volume_24h": 11655869.368502, "market_cap": 101240651.0, "percent_change_1h": -0.03, "percent_change_24h": -2.48, "percent_change_7d": -13.05 } }, "last_updated": 1567323185 }, 
        "372": { "id": 372, "name": "Bytecoin", "symbol": "BCN", "website_slug": "bytecoin-bcn", "rank": 61, "circulating_supply": 184066828814.0, "total_supply": 184066828814.0, "max_supply": 184470000000.0, "quotes": { "USD": { "price": 0.0005498088, "volume_24h": 16868.8064876905, "market_cap": 101201570.0, "percent_change_1h": -2.37, "percent_change_24h": 2.17, "percent_change_7d": -7.39 } }, "last_updated": 1567323181 }, 
        "2897": { "id": 2897, "name": "Clipper Coin", "symbol": "CCCX", "website_slug": "clipper-coin", "rank": 62, "circulating_supply": 3780570996.0, "total_supply": 5000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0267018207, "volume_24h": 48890.5537429339, "market_cap": 100948129.0, "percent_change_1h": 0.33, "percent_change_24h": 17.94, "percent_change_7d": 5.75 } }, "last_updated": 1567323188 }, 
        "109": { "id": 109, "name": "DigiByte", "symbol": "DGB", "website_slug": "digibyte", "rank": 63, "circulating_supply": 12213013310.0, "total_supply": 12213013310.0, "max_supply": 21000000000.0, "quotes": { "USD": { "price": 0.0081899402, "volume_24h": 2181430.48043919, "market_cap": 100023849.0, "percent_change_1h": 0.3, "percent_change_24h": 1.49, "percent_change_7d": -9.14 } }, "last_updated": 1567323181 }, 
        "1896": { "id": 1896, "name": "0x", "symbol": "ZRX", "website_slug": "0x", "rank": 64, "circulating_supply": 600475853.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1616053817, "volume_24h": 5783043.79334278, "market_cap": 97040130.0, "percent_change_1h": 0.01, "percent_change_24h": -0.92, "percent_change_7d": -13.43 } }, "last_updated": 1567323184 }, 
        "4203": { "id": 4203, "name": "Oasis City", "symbol": "OSC", "website_slug": "oasis-city", "rank": 65, "circulating_supply": 2085965471.0, "total_supply": 12000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0457646355, "volume_24h": 543387.703231587, "market_cap": 95463450.0, "percent_change_1h": 0.93, "percent_change_24h": 2.96, "percent_change_7d": -15.07 } }, "last_updated": 1567323192 }, 
        "1903": { "id": 1903, "name": "HyperCash", "symbol": "HC", "website_slug": "hypercash", "rank": 66, "circulating_supply": 43529781.0, "total_supply": 43529781.0, "max_supply": 84000000.0, "quotes": { "USD": { "price": 2.1483680974, "volume_24h": 2653668.41176256, "market_cap": 93517992.0, "percent_change_1h": 0.35, "percent_change_24h": 0.68, "percent_change_7d": -13.3 } }, "last_updated": 1567323184 }, 
        "2603": { "id": 2603, "name": "Pundi X", "symbol": "NPXS", "website_slug": "pundi-x", "rank": 67, "circulating_supply": 235621468515.0, "total_supply": 261834927333.0, "max_supply": null, "quotes": { "USD": { "price": 0.0003916251, "volume_24h": 1714544.68010191, "market_cap": 92275286.0, "percent_change_1h": -1.08, "percent_change_24h": -0.79, "percent_change_7d": -9.45 } }, "last_updated": 1567323187 }, 
        "2874": { "id": 2874, "name": "Aurora", "symbol": "AOA", "website_slug": "aurora", "rank": 68, "circulating_supply": 6542330148.0, "total_supply": 10000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0140845539, "volume_24h": 3436181.37598032, "market_cap": 92145802.0, "percent_change_1h": 4.62, "percent_change_24h": 5.16, "percent_change_7d": -12.43 } }, "last_updated": 1567323188 }, 
        "463": { "id": 463, "name": "BitShares", "symbol": "BTS", "website_slug": "bitshares", "rank": 69, "circulating_supply": 2741440000.0, "total_supply": 2741440000.0, "max_supply": 3600570502.0, "quotes": { "USD": { "price": 0.0334369458, "volume_24h": 1624755.09499952, "market_cap": 91665381.0, "percent_change_1h": 0.07, "percent_change_24h": -0.86, "percent_change_7d": -17.5 } }, "last_updated": 1567323181 }, 
        "3620": { "id": 3620, "name": "Atlas Protocol", "symbol": "ATP", "website_slug": "atlas-protocol", "rank": 70, "circulating_supply": 2576065703.0, "total_supply": 4000000000.0, "max_supply": 10000000000.0, "quotes": { "USD": { "price": 0.0349283841, "volume_24h": 5687191.32180908, "market_cap": 89977812.0, "percent_change_1h": 1.01, "percent_change_24h": 18.02, "percent_change_7d": 9.25 } }, "last_updated": 1567323191 }, 
        "3134": { "id": 3134, "name": "ETERNAL TOKEN", "symbol": "XET", "website_slug": "eternal-token", "rank": 71, "circulating_supply": 93470000.0, "total_supply": 200000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.9550519356, "volume_24h": 149360.500583699, "market_cap": 89268704.0, "percent_change_1h": -1.37, "percent_change_24h": 3.94, "percent_change_7d": -7.03 } }, "last_updated": 1567323189 }, 
        "1104": { "id": 1104, "name": "Augur", "symbol": "REP", "website_slug": "augur", "rank": 72, "circulating_supply": 11000000.0, "total_supply": 11000000.0, "max_supply": null, "quotes": { "USD": { "price": 7.9481784481, "volume_24h": 5521656.85916259, "market_cap": 87429963.0, "percent_change_1h": 0.23, "percent_change_24h": -0.68, "percent_change_7d": -19.46 } }, "last_updated": 1567323182 }, 
        "2405": { "id": 2405, "name": "IOST", "symbol": "IOST", "website_slug": "iostoken", "rank": 73, "circulating_supply": 12013965609.0, "total_supply": 21000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0071853273, "volume_24h": 21384223.6606065, "market_cap": 86324275.0, "percent_change_1h": 0.33, "percent_change_24h": -2.61, "percent_change_7d": -16.13 } }, "last_updated": 1567323186 }, 
        "2907": { "id": 2907, "name": "Karatgold Coin", "symbol": "KBC", "website_slug": "karatgold-coin", "rank": 74, "circulating_supply": 4211824582.0, "total_supply": 12000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0198683705, "volume_24h": 2470437.51944739, "market_cap": 83682091.0, "percent_change_1h": 0.42, "percent_change_24h": -2.26, "percent_change_7d": -8.77 } }, "last_updated": 1567323188 }, 
        "213": { "id": 213, "name": "MonaCoin", "symbol": "MONA", "website_slug": "monacoin", "rank": 75, "circulating_supply": 65729675.0, "total_supply": 65729675.0, "max_supply": null, "quotes": { "USD": { "price": 1.2567605642, "volume_24h": 928056.747195017, "market_cap": 82606463.0, "percent_change_1h": -0.83, "percent_change_24h": 1.4, "percent_change_7d": -14.7 } }, "last_updated": 1567323181 }, 
        "3829": { "id": 3829, "name": "Nash Exchange", "symbol": "NEX", "website_slug": "nash-exchange", "rank": 76, "circulating_supply": 36196678.0, "total_supply": 56296100.0, "max_supply": null, "quotes": { "USD": { "price": 2.2503415425, "volume_24h": 3364978.01796299, "market_cap": 81454888.0, "percent_change_1h": -0.16, "percent_change_24h": 2.32, "percent_change_7d": -9.62 } }, "last_updated": 1567323191 }, 
        "3788": { "id": 3788, "name": "NEXT", "symbol": "NET", "website_slug": "next", "rank": 77, "circulating_supply": 50269268.0, "total_supply": 973628555.0, "max_supply": null, "quotes": { "USD": { "price": 1.6134038862, "volume_24h": 8669587.06807948, "market_cap": 81104632.0, "percent_change_1h": -0.04, "percent_change_24h": 3.73, "percent_change_7d": 1.11 } }, "last_updated": 1567323191 }, 
        "1866": { "id": 1866, "name": "Bytom", "symbol": "BTM", "website_slug": "bytom", "rank": 78, "circulating_supply": 1002499275.0, "total_supply": 1407000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0796244876, "volume_24h": 5659451.78838882, "market_cap": 79823491.0, "percent_change_1h": 0.04, "percent_change_24h": 0.1, "percent_change_7d": -8.83 } }, "last_updated": 1567323184 }, 
        "2885": { "id": 2885, "name": "Egretia", "symbol": "EGT", "website_slug": "egretia", "rank": 79, "circulating_supply": 4215883885.0, "total_supply": 8000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.018535784, "volume_24h": 19981833.5949136, "market_cap": 78144713.0, "percent_change_1h": -0.08, "percent_change_24h": -19.6, "percent_change_7d": -6.88 } }, "last_updated": 1567323188 }, 
        "1521": { "id": 1521, "name": "Komodo", "symbol": "KMD", "website_slug": "komodo", "rank": 80, "circulating_supply": 115707775.0, "total_supply": 115707775.0, "max_supply": 200000000.0, "quotes": { "USD": { "price": 0.6708815842, "volume_24h": 1681027.33558771, "market_cap": 77626215.0, "percent_change_1h": -0.38, "percent_change_24h": -5.24, "percent_change_7d": -20.28 } }, "last_updated": 1567323182 }, 
        "2308": { "id": 2308, "name": "Dai", "symbol": "DAI", "website_slug": "dai", "rank": 81, "circulating_supply": 76589000.0, "total_supply": 76589000.0, "max_supply": null, "quotes": { "USD": { "price": 1.0047322965, "volume_24h": 19375324.022323, "market_cap": 76951441.0, "percent_change_1h": 0.07, "percent_change_24h": -0.11, "percent_change_7d": 0.2 } }, "last_updated": 1567323186 }, 
        "291": { "id": 291, "name": "MaidSafeCoin", "symbol": "MAID", "website_slug": "maidsafecoin", "rank": 82, "circulating_supply": 452552412.0, "total_supply": 452552412.0, "max_supply": null, "quotes": { "USD": { "price": 0.16967654, "volume_24h": 176182.113675984, "market_cap": 76787527.0, "percent_change_1h": -0.75, "percent_change_24h": 2.24, "percent_change_7d": 2.63 } }, "last_updated": 1567323181 }, 
        "3840": { "id": 3840, "name": "1irstcoin", "symbol": "FST", "website_slug": "1irstcoin", "rank": 83, "circulating_supply": 22085000.0, "total_supply": 100000000.0, "max_supply": null, "quotes": { "USD": { "price": 3.4664834259, "volume_24h": 205355.307287603, "market_cap": 76557286.0, "percent_change_1h": 0.66, "percent_change_24h": 4.36, "percent_change_7d": 35.9 } }, "last_updated": 1567323191 }, 
        "3404": { "id": 3404, "name": "Wixlar", "symbol": "WIX", "website_slug": "wixlar", "rank": 84, "circulating_supply": 2391608888.0, "total_supply": 5330000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0320080705, "volume_24h": 14811.3376860727, "market_cap": 76550786.0, "percent_change_1h": 0.06, "percent_change_24h": -8.43, "percent_change_7d": 3.07 } }, "last_updated": 1567323190 }, 
        "1042": { "id": 1042, "name": "Siacoin", "symbol": "SC", "website_slug": "siacoin", "rank": 85, "circulating_supply": 41817047634.0, "total_supply": 41817047634.0, "max_supply": null, "quotes": { "USD": { "price": 0.0018203631, "volume_24h": 1111745.98283001, "market_cap": 76122211.0, "percent_change_1h": 0.19, "percent_change_24h": 0.73, "percent_change_7d": -15.61 } }, "last_updated": 1567323181 }, 
        "4049": { "id": 4049, "name": "Bitbook Gambling", "symbol": "BXK", "website_slug": "bitbook-gambling", "rank": 86, "circulating_supply": 368387491.0, "total_supply": 741456054.0, "max_supply": null, "quotes": { "USD": { "price": 0.1981875312, "volume_24h": 1004066.41398261, "market_cap": 73009807.0, "percent_change_1h": -0.4, "percent_change_24h": -3.26, "percent_change_7d": -5.25 } }, "last_updated": 1567323192 }, 
        "693": { "id": 693, "name": "Verge", "symbol": "XVG", "website_slug": "verge", "rank": 87, "circulating_supply": 15912340629.0, "total_supply": 15912340629.0, "max_supply": 16555000000.0, "quotes": { "USD": { "price": 0.004483558, "volume_24h": 902232.881487659, "market_cap": 71343902.0, "percent_change_1h": -0.95, "percent_change_24h": -1.83, "percent_change_7d": -18.16 } }, "last_updated": 1567323181 }, 
        "3987": { "id": 3987, "name": "Beldex", "symbol": "BDX", "website_slug": "beldex", "rank": 88, "circulating_supply": 980222595.0, "total_supply": 1400222610.0, "max_supply": null, "quotes": { "USD": { "price": 0.0716276127, "volume_24h": 804543.587353718, "market_cap": 70211004.0, "percent_change_1h": -0.47, "percent_change_24h": 0.72, "percent_change_7d": -8.58 } }, "last_updated": 1567323192 }, 
        "3155": { "id": 3155, "name": "Quant", "symbol": "QNT", "website_slug": "quant", "rank": 89, "circulating_supply": 12072738.0, "total_supply": 14612493.0, "max_supply": null, "quotes": { "USD": { "price": 5.7151693764, "volume_24h": 1680778.91359883, "market_cap": 68997743.0, "percent_change_1h": -1.16, "percent_change_24h": -2.8, "percent_change_7d": -13.49 } }, "last_updated": 1567323189 }, 
        "3224": { "id": 3224, "name": "Qubitica", "symbol": "QBIT", "website_slug": "qubitica", "rank": 90, "circulating_supply": 2085316.0, "total_supply": 10000000.0, "max_supply": null, "quotes": { "USD": { "price": 31.5326471906, "volume_24h": 119732.965821735, "market_cap": 65755540.0, "percent_change_1h": -0.1, "percent_change_24h": 1.99, "percent_change_7d": -14.44 } }, "last_updated": 1567323189 }, 
        "3701": { "id": 3701, "name": "RIF Token", "symbol": "RIF", "website_slug": "rif-token", "rank": 91, "circulating_supply": 477980957.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1318055198, "volume_24h": 2801668.89690418, "market_cap": 63000528.0, "percent_change_1h": 0.46, "percent_change_24h": -0.36, "percent_change_7d": -13.21 } }, "last_updated": 1567323191 }, 
        "2469": { "id": 2469, "name": "Zilliqa", "symbol": "ZIL", "website_slug": "zilliqa", "rank": 92, "circulating_supply": 8687360058.0, "total_supply": 12533042435.0, "max_supply": null, "quotes": { "USD": { "price": 0.0071387339, "volume_24h": 5898210.22736847, "market_cap": 62016752.0, "percent_change_1h": 0.01, "percent_change_24h": 0.65, "percent_change_7d": -16.75 } }, "last_updated": 1567323187 }, 
        "4206": { "id": 4206, "name": "WINk", "symbol": "WIN", "website_slug": "wink-tronbet", "rank": 93, "circulating_supply": 196500113934.0, "total_supply": 999000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0003115039, "volume_24h": 14063060.7630018, "market_cap": 61210547.0, "percent_change_1h": 0.39, "percent_change_24h": -1.01, "percent_change_7d": -3.04 } }, "last_updated": 1567323192 }, 
        "1700": { "id": 1700, "name": "Aeternity", "symbol": "AE", "website_slug": "aeternity", "rank": 94, "circulating_supply": 281204650.0, "total_supply": 327025593.0, "max_supply": null, "quotes": { "USD": { "price": 0.2108874453, "volume_24h": 11997796.6346641, "market_cap": 59302530.0, "percent_change_1h": -0.23, "percent_change_24h": -1.8, "percent_change_7d": -14.74 } }, "last_updated": 1567323183 }, 
        "1455": { "id": 1455, "name": "Golem", "symbol": "GNT", "website_slug": "golem-network-tokens", "rank": 95, "circulating_supply": 964450000.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0604050897, "volume_24h": 1835507.5268903, "market_cap": 58257689.0, "percent_change_1h": 0.02, "percent_change_24h": -0.17, "percent_change_7d": 4.12 } }, "last_updated": 1567323183 }, 
        "1230": { "id": 1230, "name": "Steem", "symbol": "STEEM", "website_slug": "steem", "rank": 96, "circulating_supply": 343219037.0, "total_supply": 360193131.0, "max_supply": null, "quotes": { "USD": { "price": 0.1667783204, "volume_24h": 374809.528360697, "market_cap": 57241495.0, "percent_change_1h": -0.19, "percent_change_24h": 0.62, "percent_change_7d": -12.56 } }, "last_updated": 1567323182 }, 
        "1703": { "id": 1703, "name": "Metaverse ETP", "symbol": "ETP", "website_slug": "metaverse", "rank": 97, "circulating_supply": 76116890.0, "total_supply": 76462016.0, "max_supply": 100000000.0, "quotes": { "USD": { "price": 0.7245666198, "volume_24h": 2701186.29253961, "market_cap": 55151758.0, "percent_change_1h": 0.37, "percent_change_24h": -7.53, "percent_change_7d": -16.26 } }, "last_updated": 1567323183 }, 
        "2130": { "id": 2130, "name": "Enjin Coin", "symbol": "ENJ", "website_slug": "enjin-coin", "rank": 98, "circulating_supply": 776278713.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0709977987, "volume_24h": 6735616.84179233, "market_cap": 55114080.0, "percent_change_1h": -0.95, "percent_change_24h": 9.73, "percent_change_7d": -1.79 } }, "last_updated": 1567323185 }, 
        "1759": { "id": 1759, "name": "Status", "symbol": "SNT", "website_slug": "status", "rank": 99, "circulating_supply": 3470483788.0, "total_supply": 6804870174.0, "max_supply": null, "quotes": { "USD": { "price": 0.0156223441, "volume_24h": 9259912.31220474, "market_cap": 54217092.0, "percent_change_1h": 0.0, "percent_change_24h": -0.51, "percent_change_7d": -16.42 } }, "last_updated": 1567323183 }, 
        "1320": { "id": 1320, "name": "Ardor", "symbol": "ARDR", "website_slug": "ardor", "rank": 100, "circulating_supply": 998999495.0, "total_supply": 998999495.0, "max_supply": 998999495.0, "quotes": { "USD": { "price": 0.0537472872, "volume_24h": 543255.150150407, "market_cap": 53693513.0, "percent_change_1h": 0.22, "percent_change_24h": 0.75, "percent_change_7d": -16.18 } }, "last_updated": 1567323182 }, 
        "3812": { "id": 3812, "name": "Flexacoin", "symbol": "FXC", "website_slug": "flexacoin", "rank": 101, "circulating_supply": 20267695749.0, "total_supply": 20267695749.0, "max_supply": 100000000000.0, "quotes": { "USD": { "price": 0.0026114748, "volume_24h": 4923.6151472646, "market_cap": 52928576.0, "percent_change_1h": -0.03, "percent_change_24h": 2.85, "percent_change_7d": -22.98 } }, "last_updated": 1567323191 }, 
        "1776": { "id": 1776, "name": "Crypto.com", "symbol": "MCO", "website_slug": "crypto-com", "rank": 102, "circulating_supply": 15793831.0, "total_supply": 31587682.0, "max_supply": null, "quotes": { "USD": { "price": 3.3406779312, "volume_24h": 4259007.58429878, "market_cap": 52762103.0, "percent_change_1h": 0.86, "percent_change_24h": 1.51, "percent_change_7d": -6.09 } }, "last_updated": 1567323183 }, 
        "1750": { "id": 1750, "name": "GXChain", "symbol": "GXC", "website_slug": "gxchain", "rank": 103, "circulating_supply": 65000000.0, "total_supply": 99845440.0, "max_supply": 100000000.0, "quotes": { "USD": { "price": 0.7923602559, "volume_24h": 3194254.24024575, "market_cap": 51503417.0, "percent_change_1h": -0.58, "percent_change_24h": -3.86, "percent_change_7d": -18.12 } }, "last_updated": 1567323183 }, 
        "3437": { "id": 3437, "name": "ABBC Coin", "symbol": "ABBC", "website_slug": "abbc-coin", "rank": 104, "circulating_supply": 554307762.0, "total_supply": 1002169590.0, "max_supply": null, "quotes": { "USD": { "price": 0.0928407217, "volume_24h": 50554936.1725861, "market_cap": 51462333.0, "percent_change_1h": 0.16, "percent_change_24h": 3.28, "percent_change_7d": -26.24 } }, "last_updated": 1567323190 }, 
        "1925": { "id": 1925, "name": "Waltonchain", "symbol": "WTC", "website_slug": "waltonchain", "rank": 105, "circulating_supply": 42252004.0, "total_supply": 70000000.0, "max_supply": 100000000.0, "quotes": { "USD": { "price": 1.2153930481, "volume_24h": 3474690.56598012, "market_cap": 51352792.0, "percent_change_1h": 3.35, "percent_change_24h": 4.59, "percent_change_7d": -16.42 } }, "last_updated": 1567323184 }, 
        "2539": { "id": 2539, "name": "Ren", "symbol": "REN", "website_slug": "ren", "rank": 106, "circulating_supply": 795594931.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0643852303, "volume_24h": 2909220.0700271, "market_cap": 51224563.0, "percent_change_1h": -0.17, "percent_change_24h": -6.68, "percent_change_7d": -19.04 } }, "last_updated": 1567323187 }, 
        "3897": { "id": 3897, "name": "OKB", "symbol": "OKB", "website_slug": "okb", "rank": 107, "circulating_supply": 20000000.0, "total_supply": 300000000.0, "max_supply": null, "quotes": { "USD": { "price": 2.5279341897, "volume_24h": 88739024.254834, "market_cap": 50558684.0, "percent_change_1h": -0.04, "percent_change_24h": 2.29, "percent_change_7d": -15.31 } }, "last_updated": 1567323192 }, 
        "3828": { "id": 3828, "name": "Japan Content Token", "symbol": "JCT", "website_slug": "japan-content-token", "rank": 108, "circulating_supply": 293150782.0, "total_supply": 2500000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1710191416, "volume_24h": 237475.636982861, "market_cap": 50134395.0, "percent_change_1h": 0.0, "percent_change_24h": 10.57, "percent_change_7d": -14.04 } }, "last_updated": 1567323191 }, 
        "3344": { "id": 3344, "name": "Ecoreal Estate", "symbol": "ECOREAL", "website_slug": "ecoreal-estate", "rank": 109, "circulating_supply": 210031903.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.2355760526, "volume_24h": 22007.5703318568, "market_cap": 49478487.0, "percent_change_1h": 0.02, "percent_change_24h": 0.23, "percent_change_7d": 5.76 } }, "last_updated": 1567323190 }, 
        "1414": { "id": 1414, "name": "Zcoin", "symbol": "XZC", "website_slug": "zcoin", "rank": 110, "circulating_supply": 8274843.0, "total_supply": 21400000.0, "max_supply": 21400000.0, "quotes": { "USD": { "price": 5.6958959565, "volume_24h": 2878701.25733206, "market_cap": 47132647.0, "percent_change_1h": 0.05, "percent_change_24h": -1.71, "percent_change_7d": -18.75 } }, "last_updated": 1567323182 }, 
        "3607": { "id": 3607, "name": "VestChain", "symbol": "VEST", "website_slug": "vestchain", "rank": 111, "circulating_supply": 7078400000.0, "total_supply": 8848000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0064331636, "volume_24h": 170976.186157433, "market_cap": 45536506.0, "percent_change_1h": 2.15, "percent_change_24h": 4.8, "percent_change_7d": -4.23 } }, "last_updated": 1567323190 }, 
        "2586": { "id": 2586, "name": "Synthetix Network Token", "symbol": "SNX", "website_slug": "synthetix-network-token", "rank": 112, "circulating_supply": 127447605.0, "total_supply": 136057692.0, "max_supply": null, "quotes": { "USD": { "price": 0.3569282425, "volume_24h": 12125.2997363765, "market_cap": 45489650.0, "percent_change_1h": 0.26, "percent_change_24h": -2.92, "percent_change_7d": 24.6 } }, "last_updated": 1567323187 }, 
        "3115": { "id": 3115, "name": "Maximine Coin", "symbol": "MXM", "website_slug": "maximine-coin", "rank": 113, "circulating_supply": 1649000000.0, "total_supply": 16000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0269306293, "volume_24h": 3299992.9271151, "market_cap": 44408608.0, "percent_change_1h": -1.33, "percent_change_24h": -7.97, "percent_change_7d": -6.84 } }, "last_updated": 1567323189 }, 
        "3724": { "id": 3724, "name": "SOLVE", "symbol": "SOLVE", "website_slug": "solve", "rank": 114, "circulating_supply": 327244058.0, "total_supply": 1000000000.0, "max_supply": 1000000000.0, "quotes": { "USD": { "price": 0.1338554755, "volume_24h": 1097585.49134652, "market_cap": 43803409.0, "percent_change_1h": -0.26, "percent_change_24h": 5.19, "percent_change_7d": 13.36 } }, "last_updated": 1567323191 }, 
        "4067": { "id": 4067, "name": "Cryptoindex.com 100", "symbol": "CIX100", "website_slug": "cryptoindex-com-100", "rank": 115, "circulating_supply": 60864742.0, "total_supply": 300000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.6906800897, "volume_24h": 67733.4843631721, "market_cap": 42038065.0, "percent_change_1h": -0.01, "percent_change_24h": 0.35, "percent_change_7d": -6.2 } }, "last_updated": 1567323192 }, 
        "1343": { "id": 1343, "name": "Stratis", "symbol": "STRAT", "website_slug": "stratis", "rank": 116, "circulating_supply": 99468244.0, "total_supply": 99468244.0, "max_supply": null, "quotes": { "USD": { "price": 0.4002257065, "volume_24h": 1167628.31397874, "market_cap": 39809748.0, "percent_change_1h": -0.1, "percent_change_24h": 1.55, "percent_change_7d": -6.24 } }, "last_updated": 1567323182 }, 
        "2299": { "id": 2299, "name": "aelf", "symbol": "ELF", "website_slug": "aelf", "rank": 117, "circulating_supply": 499780000.0, "total_supply": 880000000.0, "max_supply": 1000000000.0, "quotes": { "USD": { "price": 0.0794492499, "volume_24h": 7699703.73173034, "market_cap": 39707146.0, "percent_change_1h": 0.63, "percent_change_24h": 3.57, "percent_change_7d": -8.87 } }, "last_updated": 1567323185 }, 
        "2300": { "id": 2300, "name": "WAX", "symbol": "WAX", "website_slug": "wax", "rank": 118, "circulating_supply": 942821662.0, "total_supply": 1850000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0419526986, "volume_24h": 68033.9514138221, "market_cap": 39553913.0, "percent_change_1h": -1.05, "percent_change_24h": -6.59, "percent_change_7d": -21.72 } }, "last_updated": 1567323185 }, 
        "2492": { "id": 2492, "name": "Elastos", "symbol": "ELA", "website_slug": "elastos", "rank": 119, "circulating_supply": 15967156.0, "total_supply": 34839919.0, "max_supply": null, "quotes": { "USD": { "price": 2.4718085899, "volume_24h": 1867380.47742698, "market_cap": 39467754.0, "percent_change_1h": 0.03, "percent_change_24h": 2.41, "percent_change_7d": -13.79 } }, "last_updated": 1567323186 }, 
        "3702": { "id": 3702, "name": "Beam", "symbol": "BEAM", "website_slug": "beam", "rank": 120, "circulating_supply": 33745200.0, "total_supply": 33745200.0, "max_supply": 262800000.0, "quotes": { "USD": { "price": 1.1491187994, "volume_24h": 61454222.0103003, "market_cap": 38777244.0, "percent_change_1h": 0.97, "percent_change_24h": -5.8, "percent_change_7d": -24.05 } }, "last_updated": 1567323191 }, 
        "3063": { "id": 3063, "name": "Vitae", "symbol": "VITAE", "website_slug": "vitae", "rank": 121, "circulating_supply": 17993832.0, "total_supply": 17993832.0, "max_supply": null, "quotes": { "USD": { "price": 2.1398208117, "volume_24h": 40879.1853082081, "market_cap": 38503576.0, "percent_change_1h": 0.02, "percent_change_24h": -2.95, "percent_change_7d": -13.84 } }, "last_updated": 1567323188 }, 
        "2606": { "id": 2606, "name": "Wanchain", "symbol": "WAN", "website_slug": "wanchain", "rank": 122, "circulating_supply": 106152493.0, "total_supply": 210000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.3546671278, "volume_24h": 15747121.4098247, "market_cap": 37648800.0, "percent_change_1h": -2.73, "percent_change_24h": -1.9, "percent_change_7d": -11.11 } }, "last_updated": 1567323187 }, 
        "4281": { "id": 4281, "name": "BHEX Token", "symbol": "BHT", "website_slug": "bhex-token", "rank": 123, "circulating_supply": 595312966.0, "total_supply": 2095136176.0, "max_supply": null, "quotes": { "USD": { "price": 0.0630820586, "volume_24h": 1492262.61151742, "market_cap": 37553567.0, "percent_change_1h": 1.49, "percent_change_24h": 8.71, "percent_change_7d": null } }, "last_updated": 1567323192 }, 
        "2593": { "id": 2593, "name": "Dragon Coins", "symbol": "DRG", "website_slug": "dragon-coins", "rank": 124, "circulating_supply": 348292412.0, "total_supply": 500000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1070534221, "volume_24h": 90216.2938040653, "market_cap": 37285895.0, "percent_change_1h": -8.91, "percent_change_24h": -43.68, "percent_change_7d": 19.31 } }, "last_updated": 1567323187 }, 
        "3709": { "id": 3709, "name": "Grin", "symbol": "GRIN", "website_slug": "grin", "rank": 125, "circulating_supply": 19677540.0, "total_supply": 19677540.0, "max_supply": null, "quotes": { "USD": { "price": 1.8885137305, "volume_24h": 39186971.4182144, "market_cap": 37161304.0, "percent_change_1h": 0.12, "percent_change_24h": -3.94, "percent_change_7d": -22.01 } }, "last_updated": 1567323191 }, 
        "2694": { "id": 2694, "name": "Nexo", "symbol": "NEXO", "website_slug": "nexo", "rank": 126, "circulating_supply": 560000011.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0661302096, "volume_24h": 5314311.13121716, "market_cap": 37032918.0, "percent_change_1h": -1.74, "percent_change_24h": -2.11, "percent_change_7d": -9.51 } }, "last_updated": 1567323188 }, 
        "2298": { "id": 2298, "name": "Dynamic Trading Rights", "symbol": "DTR", "website_slug": "dynamic-trading-rights", "rank": 127, "circulating_supply": 1529018776.0, "total_supply": 2610393776.0, "max_supply": null, "quotes": { "USD": { "price": 0.0239252946, "volume_24h": 66148.0368718766, "market_cap": 36582225.0, "percent_change_1h": -0.03, "percent_change_24h": 1.02, "percent_change_7d": 7.65 } }, "last_updated": 1567323185 }, 
        "2433": { "id": 2433, "name": "IPChain", "symbol": "IPC", "website_slug": "ipchain", "rank": 128, "circulating_supply": 78330743.0, "total_supply": 92730744.0, "max_supply": null, "quotes": { "USD": { "price": 0.4611051004, "volume_24h": 2665444.92006243, "market_cap": 36118705.0, "percent_change_1h": -1.0, "percent_change_24h": -4.88, "percent_change_7d": 9.34 } }, "last_updated": 1567323186 }, 
        "2900": { "id": 2900, "name": "Project Pai", "symbol": "PAI", "website_slug": "project-pai", "rank": 129, "circulating_supply": 1451459830.0, "total_supply": 1618371000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0245381398, "volume_24h": 569320.467051212, "market_cap": 35616124.0, "percent_change_1h": 0.81, "percent_change_24h": -1.42, "percent_change_7d": -11.3 } }, "last_updated": 1567323188 }, 
        "2842": { "id": 2842, "name": "Bankera", "symbol": "BNK", "website_slug": "bankera", "rank": 130, "circulating_supply": 24588912108.0, "total_supply": 25000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0014451833, "volume_24h": 26304.5530393434, "market_cap": 35535486.0, "percent_change_1h": 0.2, "percent_change_24h": 0.96, "percent_change_7d": -5.44 } }, "last_updated": 1567323188 }, 
        "2989": { "id": 2989, "name": "STASIS EURO", "symbol": "EURS", "website_slug": "stasis-euro", "rank": 131, "circulating_supply": 31979207.0, "total_supply": 31979207.0, "max_supply": null, "quotes": { "USD": { "price": 1.1049310604, "volume_24h": 701934.542186305, "market_cap": 35334819.0, "percent_change_1h": 0.01, "percent_change_24h": 0.61, "percent_change_7d": 0.53 } }, "last_updated": 1567323188 }, 
        "2135": { "id": 2135, "name": "Revain", "symbol": "R", "website_slug": "revain", "rank": 132, "circulating_supply": 484450000.0, "total_supply": 484450000.0, "max_supply": 484450000.0, "quotes": { "USD": { "price": 0.0723976354, "volume_24h": 1643907.04691957, "market_cap": 35073034.0, "percent_change_1h": 0.31, "percent_change_24h": 0.26, "percent_change_7d": -5.94 } }, "last_updated": 1567323185 }, 
        "2137": { "id": 2137, "name": "Electroneum", "symbol": "ETN", "website_slug": "electroneum", "rank": 133, "circulating_supply": 9794855204.0, "total_supply": 9794855204.0, "max_supply": 21000000000.0, "quotes": { "USD": { "price": 0.0035553342, "volume_24h": 79794.9514854287, "market_cap": 34823983.0, "percent_change_1h": -0.21, "percent_change_24h": 0.2, "percent_change_7d": -6.17 } }, "last_updated": 1567323185 }, 
        "1698": { "id": 1698, "name": "Horizen", "symbol": "ZEN", "website_slug": "zencash", "rank": 134, "circulating_supply": 7230375.0, "total_supply": 7230375.0, "max_supply": 21000000.0, "quotes": { "USD": { "price": 4.6869369426, "volume_24h": 2906718.4637973, "market_cap": 33888312.0, "percent_change_1h": -0.17, "percent_change_24h": -2.17, "percent_change_7d": -10.75 } }, "last_updated": 1567323183 }, 
        "3415": { "id": 3415, "name": "Buggyra Coin Zero", "symbol": "BCZERO", "website_slug": "buggyra-coin-zero", "rank": 135, "circulating_supply": 2010775988.0, "total_supply": 10000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0167447407, "volume_24h": 38602.5738989154, "market_cap": 33669922.0, "percent_change_1h": -0.99, "percent_change_24h": 0.89, "percent_change_7d": -4.07 } }, "last_updated": 1567323190 }, 
        "1886": { "id": 1886, "name": "Dent", "symbol": "DENT", "website_slug": "dent", "rank": 136, "circulating_supply": 73625838994.0, "total_supply": 100000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0004545116, "volume_24h": 698113.092485708, "market_cap": 33463800.0, "percent_change_1h": -0.11, "percent_change_24h": -0.03, "percent_change_7d": 1.1 } }, "last_updated": 1567323184 }, 
        "1966": { "id": 1966, "name": "Decentraland", "symbol": "MANA", "website_slug": "decentraland", "rank": 137, "circulating_supply": 1050141509.0, "total_supply": 2644403343.0, "max_supply": null, "quotes": { "USD": { "price": 0.0317499829, "volume_24h": 6110391.48583497, "market_cap": 33341975.0, "percent_change_1h": -0.64, "percent_change_24h": -1.31, "percent_change_7d": -15.81 } }, "last_updated": 1567323184 }, 
        "118": { "id": 118, "name": "ReddCoin", "symbol": "RDD", "website_slug": "reddcoin", "rank": 138, "circulating_supply": 28808713174.0, "total_supply": 28808713174.0, "max_supply": null, "quotes": { "USD": { "price": 0.0011547763, "volume_24h": 19740.9086214216, "market_cap": 33267620.0, "percent_change_1h": -5.98, "percent_change_24h": -1.67, "percent_change_7d": -6.11 } }, "last_updated": 1567323181 }, 
        "1908": { "id": 1908, "name": "Nebulas", "symbol": "NAS", "website_slug": "nebulas-token", "rank": 139, "circulating_supply": 48627715.0, "total_supply": 104589244.0, "max_supply": null, "quotes": { "USD": { "price": 0.6706487877, "volume_24h": 5338662.08945584, "market_cap": 32612118.0, "percent_change_1h": 0.61, "percent_change_24h": -0.13, "percent_change_7d": -11.92 } }, "last_updated": 1567323184 }, 
        "2213": { "id": 2213, "name": "QASH", "symbol": "QASH", "website_slug": "qash", "rank": 140, "circulating_supply": 350000000.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0929598626, "volume_24h": 204051.022457578, "market_cap": 32535952.0, "percent_change_1h": -0.03, "percent_change_24h": -3.48, "percent_change_7d": -5.61 } }, "last_updated": 1567323185 }, 
        "2631": { "id": 2631, "name": "ODEM", "symbol": "ODE", "website_slug": "odem", "rank": 141, "circulating_supply": 230043504.0, "total_supply": 268946131.0, "max_supply": null, "quotes": { "USD": { "price": 0.1412361142, "volume_24h": 599444.316426908, "market_cap": 32490451.0, "percent_change_1h": -0.04, "percent_change_24h": 0.19, "percent_change_7d": -9.32 } }, "last_updated": 1567323187 }, 
        "3871": { "id": 3871, "name": "Newton", "symbol": "NEW", "website_slug": "newton", "rank": 142, "circulating_supply": 11948333332.0, "total_supply": 100000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0027153603, "volume_24h": 2257761.94928429, "market_cap": 32444029.0, "percent_change_1h": 0.57, "percent_change_24h": -1.52, "percent_change_7d": -8.93 } }, "last_updated": 1567323191 }, 
        "4152": { "id": 4152, "name": "CryptoVerificationCoin", "symbol": "CVCC", "website_slug": "cryptoverificationcoin", "rank": 143, "circulating_supply": 582595.0, "total_supply": 36000000.0, "max_supply": null, "quotes": { "USD": { "price": 55.137881998, "volume_24h": 52924.531067601, "market_cap": 32123082.0, "percent_change_1h": 0.11, "percent_change_24h": 0.25, "percent_change_7d": -3.0 } }, "last_updated": 1567323192 }, 
        "3929": { "id": 3929, "name": "BQT", "symbol": "BQTX", "website_slug": "bqt", "rank": 144, "circulating_supply": 369723340.0, "total_supply": 800000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0867230017, "volume_24h": 2695420.06008302, "market_cap": 32063518.0, "percent_change_1h": -1.65, "percent_change_24h": -2.25, "percent_change_7d": -12.88 } }, "last_updated": 1567323191 }, 
        "3070": { "id": 3070, "name": "Litex", "symbol": "LXT", "website_slug": "litex", "rank": 145, "circulating_supply": 839999986.0, "total_supply": 2000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0380868212, "volume_24h": 2319111.70020193, "market_cap": 31992929.0, "percent_change_1h": -3.57, "percent_change_24h": 0.45, "percent_change_7d": -14.14 } }, "last_updated": 1567323188 }, 
        "2092": { "id": 2092, "name": "NULS", "symbol": "NULS", "website_slug": "nuls", "rank": 146, "circulating_supply": 73630194.0, "total_supply": 105698366.0, "max_supply": null, "quotes": { "USD": { "price": 0.4304611858, "volume_24h": 1315203.9764029, "market_cap": 31694941.0, "percent_change_1h": -0.2, "percent_change_24h": -1.88, "percent_change_7d": -20.53 } }, "last_updated": 1567323184 }, 
        "1229": { "id": 1229, "name": "DigixDAO", "symbol": "DGD", "website_slug": "digixdao", "rank": 147, "circulating_supply": 2000000.0, "total_supply": 2000000.0, "max_supply": null, "quotes": { "USD": { "price": 15.8132354198, "volume_24h": 374563.939906586, "market_cap": 31626471.0, "percent_change_1h": 0.31, "percent_change_24h": -1.19, "percent_change_7d": -18.79 } }, "last_updated": 1567323182 }, 
        "1087": { "id": 1087, "name": "Factom", "symbol": "FCT", "website_slug": "factom", "rank": 148, "circulating_supply": 9714918.0, "total_supply": 9714918.0, "max_supply": null, "quotes": { "USD": { "price": 3.2486786631, "volume_24h": 182069.373212452, "market_cap": 31560646.0, "percent_change_1h": 0.84, "percent_change_24h": -3.17, "percent_change_7d": -22.9 } }, "last_updated": 1567323181 }, 
        "2570": { "id": 2570, "name": "TomoChain", "symbol": "TOMO", "website_slug": "tomochain", "rank": 149, "circulating_supply": 64468050.0, "total_supply": 100000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.4761307588, "volume_24h": 2581389.83901659, "market_cap": 30695222.0, "percent_change_1h": 0.44, "percent_change_24h": -1.91, "percent_change_7d": -24.01 } }, "last_updated": 1567323187 }, 
        "1934": { "id": 1934, "name": "Loopring", "symbol": "LRC", "website_slug": "loopring", "rank": 150, "circulating_supply": 900956509.0, "total_supply": 1375076040.0, "max_supply": null, "quotes": { "USD": { "price": 0.033720217, "volume_24h": 3285080.37541309, "market_cap": 30380449.0, "percent_change_1h": 0.56, "percent_change_24h": 2.01, "percent_change_7d": -14.08 } }, "last_updated": 1567323184 }
    }, 
    "metadata": { "timestamp": 1567322830, "warning": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", "num_cryptocurrencies": 2341, "error": null }
}
''';

    test('CoinMarketCap: 1 symbol (in first 50 cryptos), 200 - Response',
        () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .thenAnswer((_) async => http.Response(first50Coins, 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.coinmarketcap, <String>['BTC'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['BTC'].keys.length, 10);
      expect(quote['BTC']['name'], 'Bitcoin');
      expect(quote['BTC']['quotes']['USD']['price'], 9639.69917373);

      verify(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .called(1);
    });

    test('CoinMarketCap: 1 symbol (NOT in first 50 cryptos), 200 - Response',
        () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .thenAnswer((_) async => http.Response(first50Coins, 200));

      when(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .thenAnswer((_) async => http.Response(second50Coins, 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.coinmarketcap, <String>['BCD'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['BCD'].keys.length, 10);
      expect(quote['BCD']['name'], 'Bitcoin Diamond');
      expect(quote['BCD']['quotes']['USD']['price'], 0.5782523205);

      verify(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .called(1);
      verify(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .called(1);
      verifyNever(client
          .get('https://api.coinmarketcap.com/v2/ticker/?start=101&limit=150'));
    });

    test('CoinMarketCap: 1 invalid symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .thenAnswer((_) async => http.Response(first50Coins, 200));

      when(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .thenAnswer((_) async => http.Response(second50Coins, 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.coinmarketcap, <String>['WWW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .called(1);
      verify(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .called(1);
      verifyNever(client
          .get('https://api.coinmarketcap.com/v2/ticker/?start=101&limit=150'));
    });

    test('CoinMarketCap: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .thenAnswer((_) async => http.Response(first50Coins, 200));

      when(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .thenAnswer((_) async => http.Response(second50Coins, 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.coinmarketcap, <String>['BTC', 'BCD', 'WWW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 2);
      expect(quote['BTC'].keys.length, 10);
      expect(quote['BTC']['name'], 'Bitcoin');
      expect(quote['BTC']['quotes']['USD']['price'], 9639.69917373);
      expect(quote['BCD'].keys.length, 10);
      expect(quote['BCD']['name'], 'Bitcoin Diamond');
      expect(quote['BCD']['quotes']['USD']['price'], 0.5782523205);

      verify(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .called(1);
      verify(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .called(1);
      verifyNever(client
          .get('https://api.coinmarketcap.com/v2/ticker/?start=101&limit=150'));
    });

    test('CoinMarketCap: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .thenAnswer((_) async => http.Response(
              '{ "attention": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", "data": { }, "metadata": { "timestamp": 1567322830, "warning": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", "num_cryptocurrencies": 2341, "error": null } }',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.coinmarketcap, <String>['BTC'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .called(1);

      verify(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .called(1);

      verifyNever(client
          .get('https://api.coinmarketcap.com/v2/ticker/?start=101&limit=150'));
    });

    test('CoinMarketCap: 404 - Response', () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .thenAnswer((_) async => http.Response(
              '{ "attention": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", "data": { }, "metadata": { "timestamp": 1567322830, "warning": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", "num_cryptocurrencies": 2341, "error": null } }',
              404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.coinmarketcap, <String>['BTC'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .called(1);

      verify(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .called(1);

      verifyNever(client
          .get('https://api.coinmarketcap.com/v2/ticker/?start=101&limit=150'));
    });
  });

  group('downloadQuotePrice Test [Finance] - CoinMarketCap', () {
    const String first50Coins = '''
{ "attention": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", 
    "data": {
        "1": { "id": 1, "name": "Bitcoin", "symbol": "BTC", "website_slug": "bitcoin", "rank": 1, "circulating_supply": 17909062.0, "total_supply": 17909062.0, "max_supply": 21000000.0, "quotes": { "USD": { "price": 9639.69917373, "volume_24h": 11006169341.8662, "market_cap": 172637970164.0, "percent_change_1h": 0.05, "percent_change_24h": 0.18, "percent_change_7d": -4.83 } }, "last_updated": 1567321592 }, 
        "1027": { "id": 1027, "name": "Ethereum", "symbol": "ETH", "website_slug": "ethereum", "rank": 2, "circulating_supply": 107558550.0, "total_supply": 107558550.0, "max_supply": null, "quotes": { "USD": { "price": 172.744354503, "volume_24h": 5632184548.49067, "market_cap": 18580132280.0, "percent_change_1h": 0.0, "percent_change_24h": 2.0, "percent_change_7d": -9.15 } }, "last_updated": 1567321584 }, 
        "52": { "id": 52, "name": "XRP", "symbol": "XRP", "website_slug": "ripple", "rank": 3, "circulating_supply": 42984656144.0, "total_supply": 99991362294.0, "max_supply": 100000000000.0, "quotes": { "USD": { "price": 0.2578479266, "volume_24h": 839949897.795398, "market_cap": 11083504463.0, "percent_change_1h": -0.15, "percent_change_24h": -0.0, "percent_change_7d": -5.13 } }, "last_updated": 1567321566 }, 
        "1831": { "id": 1831, "name": "Bitcoin Cash", "symbol": "BCH", "website_slug": "bitcoin-cash", "rank": 4, "circulating_supply": 17978813.0, "total_supply": 17978813.0, "max_supply": 21000000.0, "quotes": { "USD": { "price": 280.285728356, "volume_24h": 1098892132.5171, "market_cap": 5039204557.0, "percent_change_1h": -0.01, "percent_change_24h": 0.5, "percent_change_7d": -8.86 } }, "last_updated": 1567321567 }, 
        "2": { "id": 2, "name": "Litecoin", "symbol": "LTC", "website_slug": "litecoin", "rank": 5, "circulating_supply": 63157874.0, "total_supply": 63157874.0, "max_supply": 84000000.0, "quotes": { "USD": { "price": 64.9030874753, "volume_24h": 2313149619.18215, "market_cap": 4099141021.0, "percent_change_1h": 0.0, "percent_change_24h": 1.39, "percent_change_7d": -11.63 } }, "last_updated": 1567321566 }, 
        "825": { "id": 825, "name": "Tether", "symbol": "USDT", "website_slug": "tether", "rank": 6, "circulating_supply": 4007869728.0, "total_supply": 4095057493.0, "max_supply": null, "quotes": { "USD": { "price": 1.0027730256, "volume_24h": 13029279417.1742, "market_cap": 4018983653.0, "percent_change_1h": -0.03, "percent_change_24h": -0.05, "percent_change_7d": 0.03 } }, "last_updated": 1567321578 }, 
        "1839": { "id": 1839, "name": "Binance Coin", "symbol": "BNB", "website_slug": "binance-coin", "rank": 7, "circulating_supply": 155536713.0, "total_supply": 187536713.0, "max_supply": 187536713.0, "quotes": { "USD": { "price": 21.6954981833, "volume_24h": 175163700.577192, "market_cap": 3374446474.0, "percent_change_1h": -0.16, "percent_change_24h": -2.46, "percent_change_7d": -17.52 } }, "last_updated": 1567321565 }, 
        "1765": { "id": 1765, "name": "EOS", "symbol": "EOS", "website_slug": "eos", "rank": 8, "circulating_supply": 929859805.0, "total_supply": 1026559816.0, "max_supply": null, "quotes": { "USD": { "price": 3.3162341058, "volume_24h": 1177966780.96319, "market_cap": 3083632798.0, "percent_change_1h": 0.01, "percent_change_24h": 3.3, "percent_change_7d": -8.99 } }, "last_updated": 1567321568 }, 
        "3602": { "id": 3602, "name": "Bitcoin SV", "symbol": "BSV", "website_slug": "bitcoin-sv", "rank": 9, "circulating_supply": 17854986.0, "total_supply": 17854986.0, "max_supply": 21000000.0, "quotes": { "USD": { "price": 128.733879773, "volume_24h": 262364073.696393, "market_cap": 2298541589.0, "percent_change_1h": 0.07, "percent_change_24h": -0.22, "percent_change_7d": -3.25 } }, "last_updated": 1567321572 }, 
        "512": { "id": 512, "name": "Stellar", "symbol": "XLM", "website_slug": "stellar", "rank": 10, "circulating_supply": 19639376193.0, "total_supply": 105283157145.0, "max_supply": null, "quotes": { "USD": { "price": 0.063150381, "volume_24h": 82159148.6753219, "market_cap": 1240234089.0, "percent_change_1h": -0.37, "percent_change_24h": 0.75, "percent_change_7d": -9.46 } }, "last_updated": 1567321564 }, 
        "2010": { "id": 2010, "name": "Cardano", "symbol": "ADA", "website_slug": "cardano", "rank": 11, "circulating_supply": 25927070538.0, "total_supply": 31112483745.0, "max_supply": 45000000000.0, "quotes": { "USD": { "price": 0.0449502989, "volume_24h": 36500147.8310537, "market_cap": 1165429569.0, "percent_change_1h": -0.23, "percent_change_24h": -0.56, "percent_change_7d": -12.92 } }, "last_updated": 1567321564 }, 
        "328": { "id": 328, "name": "Monero", "symbol": "XMR", "website_slug": "monero", "rank": 12, "circulating_supply": 17185092.0, "total_supply": 17185092.0, "max_supply": null, "quotes": { "USD": { "price": 67.5620852528, "volume_24h": 47063372.0674461, "market_cap": 1161060642.0, "percent_change_1h": -0.04, "percent_change_24h": -0.12, "percent_change_7d": -16.13 } }, "last_updated": 1567321562 }, 
        "3957": { "id": 3957, "name": "UNUS SED LEO", "symbol": "LEO", "website_slug": "unus-sed-leo", "rank": 13, "circulating_supply": 999498893.0, "total_supply": 999498893.0, "max_supply": null, "quotes": { "USD": { "price": 1.1417797649, "volume_24h": 5746133.99481908, "market_cap": 1141207611.0, "percent_change_1h": 0.06, "percent_change_24h": 0.1, "percent_change_7d": -3.47 } }, "last_updated": 1567321573 }, 
        "1958": { "id": 1958, "name": "TRON", "symbol": "TRX", "website_slug": "tron", "rank": 14, "circulating_supply": 66682072191.0, "total_supply": 99281283754.0, "max_supply": null, "quotes": { "USD": { "price": 0.0155420937, "volume_24h": 461015424.583107, "market_cap": 1036379016.0, "percent_change_1h": -0.06, "percent_change_24h": -0.1, "percent_change_7d": -13.52 } }, "last_updated": 1567321566 }, 
        "2502": { "id": 2502, "name": "Huobi Token", "symbol": "HT", "website_slug": "huobi-token", "rank": 15, "circulating_supply": 245880576.0, "total_supply": 500000000.0, "max_supply": null, "quotes": { "USD": { "price": 3.9055706304, "volume_24h": 59514519.9821509, "market_cap": 960303956.0, "percent_change_1h": -0.01, "percent_change_24h": 1.11, "percent_change_7d": -18.7 } }, "last_updated": 1567321567 }, 
        "131": { "id": 131, "name": "Dash", "symbol": "DASH", "website_slug": "dash", "rank": 16, "circulating_supply": 9015502.0, "total_supply": 9015502.0, "max_supply": 18900000.0, "quotes": { "USD": { "price": 80.2612639794, "volume_24h": 202270769.476056, "market_cap": 723595600.0, "percent_change_1h": 0.2, "percent_change_24h": 0.15, "percent_change_7d": -13.08 } }, "last_updated": 1567321563 }, 
        "1321": { "id": 1321, "name": "Ethereum Classic", "symbol": "ETC", "website_slug": "ethereum-classic", "rank": 17, "circulating_supply": 113128277.0, "total_supply": 113128277.0, "max_supply": 210000000.0, "quotes": { "USD": { "price": 6.2704752926, "volume_24h": 567814757.245327, "market_cap": 709368066.0, "percent_change_1h": -0.01, "percent_change_24h": -0.28, "percent_change_7d": -11.75 } }, "last_updated": 1567321564 }, 
        "2011": { "id": 2011, "name": "Tezos", "symbol": "XTZ", "website_slug": "tezos", "rank": 18, "circulating_supply": 660373612.0, "total_supply": 801312599.0, "max_supply": null, "quotes": { "USD": { "price": 1.0510432864, "volume_24h": 11552530.84368, "market_cap": 694081251.0, "percent_change_1h": 0.08, "percent_change_24h": -2.11, "percent_change_7d": -8.9 } }, "last_updated": 1567321564 }, 
        "1720": { "id": 1720, "name": "IOTA", "symbol": "MIOTA", "website_slug": "iota", "rank": 19, "circulating_supply": 2779530283.0, "total_supply": 2779530283.0, "max_supply": 2779530283.0, "quotes": { "USD": { "price": 0.2480872936, "volume_24h": 4373304.27591743, "market_cap": 689566145.0, "percent_change_1h": 0.11, "percent_change_24h": -0.22, "percent_change_7d": -6.7 } }, "last_updated": 1567321563 }, 
        "1376": { "id": 1376, "name": "NEO", "symbol": "NEO", "website_slug": "neo", "rank": 20, "circulating_supply": 70538831.0, "total_supply": 100000000.0, "max_supply": 100000000.0, "quotes": { "USD": { "price": 8.8617574978, "volume_24h": 218236421.481627, "market_cap": 625098015.0, "percent_change_1h": 0.12, "percent_change_24h": 0.95, "percent_change_7d": -11.04 } }, "last_updated": 1567321564 }, 
        "1975": { "id": 1975, "name": "Chainlink", "symbol": "LINK", "website_slug": "chainlink", "rank": 21, "circulating_supply": 350000000.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 1.7811232784, "volume_24h": 47041736.7378079, "market_cap": 623393147.0, "percent_change_1h": 0.52, "percent_change_24h": -2.35, "percent_change_7d": -17.85 } }, "last_updated": 1567321564 }, 
        "1518": { "id": 1518, "name": "Maker", "symbol": "MKR", "website_slug": "maker", "rank": 22, "circulating_supply": 1000000.0, "total_supply": 1000000.0, "max_supply": null, "quotes": { "USD": { "price": 475.308975773, "volume_24h": 14760852.5575129, "market_cap": 475308976.0, "percent_change_1h": -0.29, "percent_change_24h": 0.52, "percent_change_7d": -5.39 } }, "last_updated": 1567321563 }, 
        "3408": { "id": 3408, "name": "USD Coin", "symbol": "USDC", "website_slug": "usd-coin", "rank": 23, "circulating_supply": 452413946.0, "total_supply": 453785690.0, "max_supply": null, "quotes": { "USD": { "price": 1.0015133152, "volume_24h": 84709734.6891402, "market_cap": 453098591.0, "percent_change_1h": -0.05, "percent_change_24h": -0.12, "percent_change_7d": -0.0 } }, "last_updated": 1567321571 }, 
        "873": { "id": 873, "name": "NEM", "symbol": "XEM", "website_slug": "nem", "rank": 24, "circulating_supply": 8999999999.0, "total_supply": 8999999999.0, "max_supply": null, "quotes": { "USD": { "price": 0.0486315659, "volume_24h": 6050818.98823844, "market_cap": 437684093.0, "percent_change_1h": 0.15, "percent_change_24h": -2.58, "percent_change_7d": -13.18 } }, "last_updated": 1567321562 }, 
        "3794": { "id": 3794, "name": "Cosmos", "symbol": "ATOM", "website_slug": "cosmos", "rank": 25, "circulating_supply": 190688439.0, "total_supply": 237928231.0, "max_supply": null, "quotes": { "USD": { "price": 2.0174505985, "volume_24h": 109332344.438112, "market_cap": 384704506.0, "percent_change_1h": 0.02, "percent_change_24h": -5.47, "percent_change_7d": -25.49 } }, "last_updated": 1567321574 }, 
        "2566": { "id": 2566, "name": "Ontology", "symbol": "ONT", "website_slug": "ontology", "rank": 26, "circulating_supply": 533483170.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.7099745752, "volume_24h": 38675240.8154258, "market_cap": 378759487.0, "percent_change_1h": -0.28, "percent_change_24h": -2.54, "percent_change_7d": -15.48 } }, "last_updated": 1567321568 }, 
        "3635": { "id": 3635, "name": "Crypto.com Chain", "symbol": "CRO", "website_slug": "crypto-com-chain", "rank": 27, "circulating_supply": 9363013699.0, "total_supply": 100000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0393348036, "volume_24h": 6366871.55356049, "market_cap": 368292304.0, "percent_change_1h": -1.96, "percent_change_24h": 0.55, "percent_change_7d": -8.37 } }, "last_updated": 1567321572 }, 
        "3085": { "id": 3085, "name": "INO COIN", "symbol": "INO", "website_slug": "ino-coin", "rank": 28, "circulating_supply": 180003180.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 1.8789240532, "volume_24h": 16581.231153932, "market_cap": 338212305.0, "percent_change_1h": -0.01, "percent_change_24h": -0.4, "percent_change_7d": -6.7 } }, "last_updated": 1567321570 }, 
        "1437": { "id": 1437, "name": "Zcash", "symbol": "ZEC", "website_slug": "zcash", "rank": 29, "circulating_supply": 7316594.0, "total_supply": 7316594.0, "max_supply": null, "quotes": { "USD": { "price": 45.3152052483, "volume_24h": 96160841.0952205, "market_cap": 331552947.0, "percent_change_1h": -0.08, "percent_change_24h": 1.04, "percent_change_7d": -9.81 } }, "last_updated": 1567321564 }, 
        "74": { "id": 74, "name": "Dogecoin", "symbol": "DOGE", "website_slug": "dogecoin", "rank": 30, "circulating_supply": 121023412767.0, "total_supply": 121023412767.0, "max_supply": null, "quotes": { "USD": { "price": 0.0024731731, "volume_24h": 22706731.119574, "market_cap": 299311853.0, "percent_change_1h": -0.0, "percent_change_24h": -0.03, "percent_change_7d": -9.12 } }, "last_updated": 1567321563 }, 
        "3662": { "id": 3662, "name": "HedgeTrade", "symbol": "HEDG", "website_slug": "hedgetrade", "rank": 31, "circulating_supply": 288393355.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.8860969387, "volume_24h": 477292.955305605, "market_cap": 255544469.0, "percent_change_1h": -0.19, "percent_change_24h": 0.39, "percent_change_7d": 8.56 } }, "last_updated": 1567321572 }, 
        "3704": { "id": 3704, "name": "V Systems", "symbol": "VSYS", "website_slug": "v-systems", "rank": 32, "circulating_supply": 1793659087.0, "total_supply": 3698517551.0, "max_supply": null, "quotes": { "USD": { "price": 0.1370140347, "volume_24h": 10286163.444376, "market_cap": 245756468.0, "percent_change_1h": -0.44, "percent_change_24h": -12.68, "percent_change_7d": -26.57 } }, "last_updated": 1567321573 }, 
        "1168": { "id": 1168, "name": "Decred", "symbol": "DCR", "website_slug": "decred", "rank": 33, "circulating_supply": 10320230.0, "total_supply": 10320230.0, "max_supply": 21000000.0, "quotes": { "USD": { "price": 22.9907962881, "volume_24h": 5823284.78570473, "market_cap": 237270315.0, "percent_change_1h": -0.06, "percent_change_24h": -0.18, "percent_change_7d": -7.48 } }, "last_updated": 1567321562 }, 
        "1697": { "id": 1697, "name": "Basic Attention Token", "symbol": "BAT", "website_slug": "basic-attention-token", "rank": 34, "circulating_supply": 1329225522.0, "total_supply": 1500000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1781833684, "volume_24h": 16819589.1817381, "market_cap": 236845881.0, "percent_change_1h": 0.02, "percent_change_24h": 0.15, "percent_change_7d": -11.98 } }, "last_updated": 1567321564 }, 
        "3077": { "id": 3077, "name": "VeChain", "symbol": "VET", "website_slug": "vechain", "rank": 35, "circulating_supply": 55454734800.0, "total_supply": 86712634466.0, "max_supply": null, "quotes": { "USD": { "price": 0.004077464, "volume_24h": 24706149.5272744, "market_cap": 226114685.0, "percent_change_1h": 0.03, "percent_change_24h": -2.22, "percent_change_7d": -15.45 } }, "last_updated": 1567321570 }, 
        "3916": { "id": 3916, "name": "ThoreNext", "symbol": "THX", "website_slug": "thorenext", "rank": 36, "circulating_supply": 21652254.0, "total_supply": 210000000.0, "max_supply": 210000000.0, "quotes": { "USD": { "price": 9.6240797028, "volume_24h": 199466.098539167, "market_cap": 208383018.0, "percent_change_1h": 0.03, "percent_change_24h": 0.08, "percent_change_7d": 147.2 } }, "last_updated": 1567321573 }, 
        "1684": { "id": 1684, "name": "Qtum", "symbol": "QTUM", "website_slug": "qtum", "rank": 37, "circulating_supply": 95984416.0, "total_supply": 101734436.0, "max_supply": 107822406.0, "quotes": { "USD": { "price": 2.1160064246, "volume_24h": 124093780.341369, "market_cap": 203103641.0, "percent_change_1h": 0.07, "percent_change_24h": 0.46, "percent_change_7d": -17.86 } }, "last_updated": 1567321565 }, 
        "3330": { "id": 3330, "name": "Paxos Standard Token", "symbol": "PAX", "website_slug": "paxos-standard-token", "rank": 38, "circulating_supply": 200065037.0, "total_supply": 200065117.0, "max_supply": null, "quotes": { "USD": { "price": 1.0028825111, "volume_24h": 251272489.410458, "market_cap": 200641726.0, "percent_change_1h": 0.0, "percent_change_24h": -0.0, "percent_change_7d": 0.08 } }, "last_updated": 1567321571 }, 
        "2563": { "id": 2563, "name": "TrueUSD", "symbol": "TUSD", "website_slug": "trueusd", "rank": 39, "circulating_supply": 199718110.0, "total_supply": 199718110.0, "max_supply": null, "quotes": { "USD": { "price": 1.0015410545, "volume_24h": 300045629.666058, "market_cap": 200025886.0, "percent_change_1h": -0.02, "percent_change_24h": -0.08, "percent_change_7d": -0.09 } }, "last_updated": 1567321568 }, 
        "2083": { "id": 2083, "name": "Bitcoin Gold", "symbol": "BTG", "website_slug": "bitcoin-gold", "rank": 40, "circulating_supply": 17513924.0, "total_supply": 17513924.0, "max_supply": 21000000.0, "quotes": { "USD": { "price": 10.743834904, "volume_24h": 12620199.0801744, "market_cap": 188166704.0, "percent_change_1h": -0.09, "percent_change_24h": -3.5, "percent_change_7d": -22.62 } }, "last_updated": 1567321566 }, 
        "3364": { "id": 3364, "name": "PLATINCOIN", "symbol": "PLC", "website_slug": "platincoin", "rank": 41, "circulating_supply": 5001073.0, "total_supply": 600027190.0, "max_supply": null, "quotes": { "USD": { "price": 31.1183386006, "volume_24h": 3030605.86194949, "market_cap": 155625083.0, "percent_change_1h": 0.59, "percent_change_24h": 1.26, "percent_change_7d": -2.69 } }, "last_updated": 1567321571 }, 
        "1808": { "id": 1808, "name": "OmiseGO", "symbol": "OMG", "website_slug": "omisego", "rank": 42, "circulating_supply": 140245398.0, "total_supply": 140245398.0, "max_supply": null, "quotes": { "USD": { "price": 1.1005264822, "volume_24h": 33398778.6184898, "market_cap": 154343775.0, "percent_change_1h": -0.04, "percent_change_24h": 1.74, "percent_change_7d": -14.02 } }, "last_updated": 1567321565 }, 
        "3351": { "id": 3351, "name": "ZB", "symbol": "ZB", "website_slug": "zb", "rank": 43, "circulating_supply": 463288810.0, "total_supply": 2100000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.3261431621, "volume_24h": 34916269.4937734, "market_cap": 151098477.0, "percent_change_1h": -0.03, "percent_change_24h": -0.43, "percent_change_7d": -4.87 } }, "last_updated": 1567321570 }, 
        "3144": { "id": 3144, "name": "ThoreCoin", "symbol": "THR", "website_slug": "thorecoin", "rank": 44, "circulating_supply": 86686.0, "total_supply": 100000.0, "max_supply": null, "quotes": { "USD": { "price": 1731.10197135, "volume_24h": 197975.927457662, "market_cap": 150062343.0, "percent_change_1h": 0.08, "percent_change_24h": 0.13, "percent_change_7d": -3.82 } }, "last_updated": 1567321569 }, 
        "2577": { "id": 2577, "name": "Ravencoin", "symbol": "RVN", "website_slug": "ravencoin", "rank": 45, "circulating_supply": 4321295000.0, "total_supply": 4321295000.0, "max_supply": 21000000000.0, "quotes": { "USD": { "price": 0.0312979222, "volume_24h": 5393683.01338635, "market_cap": 135247555.0, "percent_change_1h": -2.14, "percent_change_24h": -2.24, "percent_change_7d": -18.32 } }, "last_updated": 1567321568 }, 
        "1214": { "id": 1214, "name": "Lisk", "symbol": "LSK", "website_slug": "lisk", "rank": 46, "circulating_supply": 119774240.0, "total_supply": 134870653.0, "max_supply": null, "quotes": { "USD": { "price": 1.1177690613, "volume_24h": 2168637.36045072, "market_cap": 133879940.0, "percent_change_1h": 0.0, "percent_change_24h": 2.11, "percent_change_7d": -6.85 } }, "last_updated": 1567321562 }, 
        "1567": { "id": 1567, "name": "Nano", "symbol": "NANO", "website_slug": "nano", "rank": 47, "circulating_supply": 133248297.0, "total_supply": 133248297.0, "max_supply": 133248297.0, "quotes": { "USD": { "price": 0.9460421505, "volume_24h": 2124704.70400195, "market_cap": 126058506.0, "percent_change_1h": -0.6, "percent_change_24h": -2.17, "percent_change_7d": -8.79 } }, "last_updated": 1567321563 }, 
        "2087": { "id": 2087, "name": "KuCoin Shares", "symbol": "KCS", "website_slug": "kucoin-shares", "rank": 48, "circulating_supply": 88165556.0, "total_supply": 178165556.0, "max_supply": null, "quotes": { "USD": { "price": 1.3693203217, "volume_24h": 15879085.5810089, "market_cap": 120726888.0, "percent_change_1h": 0.24, "percent_change_24h": -1.75, "percent_change_7d": -10.81 } }, "last_updated": 1567321564 }, 
        "3116": { "id": 3116, "name": "Insight Chain", "symbol": "INB", "website_slug": "insight-chain", "rank": 49, "circulating_supply": 349902689.0, "total_supply": 10000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.3428095439, "volume_24h": 8879896.45754702, "market_cap": 119949981.0, "percent_change_1h": 0.18, "percent_change_24h": -1.63, "percent_change_7d": 0.93 } }, "last_updated": 1567321570 }, 
        "4030": { "id": 4030, "name": "Algorand", "symbol": "ALGO", "website_slug": "algorand", "rank": 50, "circulating_supply": 283429365.0, "total_supply": 2814701208.0, "max_supply": null, "quotes": { "USD": { "price": 0.4118276534, "volume_24h": 54118184.0287721, "market_cap": 116724050.0, "percent_change_1h": 0.11, "percent_change_24h": -2.17, "percent_change_7d": -28.29 } }, "last_updated": 1567321573 }
    }, 
    "metadata": { "timestamp": 1567321226, "warning": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", "num_cryptocurrencies": 2341, "error": null } }
''';
    const String second50Coins = '''
{ "attention": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", 
    "data": {
        "1274": { "id": 1274, "name": "Waves", "symbol": "WAVES", "website_slug": "waves", "rank": 51, "circulating_supply": 100000000.0, "total_supply": 100000000.0, "max_supply": null, "quotes": { "USD": { "price": 1.1147279745, "volume_24h": 8517749.4305706, "market_cap": 111472797.0, "percent_change_1h": 0.41, "percent_change_24h": -1.09, "percent_change_7d": -14.8 } }, "last_updated": 1567323183 }, 
        "3718": { "id": 3718, "name": "BitTorrent", "symbol": "BTT", "website_slug": "bittorrent", "rank": 52, "circulating_supply": 212116500000.0, "total_supply": 990000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0005237442, "volume_24h": 37989268.608981, "market_cap": 111094782.0, "percent_change_1h": 0.03, "percent_change_24h": -2.0, "percent_change_7d": -16.32 } }, "last_updated": 1567323192 }, 
        "2682": { "id": 2682, "name": "Holo", "symbol": "HOT", "website_slug": "holo", "rank": 53, "circulating_supply": 133214575156.0, "total_supply": 177619433541.0, "max_supply": null, "quotes": { "USD": { "price": 0.0008126105, "volume_24h": 7062769.95498654, "market_cap": 108251562.0, "percent_change_1h": 0.61, "percent_change_24h": -0.97, "percent_change_7d": -6.91 } }, "last_updated": 1567323187 }, 
        "2222": { "id": 2222, "name": "Bitcoin Diamond", "symbol": "BCD", "website_slug": "bitcoin-diamond", "rank": 54, "circulating_supply": 186492898.0, "total_supply": 189492898.0, "max_supply": 210000000.0, "quotes": { "USD": { "price": 0.5782523205, "volume_24h": 2800944.60287876, "market_cap": 107839951.0, "percent_change_1h": 0.06, "percent_change_24h": -8.11, "percent_change_7d": -19.34 } }, "last_updated": 1567323185 }, 
        "3218": { "id": 3218, "name": "Energi", "symbol": "NRG", "website_slug": "energi", "rank": 55, "circulating_supply": 20161403.0, "total_supply": 20161403.0, "max_supply": null, "quotes": { "USD": { "price": 5.2375043857, "volume_24h": 632284.719886202, "market_cap": 105595435.0, "percent_change_1h": 0.07, "percent_change_24h": -3.1, "percent_change_7d": -15.81 } }, "last_updated": 1567323189 }, 
        "2416": { "id": 2416, "name": "THETA", "symbol": "THETA", "website_slug": "theta", "rank": 56, "circulating_supply": 870502690.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1209318428, "volume_24h": 652477.295437248, "market_cap": 105271494.0, "percent_change_1h": 0.25, "percent_change_24h": 2.42, "percent_change_7d": -6.89 } }, "last_updated": 1567323186 }, 
        "3657": { "id": 3657, "name": "Lambda", "symbol": "LAMB", "website_slug": "lambda", "rank": 57, "circulating_supply": 634522659.0, "total_supply": 6000000000.0, "max_supply": 10000000000.0, "quotes": { "USD": { "price": 0.1644764262, "volume_24h": 45950518.5400265, "market_cap": 104364019.0, "percent_change_1h": -2.73, "percent_change_24h": 3.25, "percent_change_7d": -2.22 } }, "last_updated": 1567323191 }, 
        "2453": { "id": 2453, "name": "EDUCare", "symbol": "EKT", "website_slug": "educare", "rank": 58, "circulating_supply": 750000000.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1389956326, "volume_24h": 8693318.9352266, "market_cap": 104246724.0, "percent_change_1h": 0.88, "percent_change_24h": 2.91, "percent_change_7d": -0.1 } }, "last_updated": 1567323186 }, 
        "2349": { "id": 2349, "name": "Mixin", "symbol": "XIN", "website_slug": "mixin", "rank": 59, "circulating_supply": 457186.0, "total_supply": 1000000.0, "max_supply": 1000000.0, "quotes": { "USD": { "price": 222.766807412, "volume_24h": 3110168.38360125, "market_cap": 101845928.0, "percent_change_1h": -0.98, "percent_change_24h": 6.9, "percent_change_7d": -3.6 } }, "last_updated": 1567323185 }, 
        "2099": { "id": 2099, "name": "ICON", "symbol": "ICX", "website_slug": "icon", "rank": 60, "circulating_supply": 491195432.0, "total_supply": 800460000.0, "max_supply": null, "quotes": { "USD": { "price": 0.2061107333, "volume_24h": 11655869.368502, "market_cap": 101240651.0, "percent_change_1h": -0.03, "percent_change_24h": -2.48, "percent_change_7d": -13.05 } }, "last_updated": 1567323185 }, 
        "372": { "id": 372, "name": "Bytecoin", "symbol": "BCN", "website_slug": "bytecoin-bcn", "rank": 61, "circulating_supply": 184066828814.0, "total_supply": 184066828814.0, "max_supply": 184470000000.0, "quotes": { "USD": { "price": 0.0005498088, "volume_24h": 16868.8064876905, "market_cap": 101201570.0, "percent_change_1h": -2.37, "percent_change_24h": 2.17, "percent_change_7d": -7.39 } }, "last_updated": 1567323181 }, 
        "2897": { "id": 2897, "name": "Clipper Coin", "symbol": "CCCX", "website_slug": "clipper-coin", "rank": 62, "circulating_supply": 3780570996.0, "total_supply": 5000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0267018207, "volume_24h": 48890.5537429339, "market_cap": 100948129.0, "percent_change_1h": 0.33, "percent_change_24h": 17.94, "percent_change_7d": 5.75 } }, "last_updated": 1567323188 }, 
        "109": { "id": 109, "name": "DigiByte", "symbol": "DGB", "website_slug": "digibyte", "rank": 63, "circulating_supply": 12213013310.0, "total_supply": 12213013310.0, "max_supply": 21000000000.0, "quotes": { "USD": { "price": 0.0081899402, "volume_24h": 2181430.48043919, "market_cap": 100023849.0, "percent_change_1h": 0.3, "percent_change_24h": 1.49, "percent_change_7d": -9.14 } }, "last_updated": 1567323181 }, 
        "1896": { "id": 1896, "name": "0x", "symbol": "ZRX", "website_slug": "0x", "rank": 64, "circulating_supply": 600475853.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1616053817, "volume_24h": 5783043.79334278, "market_cap": 97040130.0, "percent_change_1h": 0.01, "percent_change_24h": -0.92, "percent_change_7d": -13.43 } }, "last_updated": 1567323184 }, 
        "4203": { "id": 4203, "name": "Oasis City", "symbol": "OSC", "website_slug": "oasis-city", "rank": 65, "circulating_supply": 2085965471.0, "total_supply": 12000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0457646355, "volume_24h": 543387.703231587, "market_cap": 95463450.0, "percent_change_1h": 0.93, "percent_change_24h": 2.96, "percent_change_7d": -15.07 } }, "last_updated": 1567323192 }, 
        "1903": { "id": 1903, "name": "HyperCash", "symbol": "HC", "website_slug": "hypercash", "rank": 66, "circulating_supply": 43529781.0, "total_supply": 43529781.0, "max_supply": 84000000.0, "quotes": { "USD": { "price": 2.1483680974, "volume_24h": 2653668.41176256, "market_cap": 93517992.0, "percent_change_1h": 0.35, "percent_change_24h": 0.68, "percent_change_7d": -13.3 } }, "last_updated": 1567323184 }, 
        "2603": { "id": 2603, "name": "Pundi X", "symbol": "NPXS", "website_slug": "pundi-x", "rank": 67, "circulating_supply": 235621468515.0, "total_supply": 261834927333.0, "max_supply": null, "quotes": { "USD": { "price": 0.0003916251, "volume_24h": 1714544.68010191, "market_cap": 92275286.0, "percent_change_1h": -1.08, "percent_change_24h": -0.79, "percent_change_7d": -9.45 } }, "last_updated": 1567323187 }, 
        "2874": { "id": 2874, "name": "Aurora", "symbol": "AOA", "website_slug": "aurora", "rank": 68, "circulating_supply": 6542330148.0, "total_supply": 10000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0140845539, "volume_24h": 3436181.37598032, "market_cap": 92145802.0, "percent_change_1h": 4.62, "percent_change_24h": 5.16, "percent_change_7d": -12.43 } }, "last_updated": 1567323188 }, 
        "463": { "id": 463, "name": "BitShares", "symbol": "BTS", "website_slug": "bitshares", "rank": 69, "circulating_supply": 2741440000.0, "total_supply": 2741440000.0, "max_supply": 3600570502.0, "quotes": { "USD": { "price": 0.0334369458, "volume_24h": 1624755.09499952, "market_cap": 91665381.0, "percent_change_1h": 0.07, "percent_change_24h": -0.86, "percent_change_7d": -17.5 } }, "last_updated": 1567323181 }, 
        "3620": { "id": 3620, "name": "Atlas Protocol", "symbol": "ATP", "website_slug": "atlas-protocol", "rank": 70, "circulating_supply": 2576065703.0, "total_supply": 4000000000.0, "max_supply": 10000000000.0, "quotes": { "USD": { "price": 0.0349283841, "volume_24h": 5687191.32180908, "market_cap": 89977812.0, "percent_change_1h": 1.01, "percent_change_24h": 18.02, "percent_change_7d": 9.25 } }, "last_updated": 1567323191 }, 
        "3134": { "id": 3134, "name": "ETERNAL TOKEN", "symbol": "XET", "website_slug": "eternal-token", "rank": 71, "circulating_supply": 93470000.0, "total_supply": 200000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.9550519356, "volume_24h": 149360.500583699, "market_cap": 89268704.0, "percent_change_1h": -1.37, "percent_change_24h": 3.94, "percent_change_7d": -7.03 } }, "last_updated": 1567323189 }, 
        "1104": { "id": 1104, "name": "Augur", "symbol": "REP", "website_slug": "augur", "rank": 72, "circulating_supply": 11000000.0, "total_supply": 11000000.0, "max_supply": null, "quotes": { "USD": { "price": 7.9481784481, "volume_24h": 5521656.85916259, "market_cap": 87429963.0, "percent_change_1h": 0.23, "percent_change_24h": -0.68, "percent_change_7d": -19.46 } }, "last_updated": 1567323182 }, 
        "2405": { "id": 2405, "name": "IOST", "symbol": "IOST", "website_slug": "iostoken", "rank": 73, "circulating_supply": 12013965609.0, "total_supply": 21000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0071853273, "volume_24h": 21384223.6606065, "market_cap": 86324275.0, "percent_change_1h": 0.33, "percent_change_24h": -2.61, "percent_change_7d": -16.13 } }, "last_updated": 1567323186 }, 
        "2907": { "id": 2907, "name": "Karatgold Coin", "symbol": "KBC", "website_slug": "karatgold-coin", "rank": 74, "circulating_supply": 4211824582.0, "total_supply": 12000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0198683705, "volume_24h": 2470437.51944739, "market_cap": 83682091.0, "percent_change_1h": 0.42, "percent_change_24h": -2.26, "percent_change_7d": -8.77 } }, "last_updated": 1567323188 }, 
        "213": { "id": 213, "name": "MonaCoin", "symbol": "MONA", "website_slug": "monacoin", "rank": 75, "circulating_supply": 65729675.0, "total_supply": 65729675.0, "max_supply": null, "quotes": { "USD": { "price": 1.2567605642, "volume_24h": 928056.747195017, "market_cap": 82606463.0, "percent_change_1h": -0.83, "percent_change_24h": 1.4, "percent_change_7d": -14.7 } }, "last_updated": 1567323181 }, 
        "3829": { "id": 3829, "name": "Nash Exchange", "symbol": "NEX", "website_slug": "nash-exchange", "rank": 76, "circulating_supply": 36196678.0, "total_supply": 56296100.0, "max_supply": null, "quotes": { "USD": { "price": 2.2503415425, "volume_24h": 3364978.01796299, "market_cap": 81454888.0, "percent_change_1h": -0.16, "percent_change_24h": 2.32, "percent_change_7d": -9.62 } }, "last_updated": 1567323191 }, 
        "3788": { "id": 3788, "name": "NEXT", "symbol": "NET", "website_slug": "next", "rank": 77, "circulating_supply": 50269268.0, "total_supply": 973628555.0, "max_supply": null, "quotes": { "USD": { "price": 1.6134038862, "volume_24h": 8669587.06807948, "market_cap": 81104632.0, "percent_change_1h": -0.04, "percent_change_24h": 3.73, "percent_change_7d": 1.11 } }, "last_updated": 1567323191 }, 
        "1866": { "id": 1866, "name": "Bytom", "symbol": "BTM", "website_slug": "bytom", "rank": 78, "circulating_supply": 1002499275.0, "total_supply": 1407000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0796244876, "volume_24h": 5659451.78838882, "market_cap": 79823491.0, "percent_change_1h": 0.04, "percent_change_24h": 0.1, "percent_change_7d": -8.83 } }, "last_updated": 1567323184 }, 
        "2885": { "id": 2885, "name": "Egretia", "symbol": "EGT", "website_slug": "egretia", "rank": 79, "circulating_supply": 4215883885.0, "total_supply": 8000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.018535784, "volume_24h": 19981833.5949136, "market_cap": 78144713.0, "percent_change_1h": -0.08, "percent_change_24h": -19.6, "percent_change_7d": -6.88 } }, "last_updated": 1567323188 }, 
        "1521": { "id": 1521, "name": "Komodo", "symbol": "KMD", "website_slug": "komodo", "rank": 80, "circulating_supply": 115707775.0, "total_supply": 115707775.0, "max_supply": 200000000.0, "quotes": { "USD": { "price": 0.6708815842, "volume_24h": 1681027.33558771, "market_cap": 77626215.0, "percent_change_1h": -0.38, "percent_change_24h": -5.24, "percent_change_7d": -20.28 } }, "last_updated": 1567323182 }, 
        "2308": { "id": 2308, "name": "Dai", "symbol": "DAI", "website_slug": "dai", "rank": 81, "circulating_supply": 76589000.0, "total_supply": 76589000.0, "max_supply": null, "quotes": { "USD": { "price": 1.0047322965, "volume_24h": 19375324.022323, "market_cap": 76951441.0, "percent_change_1h": 0.07, "percent_change_24h": -0.11, "percent_change_7d": 0.2 } }, "last_updated": 1567323186 }, 
        "291": { "id": 291, "name": "MaidSafeCoin", "symbol": "MAID", "website_slug": "maidsafecoin", "rank": 82, "circulating_supply": 452552412.0, "total_supply": 452552412.0, "max_supply": null, "quotes": { "USD": { "price": 0.16967654, "volume_24h": 176182.113675984, "market_cap": 76787527.0, "percent_change_1h": -0.75, "percent_change_24h": 2.24, "percent_change_7d": 2.63 } }, "last_updated": 1567323181 }, 
        "3840": { "id": 3840, "name": "1irstcoin", "symbol": "FST", "website_slug": "1irstcoin", "rank": 83, "circulating_supply": 22085000.0, "total_supply": 100000000.0, "max_supply": null, "quotes": { "USD": { "price": 3.4664834259, "volume_24h": 205355.307287603, "market_cap": 76557286.0, "percent_change_1h": 0.66, "percent_change_24h": 4.36, "percent_change_7d": 35.9 } }, "last_updated": 1567323191 }, 
        "3404": { "id": 3404, "name": "Wixlar", "symbol": "WIX", "website_slug": "wixlar", "rank": 84, "circulating_supply": 2391608888.0, "total_supply": 5330000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0320080705, "volume_24h": 14811.3376860727, "market_cap": 76550786.0, "percent_change_1h": 0.06, "percent_change_24h": -8.43, "percent_change_7d": 3.07 } }, "last_updated": 1567323190 }, 
        "1042": { "id": 1042, "name": "Siacoin", "symbol": "SC", "website_slug": "siacoin", "rank": 85, "circulating_supply": 41817047634.0, "total_supply": 41817047634.0, "max_supply": null, "quotes": { "USD": { "price": 0.0018203631, "volume_24h": 1111745.98283001, "market_cap": 76122211.0, "percent_change_1h": 0.19, "percent_change_24h": 0.73, "percent_change_7d": -15.61 } }, "last_updated": 1567323181 }, 
        "4049": { "id": 4049, "name": "Bitbook Gambling", "symbol": "BXK", "website_slug": "bitbook-gambling", "rank": 86, "circulating_supply": 368387491.0, "total_supply": 741456054.0, "max_supply": null, "quotes": { "USD": { "price": 0.1981875312, "volume_24h": 1004066.41398261, "market_cap": 73009807.0, "percent_change_1h": -0.4, "percent_change_24h": -3.26, "percent_change_7d": -5.25 } }, "last_updated": 1567323192 }, 
        "693": { "id": 693, "name": "Verge", "symbol": "XVG", "website_slug": "verge", "rank": 87, "circulating_supply": 15912340629.0, "total_supply": 15912340629.0, "max_supply": 16555000000.0, "quotes": { "USD": { "price": 0.004483558, "volume_24h": 902232.881487659, "market_cap": 71343902.0, "percent_change_1h": -0.95, "percent_change_24h": -1.83, "percent_change_7d": -18.16 } }, "last_updated": 1567323181 }, 
        "3987": { "id": 3987, "name": "Beldex", "symbol": "BDX", "website_slug": "beldex", "rank": 88, "circulating_supply": 980222595.0, "total_supply": 1400222610.0, "max_supply": null, "quotes": { "USD": { "price": 0.0716276127, "volume_24h": 804543.587353718, "market_cap": 70211004.0, "percent_change_1h": -0.47, "percent_change_24h": 0.72, "percent_change_7d": -8.58 } }, "last_updated": 1567323192 }, 
        "3155": { "id": 3155, "name": "Quant", "symbol": "QNT", "website_slug": "quant", "rank": 89, "circulating_supply": 12072738.0, "total_supply": 14612493.0, "max_supply": null, "quotes": { "USD": { "price": 5.7151693764, "volume_24h": 1680778.91359883, "market_cap": 68997743.0, "percent_change_1h": -1.16, "percent_change_24h": -2.8, "percent_change_7d": -13.49 } }, "last_updated": 1567323189 }, 
        "3224": { "id": 3224, "name": "Qubitica", "symbol": "QBIT", "website_slug": "qubitica", "rank": 90, "circulating_supply": 2085316.0, "total_supply": 10000000.0, "max_supply": null, "quotes": { "USD": { "price": 31.5326471906, "volume_24h": 119732.965821735, "market_cap": 65755540.0, "percent_change_1h": -0.1, "percent_change_24h": 1.99, "percent_change_7d": -14.44 } }, "last_updated": 1567323189 }, 
        "3701": { "id": 3701, "name": "RIF Token", "symbol": "RIF", "website_slug": "rif-token", "rank": 91, "circulating_supply": 477980957.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1318055198, "volume_24h": 2801668.89690418, "market_cap": 63000528.0, "percent_change_1h": 0.46, "percent_change_24h": -0.36, "percent_change_7d": -13.21 } }, "last_updated": 1567323191 }, 
        "2469": { "id": 2469, "name": "Zilliqa", "symbol": "ZIL", "website_slug": "zilliqa", "rank": 92, "circulating_supply": 8687360058.0, "total_supply": 12533042435.0, "max_supply": null, "quotes": { "USD": { "price": 0.0071387339, "volume_24h": 5898210.22736847, "market_cap": 62016752.0, "percent_change_1h": 0.01, "percent_change_24h": 0.65, "percent_change_7d": -16.75 } }, "last_updated": 1567323187 }, 
        "4206": { "id": 4206, "name": "WINk", "symbol": "WIN", "website_slug": "wink-tronbet", "rank": 93, "circulating_supply": 196500113934.0, "total_supply": 999000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0003115039, "volume_24h": 14063060.7630018, "market_cap": 61210547.0, "percent_change_1h": 0.39, "percent_change_24h": -1.01, "percent_change_7d": -3.04 } }, "last_updated": 1567323192 }, 
        "1700": { "id": 1700, "name": "Aeternity", "symbol": "AE", "website_slug": "aeternity", "rank": 94, "circulating_supply": 281204650.0, "total_supply": 327025593.0, "max_supply": null, "quotes": { "USD": { "price": 0.2108874453, "volume_24h": 11997796.6346641, "market_cap": 59302530.0, "percent_change_1h": -0.23, "percent_change_24h": -1.8, "percent_change_7d": -14.74 } }, "last_updated": 1567323183 }, 
        "1455": { "id": 1455, "name": "Golem", "symbol": "GNT", "website_slug": "golem-network-tokens", "rank": 95, "circulating_supply": 964450000.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0604050897, "volume_24h": 1835507.5268903, "market_cap": 58257689.0, "percent_change_1h": 0.02, "percent_change_24h": -0.17, "percent_change_7d": 4.12 } }, "last_updated": 1567323183 }, 
        "1230": { "id": 1230, "name": "Steem", "symbol": "STEEM", "website_slug": "steem", "rank": 96, "circulating_supply": 343219037.0, "total_supply": 360193131.0, "max_supply": null, "quotes": { "USD": { "price": 0.1667783204, "volume_24h": 374809.528360697, "market_cap": 57241495.0, "percent_change_1h": -0.19, "percent_change_24h": 0.62, "percent_change_7d": -12.56 } }, "last_updated": 1567323182 }, 
        "1703": { "id": 1703, "name": "Metaverse ETP", "symbol": "ETP", "website_slug": "metaverse", "rank": 97, "circulating_supply": 76116890.0, "total_supply": 76462016.0, "max_supply": 100000000.0, "quotes": { "USD": { "price": 0.7245666198, "volume_24h": 2701186.29253961, "market_cap": 55151758.0, "percent_change_1h": 0.37, "percent_change_24h": -7.53, "percent_change_7d": -16.26 } }, "last_updated": 1567323183 }, 
        "2130": { "id": 2130, "name": "Enjin Coin", "symbol": "ENJ", "website_slug": "enjin-coin", "rank": 98, "circulating_supply": 776278713.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0709977987, "volume_24h": 6735616.84179233, "market_cap": 55114080.0, "percent_change_1h": -0.95, "percent_change_24h": 9.73, "percent_change_7d": -1.79 } }, "last_updated": 1567323185 }, 
        "1759": { "id": 1759, "name": "Status", "symbol": "SNT", "website_slug": "status", "rank": 99, "circulating_supply": 3470483788.0, "total_supply": 6804870174.0, "max_supply": null, "quotes": { "USD": { "price": 0.0156223441, "volume_24h": 9259912.31220474, "market_cap": 54217092.0, "percent_change_1h": 0.0, "percent_change_24h": -0.51, "percent_change_7d": -16.42 } }, "last_updated": 1567323183 }, 
        "1320": { "id": 1320, "name": "Ardor", "symbol": "ARDR", "website_slug": "ardor", "rank": 100, "circulating_supply": 998999495.0, "total_supply": 998999495.0, "max_supply": 998999495.0, "quotes": { "USD": { "price": 0.0537472872, "volume_24h": 543255.150150407, "market_cap": 53693513.0, "percent_change_1h": 0.22, "percent_change_24h": 0.75, "percent_change_7d": -16.18 } }, "last_updated": 1567323182 }, 
        "3812": { "id": 3812, "name": "Flexacoin", "symbol": "FXC", "website_slug": "flexacoin", "rank": 101, "circulating_supply": 20267695749.0, "total_supply": 20267695749.0, "max_supply": 100000000000.0, "quotes": { "USD": { "price": 0.0026114748, "volume_24h": 4923.6151472646, "market_cap": 52928576.0, "percent_change_1h": -0.03, "percent_change_24h": 2.85, "percent_change_7d": -22.98 } }, "last_updated": 1567323191 }, 
        "1776": { "id": 1776, "name": "Crypto.com", "symbol": "MCO", "website_slug": "crypto-com", "rank": 102, "circulating_supply": 15793831.0, "total_supply": 31587682.0, "max_supply": null, "quotes": { "USD": { "price": 3.3406779312, "volume_24h": 4259007.58429878, "market_cap": 52762103.0, "percent_change_1h": 0.86, "percent_change_24h": 1.51, "percent_change_7d": -6.09 } }, "last_updated": 1567323183 }, 
        "1750": { "id": 1750, "name": "GXChain", "symbol": "GXC", "website_slug": "gxchain", "rank": 103, "circulating_supply": 65000000.0, "total_supply": 99845440.0, "max_supply": 100000000.0, "quotes": { "USD": { "price": 0.7923602559, "volume_24h": 3194254.24024575, "market_cap": 51503417.0, "percent_change_1h": -0.58, "percent_change_24h": -3.86, "percent_change_7d": -18.12 } }, "last_updated": 1567323183 }, 
        "3437": { "id": 3437, "name": "ABBC Coin", "symbol": "ABBC", "website_slug": "abbc-coin", "rank": 104, "circulating_supply": 554307762.0, "total_supply": 1002169590.0, "max_supply": null, "quotes": { "USD": { "price": 0.0928407217, "volume_24h": 50554936.1725861, "market_cap": 51462333.0, "percent_change_1h": 0.16, "percent_change_24h": 3.28, "percent_change_7d": -26.24 } }, "last_updated": 1567323190 }, 
        "1925": { "id": 1925, "name": "Waltonchain", "symbol": "WTC", "website_slug": "waltonchain", "rank": 105, "circulating_supply": 42252004.0, "total_supply": 70000000.0, "max_supply": 100000000.0, "quotes": { "USD": { "price": 1.2153930481, "volume_24h": 3474690.56598012, "market_cap": 51352792.0, "percent_change_1h": 3.35, "percent_change_24h": 4.59, "percent_change_7d": -16.42 } }, "last_updated": 1567323184 }, 
        "2539": { "id": 2539, "name": "Ren", "symbol": "REN", "website_slug": "ren", "rank": 106, "circulating_supply": 795594931.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0643852303, "volume_24h": 2909220.0700271, "market_cap": 51224563.0, "percent_change_1h": -0.17, "percent_change_24h": -6.68, "percent_change_7d": -19.04 } }, "last_updated": 1567323187 }, 
        "3897": { "id": 3897, "name": "OKB", "symbol": "OKB", "website_slug": "okb", "rank": 107, "circulating_supply": 20000000.0, "total_supply": 300000000.0, "max_supply": null, "quotes": { "USD": { "price": 2.5279341897, "volume_24h": 88739024.254834, "market_cap": 50558684.0, "percent_change_1h": -0.04, "percent_change_24h": 2.29, "percent_change_7d": -15.31 } }, "last_updated": 1567323192 }, 
        "3828": { "id": 3828, "name": "Japan Content Token", "symbol": "JCT", "website_slug": "japan-content-token", "rank": 108, "circulating_supply": 293150782.0, "total_supply": 2500000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1710191416, "volume_24h": 237475.636982861, "market_cap": 50134395.0, "percent_change_1h": 0.0, "percent_change_24h": 10.57, "percent_change_7d": -14.04 } }, "last_updated": 1567323191 }, 
        "3344": { "id": 3344, "name": "Ecoreal Estate", "symbol": "ECOREAL", "website_slug": "ecoreal-estate", "rank": 109, "circulating_supply": 210031903.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.2355760526, "volume_24h": 22007.5703318568, "market_cap": 49478487.0, "percent_change_1h": 0.02, "percent_change_24h": 0.23, "percent_change_7d": 5.76 } }, "last_updated": 1567323190 }, 
        "1414": { "id": 1414, "name": "Zcoin", "symbol": "XZC", "website_slug": "zcoin", "rank": 110, "circulating_supply": 8274843.0, "total_supply": 21400000.0, "max_supply": 21400000.0, "quotes": { "USD": { "price": 5.6958959565, "volume_24h": 2878701.25733206, "market_cap": 47132647.0, "percent_change_1h": 0.05, "percent_change_24h": -1.71, "percent_change_7d": -18.75 } }, "last_updated": 1567323182 }, 
        "3607": { "id": 3607, "name": "VestChain", "symbol": "VEST", "website_slug": "vestchain", "rank": 111, "circulating_supply": 7078400000.0, "total_supply": 8848000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0064331636, "volume_24h": 170976.186157433, "market_cap": 45536506.0, "percent_change_1h": 2.15, "percent_change_24h": 4.8, "percent_change_7d": -4.23 } }, "last_updated": 1567323190 }, 
        "2586": { "id": 2586, "name": "Synthetix Network Token", "symbol": "SNX", "website_slug": "synthetix-network-token", "rank": 112, "circulating_supply": 127447605.0, "total_supply": 136057692.0, "max_supply": null, "quotes": { "USD": { "price": 0.3569282425, "volume_24h": 12125.2997363765, "market_cap": 45489650.0, "percent_change_1h": 0.26, "percent_change_24h": -2.92, "percent_change_7d": 24.6 } }, "last_updated": 1567323187 }, 
        "3115": { "id": 3115, "name": "Maximine Coin", "symbol": "MXM", "website_slug": "maximine-coin", "rank": 113, "circulating_supply": 1649000000.0, "total_supply": 16000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0269306293, "volume_24h": 3299992.9271151, "market_cap": 44408608.0, "percent_change_1h": -1.33, "percent_change_24h": -7.97, "percent_change_7d": -6.84 } }, "last_updated": 1567323189 }, 
        "3724": { "id": 3724, "name": "SOLVE", "symbol": "SOLVE", "website_slug": "solve", "rank": 114, "circulating_supply": 327244058.0, "total_supply": 1000000000.0, "max_supply": 1000000000.0, "quotes": { "USD": { "price": 0.1338554755, "volume_24h": 1097585.49134652, "market_cap": 43803409.0, "percent_change_1h": -0.26, "percent_change_24h": 5.19, "percent_change_7d": 13.36 } }, "last_updated": 1567323191 }, 
        "4067": { "id": 4067, "name": "Cryptoindex.com 100", "symbol": "CIX100", "website_slug": "cryptoindex-com-100", "rank": 115, "circulating_supply": 60864742.0, "total_supply": 300000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.6906800897, "volume_24h": 67733.4843631721, "market_cap": 42038065.0, "percent_change_1h": -0.01, "percent_change_24h": 0.35, "percent_change_7d": -6.2 } }, "last_updated": 1567323192 }, 
        "1343": { "id": 1343, "name": "Stratis", "symbol": "STRAT", "website_slug": "stratis", "rank": 116, "circulating_supply": 99468244.0, "total_supply": 99468244.0, "max_supply": null, "quotes": { "USD": { "price": 0.4002257065, "volume_24h": 1167628.31397874, "market_cap": 39809748.0, "percent_change_1h": -0.1, "percent_change_24h": 1.55, "percent_change_7d": -6.24 } }, "last_updated": 1567323182 }, 
        "2299": { "id": 2299, "name": "aelf", "symbol": "ELF", "website_slug": "aelf", "rank": 117, "circulating_supply": 499780000.0, "total_supply": 880000000.0, "max_supply": 1000000000.0, "quotes": { "USD": { "price": 0.0794492499, "volume_24h": 7699703.73173034, "market_cap": 39707146.0, "percent_change_1h": 0.63, "percent_change_24h": 3.57, "percent_change_7d": -8.87 } }, "last_updated": 1567323185 }, 
        "2300": { "id": 2300, "name": "WAX", "symbol": "WAX", "website_slug": "wax", "rank": 118, "circulating_supply": 942821662.0, "total_supply": 1850000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0419526986, "volume_24h": 68033.9514138221, "market_cap": 39553913.0, "percent_change_1h": -1.05, "percent_change_24h": -6.59, "percent_change_7d": -21.72 } }, "last_updated": 1567323185 }, 
        "2492": { "id": 2492, "name": "Elastos", "symbol": "ELA", "website_slug": "elastos", "rank": 119, "circulating_supply": 15967156.0, "total_supply": 34839919.0, "max_supply": null, "quotes": { "USD": { "price": 2.4718085899, "volume_24h": 1867380.47742698, "market_cap": 39467754.0, "percent_change_1h": 0.03, "percent_change_24h": 2.41, "percent_change_7d": -13.79 } }, "last_updated": 1567323186 }, 
        "3702": { "id": 3702, "name": "Beam", "symbol": "BEAM", "website_slug": "beam", "rank": 120, "circulating_supply": 33745200.0, "total_supply": 33745200.0, "max_supply": 262800000.0, "quotes": { "USD": { "price": 1.1491187994, "volume_24h": 61454222.0103003, "market_cap": 38777244.0, "percent_change_1h": 0.97, "percent_change_24h": -5.8, "percent_change_7d": -24.05 } }, "last_updated": 1567323191 }, 
        "3063": { "id": 3063, "name": "Vitae", "symbol": "VITAE", "website_slug": "vitae", "rank": 121, "circulating_supply": 17993832.0, "total_supply": 17993832.0, "max_supply": null, "quotes": { "USD": { "price": 2.1398208117, "volume_24h": 40879.1853082081, "market_cap": 38503576.0, "percent_change_1h": 0.02, "percent_change_24h": -2.95, "percent_change_7d": -13.84 } }, "last_updated": 1567323188 }, 
        "2606": { "id": 2606, "name": "Wanchain", "symbol": "WAN", "website_slug": "wanchain", "rank": 122, "circulating_supply": 106152493.0, "total_supply": 210000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.3546671278, "volume_24h": 15747121.4098247, "market_cap": 37648800.0, "percent_change_1h": -2.73, "percent_change_24h": -1.9, "percent_change_7d": -11.11 } }, "last_updated": 1567323187 }, 
        "4281": { "id": 4281, "name": "BHEX Token", "symbol": "BHT", "website_slug": "bhex-token", "rank": 123, "circulating_supply": 595312966.0, "total_supply": 2095136176.0, "max_supply": null, "quotes": { "USD": { "price": 0.0630820586, "volume_24h": 1492262.61151742, "market_cap": 37553567.0, "percent_change_1h": 1.49, "percent_change_24h": 8.71, "percent_change_7d": null } }, "last_updated": 1567323192 }, 
        "2593": { "id": 2593, "name": "Dragon Coins", "symbol": "DRG", "website_slug": "dragon-coins", "rank": 124, "circulating_supply": 348292412.0, "total_supply": 500000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.1070534221, "volume_24h": 90216.2938040653, "market_cap": 37285895.0, "percent_change_1h": -8.91, "percent_change_24h": -43.68, "percent_change_7d": 19.31 } }, "last_updated": 1567323187 }, 
        "3709": { "id": 3709, "name": "Grin", "symbol": "GRIN", "website_slug": "grin", "rank": 125, "circulating_supply": 19677540.0, "total_supply": 19677540.0, "max_supply": null, "quotes": { "USD": { "price": 1.8885137305, "volume_24h": 39186971.4182144, "market_cap": 37161304.0, "percent_change_1h": 0.12, "percent_change_24h": -3.94, "percent_change_7d": -22.01 } }, "last_updated": 1567323191 }, 
        "2694": { "id": 2694, "name": "Nexo", "symbol": "NEXO", "website_slug": "nexo", "rank": 126, "circulating_supply": 560000011.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0661302096, "volume_24h": 5314311.13121716, "market_cap": 37032918.0, "percent_change_1h": -1.74, "percent_change_24h": -2.11, "percent_change_7d": -9.51 } }, "last_updated": 1567323188 }, 
        "2298": { "id": 2298, "name": "Dynamic Trading Rights", "symbol": "DTR", "website_slug": "dynamic-trading-rights", "rank": 127, "circulating_supply": 1529018776.0, "total_supply": 2610393776.0, "max_supply": null, "quotes": { "USD": { "price": 0.0239252946, "volume_24h": 66148.0368718766, "market_cap": 36582225.0, "percent_change_1h": -0.03, "percent_change_24h": 1.02, "percent_change_7d": 7.65 } }, "last_updated": 1567323185 }, 
        "2433": { "id": 2433, "name": "IPChain", "symbol": "IPC", "website_slug": "ipchain", "rank": 128, "circulating_supply": 78330743.0, "total_supply": 92730744.0, "max_supply": null, "quotes": { "USD": { "price": 0.4611051004, "volume_24h": 2665444.92006243, "market_cap": 36118705.0, "percent_change_1h": -1.0, "percent_change_24h": -4.88, "percent_change_7d": 9.34 } }, "last_updated": 1567323186 }, 
        "2900": { "id": 2900, "name": "Project Pai", "symbol": "PAI", "website_slug": "project-pai", "rank": 129, "circulating_supply": 1451459830.0, "total_supply": 1618371000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0245381398, "volume_24h": 569320.467051212, "market_cap": 35616124.0, "percent_change_1h": 0.81, "percent_change_24h": -1.42, "percent_change_7d": -11.3 } }, "last_updated": 1567323188 }, 
        "2842": { "id": 2842, "name": "Bankera", "symbol": "BNK", "website_slug": "bankera", "rank": 130, "circulating_supply": 24588912108.0, "total_supply": 25000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0014451833, "volume_24h": 26304.5530393434, "market_cap": 35535486.0, "percent_change_1h": 0.2, "percent_change_24h": 0.96, "percent_change_7d": -5.44 } }, "last_updated": 1567323188 }, 
        "2989": { "id": 2989, "name": "STASIS EURO", "symbol": "EURS", "website_slug": "stasis-euro", "rank": 131, "circulating_supply": 31979207.0, "total_supply": 31979207.0, "max_supply": null, "quotes": { "USD": { "price": 1.1049310604, "volume_24h": 701934.542186305, "market_cap": 35334819.0, "percent_change_1h": 0.01, "percent_change_24h": 0.61, "percent_change_7d": 0.53 } }, "last_updated": 1567323188 }, 
        "2135": { "id": 2135, "name": "Revain", "symbol": "R", "website_slug": "revain", "rank": 132, "circulating_supply": 484450000.0, "total_supply": 484450000.0, "max_supply": 484450000.0, "quotes": { "USD": { "price": 0.0723976354, "volume_24h": 1643907.04691957, "market_cap": 35073034.0, "percent_change_1h": 0.31, "percent_change_24h": 0.26, "percent_change_7d": -5.94 } }, "last_updated": 1567323185 }, 
        "2137": { "id": 2137, "name": "Electroneum", "symbol": "ETN", "website_slug": "electroneum", "rank": 133, "circulating_supply": 9794855204.0, "total_supply": 9794855204.0, "max_supply": 21000000000.0, "quotes": { "USD": { "price": 0.0035553342, "volume_24h": 79794.9514854287, "market_cap": 34823983.0, "percent_change_1h": -0.21, "percent_change_24h": 0.2, "percent_change_7d": -6.17 } }, "last_updated": 1567323185 }, 
        "1698": { "id": 1698, "name": "Horizen", "symbol": "ZEN", "website_slug": "zencash", "rank": 134, "circulating_supply": 7230375.0, "total_supply": 7230375.0, "max_supply": 21000000.0, "quotes": { "USD": { "price": 4.6869369426, "volume_24h": 2906718.4637973, "market_cap": 33888312.0, "percent_change_1h": -0.17, "percent_change_24h": -2.17, "percent_change_7d": -10.75 } }, "last_updated": 1567323183 }, 
        "3415": { "id": 3415, "name": "Buggyra Coin Zero", "symbol": "BCZERO", "website_slug": "buggyra-coin-zero", "rank": 135, "circulating_supply": 2010775988.0, "total_supply": 10000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0167447407, "volume_24h": 38602.5738989154, "market_cap": 33669922.0, "percent_change_1h": -0.99, "percent_change_24h": 0.89, "percent_change_7d": -4.07 } }, "last_updated": 1567323190 }, 
        "1886": { "id": 1886, "name": "Dent", "symbol": "DENT", "website_slug": "dent", "rank": 136, "circulating_supply": 73625838994.0, "total_supply": 100000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0004545116, "volume_24h": 698113.092485708, "market_cap": 33463800.0, "percent_change_1h": -0.11, "percent_change_24h": -0.03, "percent_change_7d": 1.1 } }, "last_updated": 1567323184 }, 
        "1966": { "id": 1966, "name": "Decentraland", "symbol": "MANA", "website_slug": "decentraland", "rank": 137, "circulating_supply": 1050141509.0, "total_supply": 2644403343.0, "max_supply": null, "quotes": { "USD": { "price": 0.0317499829, "volume_24h": 6110391.48583497, "market_cap": 33341975.0, "percent_change_1h": -0.64, "percent_change_24h": -1.31, "percent_change_7d": -15.81 } }, "last_updated": 1567323184 }, 
        "118": { "id": 118, "name": "ReddCoin", "symbol": "RDD", "website_slug": "reddcoin", "rank": 138, "circulating_supply": 28808713174.0, "total_supply": 28808713174.0, "max_supply": null, "quotes": { "USD": { "price": 0.0011547763, "volume_24h": 19740.9086214216, "market_cap": 33267620.0, "percent_change_1h": -5.98, "percent_change_24h": -1.67, "percent_change_7d": -6.11 } }, "last_updated": 1567323181 }, 
        "1908": { "id": 1908, "name": "Nebulas", "symbol": "NAS", "website_slug": "nebulas-token", "rank": 139, "circulating_supply": 48627715.0, "total_supply": 104589244.0, "max_supply": null, "quotes": { "USD": { "price": 0.6706487877, "volume_24h": 5338662.08945584, "market_cap": 32612118.0, "percent_change_1h": 0.61, "percent_change_24h": -0.13, "percent_change_7d": -11.92 } }, "last_updated": 1567323184 }, 
        "2213": { "id": 2213, "name": "QASH", "symbol": "QASH", "website_slug": "qash", "rank": 140, "circulating_supply": 350000000.0, "total_supply": 1000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0929598626, "volume_24h": 204051.022457578, "market_cap": 32535952.0, "percent_change_1h": -0.03, "percent_change_24h": -3.48, "percent_change_7d": -5.61 } }, "last_updated": 1567323185 }, 
        "2631": { "id": 2631, "name": "ODEM", "symbol": "ODE", "website_slug": "odem", "rank": 141, "circulating_supply": 230043504.0, "total_supply": 268946131.0, "max_supply": null, "quotes": { "USD": { "price": 0.1412361142, "volume_24h": 599444.316426908, "market_cap": 32490451.0, "percent_change_1h": -0.04, "percent_change_24h": 0.19, "percent_change_7d": -9.32 } }, "last_updated": 1567323187 }, 
        "3871": { "id": 3871, "name": "Newton", "symbol": "NEW", "website_slug": "newton", "rank": 142, "circulating_supply": 11948333332.0, "total_supply": 100000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0027153603, "volume_24h": 2257761.94928429, "market_cap": 32444029.0, "percent_change_1h": 0.57, "percent_change_24h": -1.52, "percent_change_7d": -8.93 } }, "last_updated": 1567323191 }, 
        "4152": { "id": 4152, "name": "CryptoVerificationCoin", "symbol": "CVCC", "website_slug": "cryptoverificationcoin", "rank": 143, "circulating_supply": 582595.0, "total_supply": 36000000.0, "max_supply": null, "quotes": { "USD": { "price": 55.137881998, "volume_24h": 52924.531067601, "market_cap": 32123082.0, "percent_change_1h": 0.11, "percent_change_24h": 0.25, "percent_change_7d": -3.0 } }, "last_updated": 1567323192 }, 
        "3929": { "id": 3929, "name": "BQT", "symbol": "BQTX", "website_slug": "bqt", "rank": 144, "circulating_supply": 369723340.0, "total_supply": 800000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0867230017, "volume_24h": 2695420.06008302, "market_cap": 32063518.0, "percent_change_1h": -1.65, "percent_change_24h": -2.25, "percent_change_7d": -12.88 } }, "last_updated": 1567323191 }, 
        "3070": { "id": 3070, "name": "Litex", "symbol": "LXT", "website_slug": "litex", "rank": 145, "circulating_supply": 839999986.0, "total_supply": 2000000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.0380868212, "volume_24h": 2319111.70020193, "market_cap": 31992929.0, "percent_change_1h": -3.57, "percent_change_24h": 0.45, "percent_change_7d": -14.14 } }, "last_updated": 1567323188 }, 
        "2092": { "id": 2092, "name": "NULS", "symbol": "NULS", "website_slug": "nuls", "rank": 146, "circulating_supply": 73630194.0, "total_supply": 105698366.0, "max_supply": null, "quotes": { "USD": { "price": 0.4304611858, "volume_24h": 1315203.9764029, "market_cap": 31694941.0, "percent_change_1h": -0.2, "percent_change_24h": -1.88, "percent_change_7d": -20.53 } }, "last_updated": 1567323184 }, 
        "1229": { "id": 1229, "name": "DigixDAO", "symbol": "DGD", "website_slug": "digixdao", "rank": 147, "circulating_supply": 2000000.0, "total_supply": 2000000.0, "max_supply": null, "quotes": { "USD": { "price": 15.8132354198, "volume_24h": 374563.939906586, "market_cap": 31626471.0, "percent_change_1h": 0.31, "percent_change_24h": -1.19, "percent_change_7d": -18.79 } }, "last_updated": 1567323182 }, 
        "1087": { "id": 1087, "name": "Factom", "symbol": "FCT", "website_slug": "factom", "rank": 148, "circulating_supply": 9714918.0, "total_supply": 9714918.0, "max_supply": null, "quotes": { "USD": { "price": 3.2486786631, "volume_24h": 182069.373212452, "market_cap": 31560646.0, "percent_change_1h": 0.84, "percent_change_24h": -3.17, "percent_change_7d": -22.9 } }, "last_updated": 1567323181 }, 
        "2570": { "id": 2570, "name": "TomoChain", "symbol": "TOMO", "website_slug": "tomochain", "rank": 149, "circulating_supply": 64468050.0, "total_supply": 100000000.0, "max_supply": null, "quotes": { "USD": { "price": 0.4761307588, "volume_24h": 2581389.83901659, "market_cap": 30695222.0, "percent_change_1h": 0.44, "percent_change_24h": -1.91, "percent_change_7d": -24.01 } }, "last_updated": 1567323187 }, 
        "1934": { "id": 1934, "name": "Loopring", "symbol": "LRC", "website_slug": "loopring", "rank": 150, "circulating_supply": 900956509.0, "total_supply": 1375076040.0, "max_supply": null, "quotes": { "USD": { "price": 0.033720217, "volume_24h": 3285080.37541309, "market_cap": 30380449.0, "percent_change_1h": 0.56, "percent_change_24h": 2.01, "percent_change_7d": -14.08 } }, "last_updated": 1567323184 }
    }, 
    "metadata": { "timestamp": 1567322830, "warning": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", "num_cryptocurrencies": 2341, "error": null }
}
''';

    test('CoinMarketCap: 1 symbol (in first 50 cryptos), 200 - Response',
        () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .thenAnswer((_) async => http.Response(first50Coins, 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.coinmarketcap, <String>['BTC'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['BTC'].keys.length, 2);
      expect(quote['BTC']['price'], '9639.70');
      expect(quote['BTC']['currency'], 'USD');

      verify(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .called(1);
    });

    test('CoinMarketCap: 1 symbol (NOT in first 50 cryptos), 200 - Response',
        () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .thenAnswer((_) async => http.Response(first50Coins, 200));

      when(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .thenAnswer((_) async => http.Response(second50Coins, 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.coinmarketcap, <String>['BCD'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['BCD'].keys.length, 2);
      expect(quote['BCD']['price'], '0.58');
      expect(quote['BCD']['currency'], 'USD');

      verify(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .called(1);
      verify(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .called(1);
      verifyNever(client
          .get('https://api.coinmarketcap.com/v2/ticker/?start=101&limit=150'));
    });

    test('CoinMarketCap: 1 invalid symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .thenAnswer((_) async => http.Response(first50Coins, 200));

      when(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .thenAnswer((_) async => http.Response(second50Coins, 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.coinmarketcap, <String>['WWW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .called(1);
      verify(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .called(1);
      verifyNever(client
          .get('https://api.coinmarketcap.com/v2/ticker/?start=101&limit=150'));
    });

    test('CoinMarketCap: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .thenAnswer((_) async => http.Response(first50Coins, 200));

      when(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .thenAnswer((_) async => http.Response(second50Coins, 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.coinmarketcap, <String>['BTC', 'BCD', 'WWW'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 2);
      expect(quote['BTC'].keys.length, 2);
      expect(quote['BTC']['price'], '9639.70');
      expect(quote['BTC']['currency'], 'USD');
      expect(quote['BCD'].keys.length, 2);
      expect(quote['BCD']['price'], '0.58');
      expect(quote['BCD']['currency'], 'USD');

      verify(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .called(1);
      verify(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .called(1);
      verifyNever(client
          .get('https://api.coinmarketcap.com/v2/ticker/?start=101&limit=150'));
    });

    test('CoinMarketCap: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .thenAnswer((_) async => http.Response(
              '{ "attention": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", "data": { }, "metadata": { "timestamp": 1567322830, "warning": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", "num_cryptocurrencies": 2341, "error": null } }',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.coinmarketcap, <String>['BTC'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .called(1);

      verify(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .called(1);

      verifyNever(client
          .get('https://api.coinmarketcap.com/v2/ticker/?start=101&limit=150'));
    });

    test('CoinMarketCap: 404 - Response', () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .thenAnswer((_) async => http.Response(
              '{ "attention": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", "data": { }, "metadata": { "timestamp": 1567322830, "warning": "WARNING: This API is now deprecated and will be taken offline soon.  Please switch to the new CoinMarketCap API to avoid interruptions in service. (https://pro.coinmarketcap.com/migrate/)", "num_cryptocurrencies": 2341, "error": null } }',
              404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.coinmarketcap, <String>['BTC'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client
              .get('https://api.coinmarketcap.com/v2/ticker/?start=1&limit=50'))
          .called(1);

      verify(client.get(
              'https://api.coinmarketcap.com/v2/ticker/?start=51&limit=100'))
          .called(1);

      verifyNever(client
          .get('https://api.coinmarketcap.com/v2/ticker/?start=101&limit=150'));
    });
  });

  group('downloadRawQuote Test [Finance] - Coincap', () {
    test('Coincap: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin')).thenAnswer(
          (_) async => http.Response(
              '{"data":{"id":"bitcoin","rank":"1","symbol":"BTC","name":"Bitcoin","supply":"17909287.0000000000000000","maxSupply":"21000000.0000000000000000","marketCapUsd":"172415433962.2465790154727656","volumeUsd24Hr":"3144821860.9266363841492533","priceUsd":"9627.1523239449219288","changePercent24Hr":"0.2243120489992448","vwap24Hr":"9628.3630077795475554"},"timestamp":1567333621899}',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.coincap, <String>['bitcoin'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['bitcoin'].keys.length, 11);
      expect(quote['bitcoin']['symbol'], 'BTC');
      expect(quote['bitcoin']['priceUsd'], '9627.1523239449219288');

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
    });

    test('Coincap: 1 invalid symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/asdf')).thenAnswer(
          (_) async => http.Response(
              '{"error":"asdf not found","timestamp":1567334797490}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.coincap, <String>['asdf'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get('https://api.coincap.io/v2/assets/asdf')).called(1);
    });

    test('Coincap: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin')).thenAnswer(
          (_) async => http.Response(
              '{"data":{"id":"bitcoin","rank":"1","symbol":"BTC","name":"Bitcoin","supply":"17909287.0000000000000000","maxSupply":"21000000.0000000000000000","marketCapUsd":"172415433962.2465790154727656","volumeUsd24Hr":"3144821860.9266363841492533","priceUsd":"9627.1523239449219288","changePercent24Hr":"0.2243120489992448","vwap24Hr":"9628.3630077795475554"},"timestamp":1567333621899}',
              200));

      when(client.get('https://api.coincap.io/v2/assets/ethereum')).thenAnswer(
          (_) async => http.Response(
              '{"data":{"id":"ethereum","rank":"2","symbol":"ETH","name":"Ethereum","supply":"107560553.4365000000000000","maxSupply":null,"marketCapUsd":"18364136667.4690426157308646","volumeUsd24Hr":"1620040186.4141028288189939","priceUsd":"170.7330064856033725","changePercent24Hr":"1.0733475421440090","vwap24Hr":"170.9198731123523860"},"timestamp":1567334942673}',
              200));

      when(client.get('https://api.coincap.io/v2/assets/asdf')).thenAnswer(
          (_) async => http.Response(
              '{"error":"asdf not found","timestamp":1567334797490}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(QuoteProvider.coincap,
            <String>['bitcoin', 'adsf', 'ethereum'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 2);
      expect(quote['bitcoin'].keys.length, 11);
      expect(quote['bitcoin']['symbol'], 'BTC');
      expect(quote['bitcoin']['priceUsd'], '9627.1523239449219288');
      expect(quote['ethereum'].keys.length, 11);
      expect(quote['ethereum']['symbol'], 'ETH');
      expect(quote['ethereum']['priceUsd'], '170.7330064856033725');

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
      verify(client.get('https://api.coincap.io/v2/assets/ethereum')).called(1);
      verify(client.get('https://api.coincap.io/v2/assets/adsf')).called(1);
    });

    test('Coincap: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin'))
          .thenAnswer((_) async => http.Response('{"data":', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.coincap, <String>['bitcoin'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
    });

    test('Coincap: null, 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin'))
          .thenAnswer((_) async => http.Response('{"data":', 404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadRawQuote(
            QuoteProvider.coincap, <String>['bitcoin'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
    });
  });

  group('downloadQuotePrice Test [Finance] - Coincap', () {
    test('Coincap: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin')).thenAnswer(
          (_) async => http.Response(
              '{"data":{"id":"bitcoin","rank":"1","symbol":"BTC","name":"Bitcoin","supply":"17909287.0000000000000000","maxSupply":"21000000.0000000000000000","marketCapUsd":"172415433962.2465790154727656","volumeUsd24Hr":"3144821860.9266363841492533","priceUsd":"9627.1523239449219288","changePercent24Hr":"0.2243120489992448","vwap24Hr":"9628.3630077795475554"},"timestamp":1567333621899}',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.coincap, <String>['bitcoin'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['bitcoin'].keys.length, 2);
      expect(quote['bitcoin']['price'], '9627.15');
      expect(quote['bitcoin']['currency'], 'USD');

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
    });

    test('Coincap: 1 invalid symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/asdf')).thenAnswer(
          (_) async => http.Response(
              '{"error":"asdf not found","timestamp":1567334797490}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.coincap, <String>['asdf'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get('https://api.coincap.io/v2/assets/asdf')).called(1);
    });

    test('Coincap: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin')).thenAnswer(
          (_) async => http.Response(
              '{"data":{"id":"bitcoin","rank":"1","symbol":"BTC","name":"Bitcoin","supply":"17909287.0000000000000000","maxSupply":"21000000.0000000000000000","marketCapUsd":"172415433962.2465790154727656","volumeUsd24Hr":"3144821860.9266363841492533","priceUsd":"9627.1523239449219288","changePercent24Hr":"0.2243120489992448","vwap24Hr":"9628.3630077795475554"},"timestamp":1567333621899}',
              200));

      when(client.get('https://api.coincap.io/v2/assets/ethereum')).thenAnswer(
          (_) async => http.Response(
              '{"data":{"id":"ethereum","rank":"2","symbol":"ETH","name":"Ethereum","supply":"107560553.4365000000000000","maxSupply":null,"marketCapUsd":"18364136667.4690426157308646","volumeUsd24Hr":"1620040186.4141028288189939","priceUsd":"170.7330064856033725","changePercent24Hr":"1.0733475421440090","vwap24Hr":"170.9198731123523860"},"timestamp":1567334942673}',
              200));

      when(client.get('https://api.coincap.io/v2/assets/asdf')).thenAnswer(
          (_) async => http.Response(
              '{"error":"asdf not found","timestamp":1567334797490}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(QuoteProvider.coincap,
            <String>['bitcoin', 'adsf', 'ethereum'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 2);
      expect(quote['bitcoin'].keys.length, 2);
      expect(quote['bitcoin']['price'], '9627.15');
      expect(quote['bitcoin']['currency'], 'USD');
      expect(quote['ethereum'].keys.length, 2);
      expect(quote['ethereum']['price'], '170.73');
      expect(quote['ethereum']['currency'], 'USD');

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
      verify(client.get('https://api.coincap.io/v2/assets/ethereum')).called(1);
      verify(client.get('https://api.coincap.io/v2/assets/adsf')).called(1);
    });

    test('Coincap: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin'))
          .thenAnswer((_) async => http.Response('{"data":', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.coincap, <String>['bitcoin'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
    });

    test('Coincap: null, 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin'))
          .thenAnswer((_) async => http.Response('{"data":', 404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await Finance.downloadQuotePrice(
            QuoteProvider.coincap, <String>['bitcoin'], client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
    });
  });
}
