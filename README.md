The fundamental package for financial computing with Dart.

[![pub package](https://img.shields.io/pub/v/finance.svg)](https://pub.dev/packages/finance)
[![Build Status](https://travis-ci.org/ismaelJimenez/finance.svg?branch=master)](https://travis-ci.org/ismaelJimenez/finance)

This package provides a set of high-level functions and classes that make it easy to compute financial ratios. It's platform-independent, supports iOS and Android.
# Using

The easiest way to use this library is via the top-level functions. They allow you to make financial calculations with minimal hassle:

## Future Value calculation

What is the future value after 30 years of saving $1000 now, with an additional monthly savings of $100.  Assume the interest rate is 7% (annually) compounded monthly?

```dart
  print(Finance.fv(rate: 0.07 / 12, nper: 30 * 12, pmt: -100, pv: -1000));
```

Thus, saving $1000 today and then $100 a month at 7% annual interest leads to $130,113.59 available to spend in 30 years.

## Payments calculation

What is the monthly payment needed to pay off a $100,000 loan in 10 years at an annual interest rate of 2.5%?

```dart
  print(Finance.pmt(rate: 0.025 / 12, nper: 10 * 12, pv: 100000));
```  

Thus, in order to pay-off (i.e., have a future-value of 0) the $100,000 obtained today, a monthly payment of $942.69 would be required.  Note that this example illustrates usage of future value having a default value of 0.

## Number of period calculation

If we only had $500/month to pay towards the loan, how long would it take to pay-off a loan of $100,000 at 3% annual interest?
 
 ```dart
   print(Finance.nper(rate: 0.03 / 12, pmt: -500, pv: 10000));
 ```  
 
So, over 20 months would be required to pay off the loan.