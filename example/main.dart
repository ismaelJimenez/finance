import 'package:finance/finance.dart';

void main(List<String> arguments) {
  // What is the future value after 30 years of saving $1000 now, with
  // an additional monthly savings of $100.  Assume the interest rate is
  // 7% (annually) compounded monthly?
  print(Finance.fv(rate: 0.07 / 12, nper: 30 * 12, pmt: -100, pv: -1000));

  // What is the monthly payment needed to pay off a $100,000 loan in 10
  // years at an annual interest rate of 2.5%?
  print(Finance.pmt(rate: 0.025 / 12, nper: 10 * 12, pv: 100000));
}
