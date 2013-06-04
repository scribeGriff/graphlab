// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

part of graphlabtests;

/**
 * Unit testing of all pairs shortest pair algorithm for the graphlab library.
 */

void apspTests() {
  logMessage('Performing all pairs shortest path tests.');
  // The shortest shortes path in this list is -7 between nodes 3 and 4.
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

  // This graph contains a negative cycle so apsp() should return null.
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

  group('Testing apsp algorithm:', () {
    test('Calculate all pairs shortest path value: Expect shortest '
        'shortest path of -7 between nodes 3 and 4.', () {
      var sspFuture = apsp(graph1, nodes, edges).then((sspResults) {
        expect(sspResults.value, equals(-7));
        expect(sspResults.nodes[0], equals(3));
        expect(sspResults.nodes[1], equals(4));
      });
      expect(sspFuture, completes);
    });
    test('Calculate all pairs shortest path value: Expect negative '
        'cycle to result in return of null.', () {
      var sspFuture = apsp(graph2, nodes, edges).then((sspResults) {
        expect(sspResults, isNull);
      });
      expect(sspFuture, completes);
    });
  });
}