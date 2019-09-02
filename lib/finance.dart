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
    final num fact =
    (rate == 0) ? nper : ((1 + maskedRate * when) * (temp - 1) / maskedRate);
    return -(fv + pv*temp) / fact;
  }
}