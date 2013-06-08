// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

/**
 * Example using Prims MST algorithm to compute the minimum spanning
 * tree of a weighted, directed graph.
 *
 */

import 'package:graphlab/graphlab.dart';

void main() {

  List<List<int>> graph = [[1, 2, 2],
                           [1, 3, 5],
                           [1, 4, 7],
                           [4, 5, 13],
                           [3, 4, 3]];

  var nodes = 5;
  primst(graph, nodes).then((mstResults) {
    print('The minimum spanning tree of this graph is:\n${mstResults.data}');
    print('The sum of the edge weights of the mst is: ${mstResults.value}');
  });

  // prints:
  // [[1, 2, 2], [1, 3, 5], [3, 4, 3], [4, 5, 13]]
  // 23
}

