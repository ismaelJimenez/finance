A Dart plugin for retrieving financial quote prices.

[![pub package](https://img.shields.io/pub/v/finance.svg)](https://pub.dev/packages/finance)
[![Build Status](https://travis-ci.org/ismaelJimenez/finance.svg?branch=master)](https://travis-ci.org/ismaelJimenez/finance)

This package contains a set of high-level functions and classes that make it easy to retrieve stocks (Amazon, Google, ...), commodities (Gold, Oil, ...) and crypto-currencies (Bitcoin, Ethereum, ...) quote prices. It's platform-independent.

# Using

The easiest way to use this library is via the top-level functions. They allow you to make quote price requests with minimal hassle:
```dart
  final Map<String, Map<String, dynamic>> quotePrice = await Finance.downloadQuotePrice(
      QuoteProvider.yahoo, <String>['KO']);

  print('Number of quotes retrieved: ${quotePrice.keys.length}.');
  print('Number of attributes retrieved for KO: ${quotePrice['KO'].keys.length}.');
  print('Current market price for KO: ${quotePrice['KO']['price']}.');
```
If you're making multiple quote requests to the same server, you can request all of them in a single function call:
```dart
  final Map<String, Map<String, String>> quotePrice = await Finance.downloadQuotePrice(
      QuoteProvider.yahoo, <String>['KO', 'GOOG']);

  print('Number of quotes retrieved: ${quotePrice.keys.length}.');
  print('Number of attributes retrieved for KO: ${quotePrice['KO'].keys.length}.');
  print('Current market price for KO: ${quotePrice['KO']['price']}.');
  print('Number of attributes retrieved for GOOG : ${quotePrice['GOOG'].keys.length}.');
  print('Current market price for KO: ${quotePrice['GOOG']['price']}.');
```  
  If you want all available quote data from the selected provider, you can request it with the function call:
```dart  
  final Map<String, Map<String, dynamic>> cryptoQuoteRaw = await Finance.downloadRawQuote(
      QuoteProvider.coincap, <String>['bitcoin', 'ethereum']);

  print('Number of quotes retrieved: ${cryptoQuoteRaw.keys.length}.');
  print('Number of attributes retrieved for bitcoin : ${cryptoQuoteRaw['bitcoin'].keys.length}.');
  print('Current market price for bitcoin: ${cryptoQuoteRaw['bitcoin']['priceUsd']}.');
  print('Number of attributes retrieved for ethereum: ${cryptoQuoteRaw['ethereum'].keys.length}.');
  print('Current market price for ethereum: ${cryptoQuoteRaw['ethereum']['priceUsd']}.');
  ```
  
  # TERMS & CONDITIONS

Quote information fetched through this module is bound by the quote providers terms and conditions.
