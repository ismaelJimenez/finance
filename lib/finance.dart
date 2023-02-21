// Copyright 2019 Ismael Jiménez. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library finance;

import 'dart:math';
import 'package:meta/meta.dart';

class Finance {
  /// Returns the value at the end of the `nper` periods.
  ///
  /// The `rate` argument specifies the rate of interest as decimal (not per cent) per period.
  ///
  /// The `nper` argument specifies the number of compounding periods.
  ///
  ///  The `pmt` argument specifies the payment. By convention, the negative sign represents
  ///  cash flow out (i.e. money not available today).
  ///
  ///  The `pv` argument specifies the present value. By convention, the negative sign represents
  ///  cash flow out (i.e. money not available today).
  ///
  /// If specified, the `end` argument specifies when payments are due, at the end or beginning
  /// of each period. Per default, end of each period is selected.
  ///
  ///  Notes
  ///  -----
  ///    The future value is computed by solving the equation::
  ///     fv +
  ///     pv*(1+rate)**nper +
  ///     pmt*(1 + rate*end)/rate*((1 + rate)**nper - 1) == 0
  ///    or, when ``rate == 0``::
  ///     fv + pv + pmt * nper == 0
  ///
  ///  References
  ///  ----------
  ///     [WRW] Wheeler, D. A., E. Rathke, and R. Weir (Eds.) (2009, May).
  ///     Open Document Format for Office Applications (OpenDocument)v1.2,
  ///     Part 2: Recalculated Formula (OpenFormula) Format - Annotated Version,
  ///     Pre-Draft 12. Organization for the Advancement of Structured Information
  ///     Standards (OASIS). Billerica, MA, USA. [ODT Document].
  ///     Available:
  ///     http://www.oasis-open.org/committees/documents.php?wg_abbrev=office-formula
  ///     OpenDocument-formula-20090508.odt
  static num fv(
      {required num rate,
      required num nper,
      required num pmt,
      required num pv,
      bool end = true}) {
    final int when = end ? 0 : 1;
    final num temp = pow(1 + rate, nper);
    final num fact =
        (rate == 0) ? nper : ((1 + rate * when) * (temp - 1) / rate);
    return -(pv * temp + pmt * fact);
  }

  /// Returns the payment against loan principal plus interest.  By convention, the negative sign represents
  /// cash flow out.
  ///
  /// The `rate` argument specifies the rate of interest as decimal (not per cent) per period.
  ///
  /// The `nper` argument specifies the number of compounding periods.
  ///
  ///  The `pv` argument specifies the present value. By convention, the negative sign represents
  ///  cash flow out.
  ///
  /// If specified, the `fv` argument specifies the future value. (default=0). By convention, the negative
  /// sign represent cash flow out.
  ///
  /// If specified, the `end` argument specifies when payments are due, at the end or beginning
  /// of each period. (default=true).
  ///
  ///  Notes
  ///  -----
  ///    The payment is computed by solving the equation::
  ///     fv +
  ///     pv*(1 + rate)**nper +
  ///     pmt*(1 + rate*end)/rate*((1 + rate)**nper - 1) == 0
  ///    or, when ``rate == 0``::
  ///      fv + pv + pmt * nper == 0
  ///    for ``pmt``.
  ///    Note that computing a monthly mortgage payment is only
  ///    one use for this function.  For example, pmt returns the
  ///    periodic deposit one must make to achieve a specified
  ///    future balance given an initial deposit, a fixed,
  ///    periodically compounded interest rate, and the total
  ///    number of periods.
  ///
  ///  References
  ///  ----------
  ///     [WRW] Wheeler, D. A., E. Rathke, and R. Weir (Eds.) (2009, May).
  ///     Open Document Format for Office Applications (OpenDocument)v1.2,
  ///     Part 2: Recalculated Formula (OpenFormula) Format - Annotated Version,
  ///     Pre-Draft 12. Organization for the Advancement of Structured Information
  ///     Standards (OASIS). Billerica, MA, USA. [ODT Document].
  ///     Available:
  ///     http://www.oasis-open.org/committees/documents.php
  ///     ?wg_abbrev=office-formulaOpenDocument-formula-20090508.odt
  static num pmt(
      {required num rate,
      required num nper,
      required num pv,
      num fv = 0,
      bool end = true}) {
    final int when = end ? 0 : 1;
    final num temp = pow(1 + rate, nper);
    final num maskedRate = (rate == 0) ? 1 : rate;
    final num fact = (rate == 0)
        ? nper
        : ((1 + maskedRate * when) * (temp - 1) / maskedRate);
    return -(fv + pv * temp) / fact;
  }

  /// Returns the number of periodic payments.
  ///
  /// The `rate` argument specifies the rate of interest as decimal (not per cent) per period.
  ///
  ///  The `pmt` argument specifies the payment. By convention, the negative sign represents
  ///  cash flow out (i.e. money not available today).
  ///
  ///  The `pv` argument specifies the present value. By convention, the negative sign represents
  ///  cash flow out.
  ///
  /// If specified, the `fv` argument specifies the future value. (default=0). By convention, the negative
  /// sign represent cash flow out.
  ///
  /// If specified, the `end` argument specifies when payments are due, at the end or beginning
  /// of each period. (default=true).
  ///
  ///  Notes
  ///  -----
  ///    The number of periods ``nper`` is computed by solving the equation::
  ///     fv + pv*(1+rate)**nper + pmt*(1+rate*(end))/rate*((1+rate)**nper-1) = 0
  ///    but if ``rate = 0`` then::
  ///     fv + pv + pmt*nper = 0
  static num nper(
      {required num rate,
      required num pmt,
      required num pv,
      num fv = 0,
      bool end = true}) {
    final int when = end ? 0 : 1;

    try {
      final num A = -(fv + pv) / pmt;
      final num z = pmt * (1 + rate * when) / rate;
      final num B = log((-fv + z) / (pv + z)) / log(1 + rate);
      return (rate == 0) ? A : B;
    } catch (e) {
      return (-fv + pv) / pmt;
    }
  }

  /// Returns the interest portion of a payment.
  ///
  /// The `rate` argument specifies the rate of interest as decimal (not per cent) per period.
  ///
  ///  The `per` argument specifies the interest paid against the loan changes during the life or the loan.. By convention, the negative sign represents
  ///  cash flow out (i.e. money not available today).
  ///
  /// The `nper` argument specifies the number of compounding periods.
  ///
  ///  The `pv` argument specifies the present value. By convention, the negative sign represents
  ///  cash flow out.
  ///
  /// If specified, the `fv` argument specifies the future value. (default=0). By convention, the negative
  /// sign represent cash flow out.
  ///
  /// If specified, the `end` argument specifies when payments are due, at the end or beginning
  /// of each period. (default=true).
  ///
  static num ipmt(
      {required num rate,
      required num per,
      required num nper,
      required num pv,
      num fv = 0,
      bool end = true}) {
    final num totalPmt = pmt(rate: rate, nper: nper, pv: pv, fv: fv, end: end);
    num ipmt =
        _rbl(rate: rate, per: per, pmt: totalPmt, pv: pv, end: end) * rate;
    ipmt = end ? ipmt : ipmt / (1 + rate);
    ipmt = (!end && (per == 1)) ? 0 : ipmt;
    return ipmt;
  }

  //  This function is here to simply have a different name for the 'fv'
  //  function to not interfere with the 'fv' keyword argument within the 'ipmt'
  //  function.  It is the 'remaining balance on loan'.
  static num _rbl(
      {required num rate,
      required num per,
      required num pmt,
      required num pv,
      bool end = true}) {
    return fv(rate: rate, nper: per - 1, pmt: pmt, pv: pv, end: end);
  }

  /// Returns the payment against loan principal.
  ///
  /// The `rate` argument specifies the rate of interest as decimal (not per cent) per period.
  ///
  ///  The `per` argument specifies the interest paid against the loan changes during the life or the loan.. By convention, the negative sign represents
  ///  cash flow out (i.e. money not available today).
  ///
  /// The `nper` argument specifies the number of compounding periods.
  ///
  ///  The `pv` argument specifies the present value. By convention, the negative sign represents
  ///  cash flow out.
  ///
  /// If specified, the `fv` argument specifies the future value. (default=0). By convention, the negative
  /// sign represent cash flow out.
  ///
  /// If specified, the `end` argument specifies when payments are due, at the end or beginning
  /// of each period. (default=true).
  ///
  static num ppmt(
      {required num rate,
      required num per,
      required num nper,
      required num pv,
      num fv = 0,
      bool end = true}) {
    final num total = pmt(rate: rate, nper: nper, pv: pv, fv: fv, end: end);
    return total -
        ipmt(rate: rate, per: per, nper: nper, pv: pv, fv: fv, end: end);
  }

  /// Returns the present value of a series of payments or investments.
  ///
  /// The `rate` argument specifies the rate of interest as decimal (not per cent) per period.
  ///
  /// The `nper` argument specifies the number of compounding periods.
  ///
  ///  The `pmt` argument specifies the payment. By convention, the negative sign represents
  ///  cash flow out (i.e. money not available today).
  ///
  ///  The `fv` argument specifies the future value. By convention, the negative sign represents
  ///  cash flow out (i.e. money not available today).
  ///
  /// If specified, the `end` argument specifies when payments are due, at the end or beginning
  /// of each period. Per default, end of each period is selected.
  ///
  ///  Notes
  ///  -----
  ///    The present value is computed by solving the equation::
  ///     fv +
  ///     pv*(1 + rate)**nper +
  ///     pmt*(1 + rate*end)/rate*((1 + rate)**nper - 1) = 0
  ///    or, when ``rate = 0``::
  ///     fv + pv + pmt * nper = 0
  ///    for `pv`, which is then returned.
  ///
  ///  References
  ///  ----------
  ///    [WRW] Wheeler, D. A., E. Rathke, and R. Weir (Eds.) (2009, May).
  ///    Open Document Format for Office Applications (OpenDocument)v1.2,
  ///    Part 2: Recalculated Formula (OpenFormula) Format - Annotated Version,
  ///    Pre-Draft 12. Organization for the Advancement of Structured Information
  ///    Standards (OASIS). Billerica, MA, USA. [ODT Document].
  ///    Available:
  ///    http://www.oasis-open.org/committees/documents.php?wg_abbrev=office-formula
  ///    OpenDocument-formula-20090508.odt
  static num pv(
      {required num rate,
      required num nper,
      required num pmt,
      required num fv,
      bool end = true}) {
    final int when = end ? 0 : 1;
    final num temp = pow(1 + rate, nper);
    final num fact =
        (rate == 0) ? nper : ((1 + rate * when) * (temp - 1) / rate);
    return -(fv + pmt * fact) / temp;
  }

  // Computed with Sage
  //  (y + (r + 1)^n*x + p*((r + 1)^n - 1)*(r*w + 1)/r)/(n*(r + 1)^(n - 1)*x -
  //  p*((r + 1)^n - 1)*(r*w + 1)/r^2 + n*p*(r + 1)^(n - 1)*(r*w + 1)/r +
  //  p*((r + 1)^n - 1)*w/r)
  static num _g_div_gp(num r, num n, num p, num x, num y, num w) {
    final num t1 = pow(r + 1, n);
    final num t2 = pow(r + 1, n - 1);
    return (y + t1 * x + p * (t1 - 1) * (r * w + 1) / r) /
        (n * t2 * x -
            p * (t1 - 1) * (r * w + 1) / pow(r, 2) +
            n * p * t2 * (r * w + 1) / r +
            p * (t1 - 1) * w / r);
  }

  /// Returns the rate of interest per period.
  ///
  /// The `nper` argument specifies the number of compounding periods.
  ///
  ///  The `pmt` argument specifies the payment. By convention, the negative sign represents
  ///  cash flow out (i.e. money not available today).
  ///
  ///  The `pv` argument specifies the present value. By convention, the negative sign represents
  ///  cash flow out.
  ///
  ///  The `fv` argument specifies the future value. By convention, the negative sign represents
  ///  cash flow out (i.e. money not available today).
  ///
  /// If specified, the `end` argument specifies when payments are due, at the end or beginning
  /// of each period. Per default, end of each period is selected.
  ///
  /// If specified, the `guess` argument specifies the starting guess for solving the rate of interest.
  ///
  /// If specified, the `tol` argument specifies the required tolerance for the solution.
  ///
  /// If specified, the `maxIter` argument specifies the maximum iterations in finding the solution.
  ///
  ///  Notes
  ///  -----
  ///    The rate of interest is computed by iteratively solving the
  ///    (non-linear) equation::
  ///     fv + pv*(1+rate)**nper + pmt*(1+rate*when)/rate * ((1+rate)**nper - 1) = 0
  ///    for ``rate``.
  ///  -----
  ///    Use Newton's iteration until the change is less than 1e-6
  ///    for all values or a maximum of 100 iterations is reached.
  ///    Newton's rule is
  ///    r_{n+1} = r_{n} - g(r_n)/g'(r_n)
  ///     where
  ///    g(r) is the formula
  ///    g'(r) is the derivative with respect to r.
  ///
  ///  References
  ///  ----------
  ///    Wheeler, D. A., E. Rathke, and R. Weir (Eds.) (2009, May). Open Document
  ///    Format for Office Applications (OpenDocument)v1.2, Part 2: Recalculated
  ///    Formula (OpenFormula) Format - Annotated Version, Pre-Draft 12.
  ///    Organization for the Advancement of Structured Information Standards
  ///    (OASIS). Billerica, MA, USA. [ODT Document]. Available:
  ///    http://www.oasis-open.org/committees/documents.php?wg_abbrev=office-formula
  ///    OpenDocument-formula-20090508.odt
  static num rate(
      {required num nper,
      required num pmt,
      required num pv,
      required num fv,
      bool end = true,
      num guess = 0.1,
      num tol = 1e-6,
      num maxIter = 100}) {
    final int when = end ? 0 : 1;

    num rn = guess;
    num iterator = 0;
    bool close = false;
    while ((iterator < maxIter) && !close) {
      final num rnp1 = rn - _g_div_gp(rn, nper, pmt, pv, fv, when);
      final num diff = (rnp1 - rn).abs();
      close = diff < tol;
      iterator += 1;
      rn = rnp1;
    }

    return rn;
  }

  /// Returns the NPV (Net Present Value) of a cash flow series.
  ///
  /// The `rate` argument specifies the discount rate.
  ///
  /// The `values` argument specifies the values of the time series of cash flows.
  /// The (fixed) time interval between cash flow "events" must be the same as that for
  /// which `rate` is given (i.e., if `rate` is per year, then precisely a year is understood
  /// to elapse between each cash flow event).  By convention, investments or "deposits" are
  /// negative, income or "withdrawals" are positive; `values` must begin with the initial
  /// investment, thus `values[0]` will typically be negative.
  ///
  /// Notes
  /// -----
  ///    Returns the result of: [G]_
  ///    .. math :: \\sum_{t=0}^{M-1}{\\frac{values_t}{(1+rate)^{t}}}
  ///
  /// References
  /// ----------
  ///    .. [G] L. J. Gitman, "Principles of Managerial Finance, Brief," 3rd ed.,
  ///       Addison-Wesley, 2003, pg. 346.
  static num npv({required num rate, required List<num> values}) {
    return List<int>.generate(values.length, (int index) => index)
        .map((int index) => values[index] / pow(1 + rate, index))
        .fold(0, (num p, num c) => p + c);
  }

  static num _npvPrime({required num rate, required List<num> values}) {
    return List<int>.generate(values.length, (int index) => index)
        .map((int index) => -index * values[index] / pow(1 + rate, index + 1))
        .fold(0, (num p, num c) => p + c);
  }

  static num _npv_div_npvPrime(num rate, List<num> values) {
    final num t1 = npv(rate: rate, values: values);
    final num t2 = _npvPrime(rate: rate, values: values);
    return t1 / t2;
  }

  /// Returns the Internal Rate of Return for periodic input values.
  ///
  /// The `values` argument specifies the values of the time series of cash flows.
  /// By convention, investments or "deposits" are negative, income or "withdrawals"
  /// are positive; `values` must begin with the initial investment, thus `values[0]`
  /// will typically be negative.
  ///
  /// If specified, the `guess` argument specifies the starting guess for solving the rate of interest.
  ///
  /// If specified, the `tol` argument specifies the required tolerance for the solution.
  ///
  /// If specified, the `maxIter` argument specifies the maximum iterations in finding the solution.
  ///
  /// Notes
  /// -----
  ///    The internal rate of interest is computed by iteratively solving the
  ///    (non-linear) equation::
  ///     npv(rate, values) = 0
  ///    for ``rate``.
  ///  -----
  ///    Use Newton's iteration until the change is less than 1e-6
  ///    for all values or a maximum of 100 iterations is reached.
  ///    Newton's rule is
  ///    r_{n+1} = r_{n} - g(r_n)/g'(r_n)
  ///     where
  ///    g(r) is the formula
  ///    g'(r) is the derivative with respect to r.

  static num irr(
      {required List<num> values,
      num guess = 0.1,
      num tol = 1e-6,
      num maxIter = 100}) {
    num rn = guess;
    num iterator = 0;
    bool close = false;
    while ((iterator < maxIter) && !close) {
      final num rnp1 = rn - _npv_div_npvPrime(rn, values);
      final num diff = (rnp1 - rn).abs();
      close = diff < tol;
      iterator += 1;
      rn = rnp1;
    }

    return rn;
  }
}
