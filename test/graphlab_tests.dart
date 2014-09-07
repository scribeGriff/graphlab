// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

library graphlabtests;

/**
 * Unit testing for graphlab library.
 *
 * Includes tests for the following library functions:
 * * all pairs shortest path
 * * knapsack
 * * kruskals mst
 * * prims mst
 * * strongly connected components
 * * two sat solver
 *
 */

import 'package:graphlab/graphlab.dart';
import 'package:unittest/unittest.dart';
import 'dart:collection';

part 'tests/apsp_tests.dart';
part 'tests/kmst_tests.dart';
part 'tests/knapsack_tests.dart';
part 'tests/primst_tests.dart';
part 'tests/scc_tests.dart';
part 'tests/twosat_tests.dart';

void main() {
  group('All Tests:', () {
    group('Test of all pairs shortest path algorithm.', () => apspTests());
    group('Test of kruskals mst algorithm.', () => kmstTests());
    group('Test of knapsack algorithm.', () => knapsackTests());
    group('Test of prims mst algorithm.', () => primstTests());
    group('Test of strongly connected components algorithm.', () => sccTests());
    group('Test of twosat algorithm.', () => twosatTests());
  });
}
