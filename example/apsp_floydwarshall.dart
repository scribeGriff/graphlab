// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

/**
 *  Example using the function apsp() to compute all pairs shortest path
 *  of an edge weighted using the Floyd - Warshall algorithm.
 *
 *  Returns null if a negative cycle is detected.  If successful, the value of
 *  the shortest shortest path is returned as well as a list of all the shortest
 *  paths.
 */

import 'package:graphlab/graphlab.dart';
import 'dart:async';

void main() {
  List<List<int>> adjl = [[1, 2, 2],
                          [1, 3, 5],
                          [2, 4, -4],
                          [4, 3, 8],
                          [4, 5, 2],
                          [3, 1, 4],
                          [3, 2, -3],
                          [3, 4, 6],
                          [3, 6, 5],
                          [6, 4, 1],
                          [6, 5, -5]];
  var nodes = 6;
  var edges = 11;
  apsp(adjl, nodes, edges).then((sspResults) {
    if (sspResults == null) {
      print('Negative cycle detected');
    } else {
      print('The shortest shortest path length is ${sspResults.value}.');
      print(sspResults.data);
    }
  });
}