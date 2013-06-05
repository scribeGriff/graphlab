// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

part of graphlabtests;

/**
 * Unit testing of prims mst for the graphlab library.
 */

void primstTests() {
  logMessage('Performing prims mst tests.');

  List<List<int>> graph = [[1, 2, 2],
                           [1, 3, 5],
                           [1, 4, 7],
                           [4, 5, 13],
                           [3, 4, 3]];

  List<List<int>> mst = [[1, 2, 2],
                         [1, 3, 5],
                         [3, 4, 3],
                         [4, 5, 13]];

  var nodes = 5;

  group('Testing primst algorithm:', () {
    test('Calculate the minimum spanning tree of a graph: Expect sum of '
        'weighted edges is 23.', () {
      var primstFuture = primst(graph, nodes).then((primstResults) {
        expect(primstResults.value, equals(23));
        expect(primstResults.data, equals(mst));
      });
      expect(primstFuture, completes);
    });
  });
}