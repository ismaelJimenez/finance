The fundamental package for financial computing with Dart.

[![pub package](https://img.shields.io/pub/v/finance.svg)](https://pub.dev/packages/finance)
[![Build Status](https://travis-ci.org/ismaelJimenez/finance.svg?branch=master)](https://travis-ci.org/ismaelJimenez/finance)

This package provides a set of high-level functions and classes that make it easy to compute financial ratios, patterned after spreadsheet computations. It's platform-independent, supports iOS and Android.

# Using

The easiest way to use this library is via the top-level functions. They allow you to make financial calculations with minimal hassle:

## Future Value calculation

What is the future value after 30 years of saving $1000 now, with an additional monthly savings of $100.  Assume the interest rate is 7% (annually) compounded monthly?

```dart
  print(Finance.fv(rate: 0.07 / 12, nper: 30 * 12, pmt: -100, pv: -1000));
```

Thus, saving $1000 today and then $100 a month at 7% annual interest leads to $130,113.59 available to spend in 30 years from now.

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

## Principal and Interest payment calculation

What is the amortization schedule for a 1 year loan of $5000 at 10% interest per year compounded monthly? 
And the total interest payments?

```dart
  final Iterable<Map<String, num>> payments =
      List<int>.generate(12, (int index) => index + 1).map((int per) =>
          <String, num>{
            'per': per,
            'pmt': Finance.pmt(rate: 0.1 / 12, nper: 1 * 12, pv: 5000),
            'ppmt':
                Finance.ppmt(rate: 0.1 / 12, per: per, nper: 1 * 12, pv: 5000),
            'ipmt':
                Finance.ipmt(rate: 0.1 / 12, per: per, nper: 1 * 12, pv: 5000),
          });

  payments.forEach(print);

  final num interestPaid =
      payments.fold(0, (num p, Map<String, num> c) => p + c['ipmt']);
  print(interestPaid);
 ```
 
Thus, the total interest paid are close to $275.

## Present Value calculation

What is the present value (e.g., the initial investment) of an investment that needs to total $20,000 
after 10 years of saving $100 every month?  Assume the interest rate is 7% (annually) compounded monthly.

```dart
  print(Finance.pv(rate: 0.05 / 12, nper: 10 * 12, pmt: -100, fv: 15692.93));
```

So, to end up with $20,000 in 10 years saving $100 a month at 7% annual interest, one's initial deposit 
should be $1,339.28.

## Interest rate calculation

What is the interest rate for a $8,000 loan if the loan term is 5 years and and payments are $152.50 monthly?

```dart
  print(Finance.rate(nper: 60, pmt: -152.5, pv: 8000, fv: 0));
```

The calculated interest rate is 0.45% monthly, or 5.42% annually.

## Net present value calculation

What is the Net Present Value of an investment that requires $15000 deposit now and then makes the following 
withdrawals at regular (fixed) intervals:  1500, 2500, 3500, 4500, 6000?.  Assuming the ending value is 0
and a discount rate of 5%.

```dart
  print(Finance.npv(rate: 0.05, values: <num>[-15000, 1500, 2500, 3500, 4500, 6000]));
```

So, this investment is worth $122.894 today.

## Internal Rate of Return calculation

What is the Internal Rate of return of an investment that requires $15000 deposit now and then makes the 
following withdrawals at regular (fixed) intervals:  1500, 2500, 3500, 4500, 6000?.  Assuming the ending 
value is 0.

```dart
  print(Finance.irr(rate: 0.05, values: <num>[-15000, 1500, 2500, 3500, 4500, 6000]));
```

So, the IRR of this investment is 5.24%.
