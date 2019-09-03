// Copyright 2019 Ismael Jiménez. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:finance/finance.dart';
import 'package:test/test.dart';

void main() {
  group('FV [Finance]', () {
    test('Rate = 0', () {
      expect(Finance.fv(rate: 0.0, nper: 20, pmt: -2000, pv: 0), 40000.0);
    });

    test('Payments due at the end of each period - Test 1', () {
      expect(Finance.fv(rate: 0.075, nper: 20, pmt: -2000, pv: 0),
          86609.362673042924);
    });

    test('Payments due at the end of each period - Test 2', () {
      expect(Finance.fv(rate: 0.05 / 12, nper: 10 * 12, pmt: -100, pv: -100),
          15692.928894335748);
    });

    test('Payments due at the beginning of each period', () {
      expect(Finance.fv(rate: 0.075, nper: 20, pmt: -2000, pv: 0, end: false),
          93105.06487352113);
    });
  });

  group('PMT [Finance]', () {
    test('Rate = 0', () {
      expect(Finance.pmt(rate: 0.00, nper: 5 * 12, pv: 15000), -250.0);
    });

    test('Payments due at the end of each period - Test 1', () {
      expect(Finance.pmt(rate: 0.08 / 12, nper: 5 * 12, pv: 15000),
          -304.14591432620773);
    });

    test('Payments due at the end of each period - Test 2', () {
      expect(Finance.pmt(rate: 0.075 / 12, nper: 12 * 15, pv: 200000),
          -1854.0247200054619);
    });

    test('Payments due at the beginning of each period', () {
      expect(Finance.pmt(rate: 0.08 / 12, nper: 5 * 12, pv: 15000, end: false),
          -302.131702973054);
    });
  });

  group('NPER [Finance]', () {
    test('Rate = 0', () {
      expect(Finance.nper(rate: 0.0, pmt: -2000, pv: 0, fv: 100000), 50);
    });

    test('Payments due at the end of each period - Test 1', () {
      expect(Finance.nper(rate: 0.075, pmt: -2000, pv: 0, fv: 100000),
          21.54494419732334);
    });

    test('Payments due at the end of each period - Test 2', () {
      expect(Finance.nper(rate: 0.07 / 12, pmt: -150, pv: 8000),
          64.07334877066185);
    });

    test('Payments due at the beginning of each period', () {
      expect(
          Finance.nper(rate: 0.075, pmt: -2000, pv: 0, fv: 100000, end: false),
          20.761564405189535);
    });
  });

  group('IPMT [Finance]', () {
    test('Rate = 0', () {
      expect(Finance.ipmt(rate: 0.0, per: 1, nper: 24, pv: 2000), 0);
    });

    test('Payments due at the end of each period - Test 1', () {
      expect(Finance.ipmt(rate: 0.1 / 12, per: 1, nper: 24, pv: 2000),
          -16.666666666666668);
    });

    test('Payments due at the end of each period - Test 2', () {
      expect(Finance.ipmt(rate: 0.0824 / 12, per: 1, nper: 1 * 12, pv: 2500),
          -17.166666666666668);
    });

    test('Payments due at the end of each period - Test 3', () {
      expect(Finance.ipmt(rate: 0.0824 / 12, per: 2, nper: 1 * 12, pv: 2500),
          -15.789337457350777);
    });

    test('Payments due at the beginning of each period - Test 1', () {
      expect(
          Finance.ipmt(rate: 0.1 / 12, per: 1, nper: 24, pv: 2000, end: false),
          0);
    });

    test('Payments due at the beginning of each period - Test 2', () {
      expect(
          Finance.ipmt(
              rate: 0.0824 / 12, per: 2, nper: 1 * 12, pv: 2500, end: false),
          -15.681656747683354);
    });
  });

  group('PPMT [Finance]', () {
    test('Rate = 0', () {
      expect(Finance.ppmt(rate: 0.0, per: 1, nper: 24, pv: 2000),
          -83.33333333333333);
    });

    test('Payments due at the end of each period - Test 1', () {
      expect(Finance.ppmt(rate: 0.1 / 12, per: 1, nper: 60, pv: 55000),
          -710.254125786425);
    });

    test('Payments due at the end of each period - Test 2', () {
      expect(Finance.ppmt(rate: 0.23 / 12, per: 1, nper: 60, pv: 10000000000),
          -90238044.232277036);
    });

    test('Payments due at the end of each period - Test 2', () {
      expect(Finance.ppmt(rate: 0.0824 / 12, per: 1, nper: 1 * 12, pv: 2500),
          -200.58192368678277);
    });

    test('Payments due at the end of each period - Test 3', () {
      expect(Finance.ppmt(rate: 0.0824 / 12, per: 2, nper: 1 * 12, pv: 2500),
          -201.95925289609866);
    });

    test('Payments due at the beginning of each period - Test 1', () {
      expect(
          Finance.ppmt(rate: 0.1 / 12, per: 1, nper: 24, pv: 2000, end: false),
          -91.52712661986774);
    });

    test('Payments due at the beginning of each period - Test 2', () {
      expect(
          Finance.ppmt(
              rate: 0.0824 / 12, per: 2, nper: 1 * 12, pv: 2500, end: false),
          -200.58192368678274);
    });
  });

  group('PV [Finance]', () {
    test('Rate = 0', () {
      expect(Finance.pv(rate: 0, nper: 20, pmt: 12000, fv: 0, end: false),
          -240000.0);
    });

    test('Payments due at the end of each period - Test 1', () {
      expect(Finance.pv(rate: 0.07, nper: 20, pmt: 12000, fv: 0),
          -127128.17094619398);
    });

    test('Payments due at the end of each period - Test 2', () {
      expect(Finance.pv(rate: 0.05 / 12, nper: 10 * 12, pmt: -100, fv: 15692.93),
          -100.00067131625819);
    });

    test('Payments due at the beginning of each period', () {
      expect(Finance.pv(rate: 0.07, nper: 20, pmt: 12000, fv: 0, end: false),
          -136027.14291242755);
    });
  });
}
