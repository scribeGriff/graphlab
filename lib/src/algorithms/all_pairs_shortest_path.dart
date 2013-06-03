// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

part of graphlab;

/**
 * Computes the all pairs shortest paths using the Floyd Warshall algorithm.
 *
 * Given an directed graph of edges with their edge weights, compute the
 * shortest path between two vertices for all pairs of nodes in the graph.
 * If a negative cycle is detected, then the solution is not valid and null
 * is returned.  If a valid solution is obtained, then the value of the
 * shortest shortest path is returned and a list of all the shortest paths.
 *
 * Example usage:
 *
 *     List<List<int>> adjl = [[1, 2, 2],
 *                             [1, 3, 5],
 *                             [2, 4, -4],
 *                             [4, 3, 8],
 *                             [4, 5, 2],
 *                             [3, 1, 4],
 *                             [3, 2, -3],
 *                             [3, 4, 6],
 *                             [3, 6, 5],
 *                             [6, 4, 1],
 *                             [6, 5, -5]];
 *     var nodes = 6;
 *     var edges = 11;
 *     apsp(adjl, nodes, edges).then((sspResults) {
 *       if (ssp == null) {
 *         print('A negative cycle has been detected.');
 *       } else {
 *         print('The shortest shortest path length is ${ssp.value}.');
 *       }
 *     });
 *
 * Prints: The shortest shortest path length is -7.
 *
 * Returns an object of type ApspResults if successful or null if a
 * negative cycle was found.
 *
 * Dependencies included in this file:
 * * class ApspResults
 *
 */

/// The top level function apsp returns the object ApspResults.
Future<ApspResults> apsp(var adjList, var numVertices, var numEdges) =>
    new Future(() => new _Apsp(adjList).computeApsp(numVertices, numEdges));

class _Apsp {
  // Just need some large value to indicate that no path exists.
  const largeValue = 2147483647;

  final List<List> adjList;
  List<List> adjMatrix;
  List<List> apspList = [];

  _Apsp(this.adjList);

  ApspResults computeApsp(var numVertices, var numEdges) {
    var N = numVertices;
    var K = numEdges;
    var shortest = largeValue;

    // Create a 2D array and populate it with variable largeValue.
    adjMatrix = new List.generate(N, (var index) => new List.filled(N, largeValue));

    // If index i = j in the adjacency matrix, set its value to 0.
    for (var i = 0; i < N; i++) {
      for (var j = 0; j < N; j++) {
        if (i == j) {
          adjMatrix[i][j] = 0;
        }
      }
    }
    // Map the adjacency list to the sparse array.
    for (var i = 1; i < adjList.length; i++) {
      adjMatrix[adjList[i][0] - 1][adjList[i][1] - 1] = adjList[i][2];
    }
    // Implement the Floyd Warshall dynamic programming algorithm.
    for (var i = 0; i < N; i++) {
      for (var j = 0; j < N; j++) {
        for (var k = 0; k < N; k++) {
          if (adjMatrix[j][k] > adjMatrix[j][i] + adjMatrix[i][k]) {
            adjMatrix[j][k] = adjMatrix[j][i] + adjMatrix[i][k];
          }
        }
        if (adjMatrix[j][j] < 0.0) {
          // Found a negative edge cycle. Exit and return null.
          return null;
        }
      }
    }
    // Create a list of the shortests paths and find
    // the shortest shortest path value.
    for (var i = 0; i < N; i++) {
      for (var j = 0; j < N; j++) {
        if (adjMatrix[i][j]  < largeValue >> 1) {
          apspList.add([i + 1, j + 1, adjMatrix[i][j]]);
        } else {
          apspList.add([i + 1, j + 1, 'inf']);
        }
        if (adjMatrix[i][j] < shortest) {
          shortest = adjMatrix[i][j];
        }
      }
    }
    // Return the nodes of the shortest shortest path as a List.
    var nodes = apspList.where((x) => x.elementAt(2) == shortest).map((x) =>
        x.sublist(0, 2)).toList()[0];
    return new ApspResults(apspList, shortest, nodes);
  }
}

/// ApspResults extends the standard results class.
/// Returns a 2D array of the shortest paths between two vertices as data
/// and the shortest of the shortest paths as value.
class ApspResults extends GraphLabResults {
  final List nodes;

  ApspResults(List data, int value, this.nodes) : super(data, value);
}