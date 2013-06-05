// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

part of graphlabtests;

/**
 * Unit testing of knapsack algorithm for the graphlab library.
 */

void knapsackTests() {
  logMessage('Performing knapsack algorithm tests.');

  List<List<int>> ksack1 = [[874, 580],
                            [620, 1616],
                            [345, 1906],
                            [369, 1942],
                            [360, 50],
                            [470, 294]];

  var capacity = 2000;

  group('Testing knapsack algorithm:', () {
    test('Calculate optimum knapsack weight and value: Expect value = 1704 and '
        'weight = 924', () {
      var knapFuture = knap(ksack1, capacity).then((ksackResults) {
        expect(ksackResults.value, equals(1704));
        expect(ksackResults.weight, equals(924));
      });
      expect(knapFuture, completes);
    });
  });
}