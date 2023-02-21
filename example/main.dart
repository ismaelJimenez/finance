import 'package:finance/finance.dart';

void main(List<String> arguments) {
  // What is the future value after 30 years of saving $1000 now, with
  // an additional monthly savings of $100.  Assume the interest rate is
  // 7% (annually) compounded monthly?
  print(Finance.fv(rate: 0.07 / 12, nper: 30 * 12, pmt: -100, pv: -1000));

  // What is the monthly payment needed to pay off a $100,000 loan in 10
  // years at an annual interest rate of 2.5%?
  print(Finance.pmt(rate: 0.025 / 12, nper: 10 * 12, pv: 100000));

  // If you only had $500/month to pay towards the loan, how long would it take
  // to pay-off a loan of $10,000 at 3% annual interest?
  print(Finance.nper(rate: 0.03 / 12, pmt: -500, pv: 10000));

  // What is the amortization schedule for a 1 year loan of $5000 at 10%
  // interest per year compounded monthly?
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
      payments.fold(0, (num p, Map<String, num> c) => p + c['ipmt']!);
  print(interestPaid);

  //  What is the present value (e.g., the initial investment) of an investment that
  //  needs to total $20000 after 10 years of saving $100 every month?  Assume the
  //  interest rate is 7% (annually) compounded monthly.
  print(Finance.pv(rate: 0.07 / 12, nper: 10 * 12, pmt: -100, fv: 20000));

  //  What is the interest rate for a $8,000 loan if the loan term is 5 years and
  //  and payments are $152.50 monthly?
  print(Finance.rate(nper: 60, pmt: -152.5, pv: 8000, fv: 0));

  //  What is the Internal Rate of return of an investment that requires $15000 deposit now
  //  and then makes the following withdrawals at regular (fixed)
  //  intervals:  1500, 2500, 3500, 4500, 6000?.  Assuming the ending value is 0.
  print(Finance.irr(values: <num>[-15000, 1500, 2500, 3500, 4500, 6000]));

  //  What is the Net Present Value of an investment that requires $15000 deposit now
  //  and then makes the following withdrawals at regular (fixed)
  //  intervals:  1500, 2500, 3500, 4500, 6000?.  Assuming the ending value is 0
  //  and a discount rate of 5%.

  print(Finance.npv(
      rate: 0.05, values: <num>[-15000, 1500, 2500, 3500, 4500, 6000]));
}
