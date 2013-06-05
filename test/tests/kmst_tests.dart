// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

part of graphlabtests;

/**
 * Unit testing of kruskals mst algorithm for the graphlab library.
 */

void kmstTests() {
  logMessage('Performing kruskals mst algorithm tests.');

  List<List<int>> graph = [[1, 2, 2],
                           [1, 3, 5],
                           [1, 4, 7],
                           [4, 5, 13],
                           [3, 4, 3]];

  List<List<int>> mst = [[1, 2, 2],
                         [3, 4, 3],
                         [1, 3, 5],
                         [4, 5, 13]];

  var nodes = 5;

  group('Testing kmst algorithm:', () {
    test('Calculate the minimum spanning tree of a graph: Expect sum of '
        'weighted edges is 23.', () {
      var kmstFuture = kmst(graph, nodes).then((kmstResults) {
        expect(kmstResults.value, equals(23));
        expect(kmstResults.data, equals(mst));
      });
      expect(kmstFuture, completes);
    });
  });
}