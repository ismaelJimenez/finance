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
  static num fv(
      {@required num rate,
      @required num nper,
      @required num pmt,
      @required num pv,
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
  static num pmt(
      {@required num rate,
      @required num nper,
      @required num pv,
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
  static num nper(
      {@required num rate,
      @required num pmt,
      @required num pv,
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
      {@required num rate,
        @required num per,
        @required num nper,
        @required num pv,
        num fv = 0,
        bool end = true}) {
    final num totalPmt = pmt(rate: rate, nper: nper, pv: pv, fv: fv, end: end);
    num ipmt = _rbl(rate: rate, per: per, pmt: totalPmt, pv: pv, end: end)*rate;
    ipmt = end ? ipmt : ipmt/(1 + rate);
    ipmt = (!end && (per == 1)) ? 0 : ipmt;
    return ipmt;
  }

  //  This function is here to simply have a different name for the 'fv'
  //  function to not interfere with the 'fv' keyword argument within the 'ipmt'
  //  function.  It is the 'remaining balance on loan'.
  static num _rbl(
      {@required num rate,
        @required num per,
        @required num pmt,
        @required num pv,
        bool end = true}) {
    return fv(rate: rate, nper: per-1, pmt: pmt, pv: pv, end: end);
  }
}

