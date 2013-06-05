// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

/**
 *  Example using the function apsp() to compute all pairs shortest path
 *  of an edge weighted graph using the Floyd - Warshall algorithm.
 *
 *  Returns null if a negative cycle is detected.  If successful, the value of
 *  the shortest shortest path is returned as well as a list of all the shortest
 *  paths.
 */

import 'package:graphlab/graphlab.dart';
import 'dart:async';

void main() {
  // The shortest shortest path is between nodes 3 and 4 and is equal to -7.
  List<List<int>> graph1 = [[1, 2, 2],
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

  // This graph contains a negative cycle.
  List<List<int>> graph2 = [[1, 2, 2],
                            [1, 3, 5],
                            [2, 4, -4],
                            [4, 3, 6],
                            [4, 5, 2],
                            [3, 1, 4],
                            [3, 2, -3],
                            [3, 4, 6],
                            [3, 6, 5],
                            [6, 4, 1],
                            [6, 5, -5]];
  var nodes = 6;
  var edges = 11;
  var graphs = [graph1, graph2];

  for (var graph in graphs) {
    var index = graphs.indexOf(graph) + 1;
    apsp(graph, nodes, edges).then((sspResults) {
      if (sspResults == null) {
        print('A negative cycle has been detected in graph #$index.');
      } else {
        print('The shortest shortest path length for graph #$index'
            ' is ${sspResults.value}.');
        print('The shortest shortest path for graph #$index is between'
            ' node ${sspResults.nodes[0]} and node ${sspResults.nodes[1]}');
      }
    });
  }
}