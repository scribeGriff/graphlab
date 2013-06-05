// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

/**
 * An example of computing the optimum solution to a knapsack alogorithm
 * problem.  The 2D array should privide the value of the item followed by
 * its weight: [value, weight].
 *
 */

import 'package:graphlab/graphlab.dart';
import 'dart:async';

void main() {

  List<List<int>> ksack1 = [[874, 580],
                            [620, 1616],
                            [345, 1906],
                            [369, 1942],
                            [360, 50],
                            [470, 294]];

  var capacity = 2000;
  knap(ksack1, capacity).then((ksackResults) {
    print('The optimum knapsack has a value of ${ksackResults.value}'
    ' with a weight of ${ksackResults.weight}.');
    print('The optimum solution selects the following items:');
    for (var index = 0; index < ksack1.length; index++) {
      if (ksackResults.data[index]) {
        print(ksack1[index]);
      }
    }
  });

  // prints:
  // The optimum knapsack has a value of 1704 with a weight of 924.
  // The optimum solution selects the following items:
  // [874, 580]
  // [360, 50]
  // [470, 294]
}

