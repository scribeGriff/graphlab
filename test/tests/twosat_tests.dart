// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

part of graphlabtests;

/**
 * Unit testing of two sat algorithm for the graphlab library.
 */

void twosatTests() {
  logMessage('Performing two sat algorithm tests.');

  // Unsatisfiable.  Same as 2sat_55unsat.txt in library ConvoHio.
  List<List> satfile1 = [[1, 1],
                        [-1, 2],
                        [-1, 3],
                        [-2, -3],
                        [4, 5]];

  // Satisfiable.  Same as 2sat_44sat.txt.
  List<List> satfile2 = [[1, 2],
                        [-1, 3],
                        [3, 4],
                        [-2, -4]];

  group('Testing twosat algorithm:', () {
    test('Calculate boolean satisfiability of satfile1: Expect false', () {
      var twosatFuture = twosat(satfile1).then((twosatResults) {
        expect(twosatResults, equals(false));
      });
      expect(twosatFuture, completes);
    });
    test('Calculate boolean satisfiability of satfile2: Expect true', () {
      var twosatFuture = twosat(satfile2).then((twosatResults) {
        expect(twosatResults, equals(true));
      });
      expect(twosatFuture, completes);
    });
  });
}