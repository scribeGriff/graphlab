![](http://www.scribegriff.com/dartlang/github/graphlab/graphlab-logo.png)

# Graphlab #

### A small library of (mostly) graph algorithms. ###


## Overview ##
The graphlab library is a `Future<>` based library supporting the following graph algorithms:

- `scc()`: Strongly Connected Components (with Kosaraju)
- `twosat()`: 2-Sat Problem (with Kosaraju)
- `primst()`: Prim's MST
- `kmst()`: Kruskal's MST 
- `apsp()`: All Pair's Shortest Path (with Floyd-Warshall)
- `knap()`: Knapsack Problem 

Library access is through top level function calls.

### Library Usage ##

Add the following to your pubspec.yaml:

````dart
graphlab:
  git: git://github.com/scribeGriff/graphlab.git
````

Then import the library to your app:

````dart
import 'package:graphlab/graphlab.dart';
````

An example of the computing the strongly connected components of a directed graph given a 2D array of type `List<List<int>>` called ***mysccfile***:

````dart
scc(mysccfile).then((sccResults) {
  print('The size of each strongly connected component is${sccResults.data}.');
  print('There are ${sccResults.value} nodes in this graph.');
  print('The map of nodes with the scc the node belongs in: \n'
  '${sccResults.sccNodes}');

  HashMap sets = new HashMap();
  for (var value in sccResults.sccNodes.values) {
    if (!sets.containsKey(value)) {
      sets[value] = new HashSet();
      for (var key in sccResults.sccNodes.keys) {
        if (sccResults.sccNodes[key] == value) {
          sets[value].add(key);
        }
      }
    }
  }
  print('The map of components with a list of the nodes belonging to it: \n'
  '$sets');
});
````

An example of computing the maximum spacing of a 4-clustering given a distance function (ie, a graph with edge costs) by using Prim's minimum spanning tree, `primst()` (Kruskal's MST, `kmst()`, could also be used):

````dart
import 'package:graphlab/graphlab.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

void main() {
  //Path to external file.
  String filename = 'data/clustering_20_1951.txt';
  final nodes = 20;
  final cluster = 4;
  List<List<int>> cluster_small = [];
  Stopwatch watch = new Stopwatch()..start();
  Stream<List<int>> stream = new File(filename).openRead();
  stream
    .transform(UTF8.decoder)
    .transform(new LineSplitter())
    .listen((String line) {
      var stringBuffer = line.split(" ");
      var intBuffer = [];
      stringBuffer.forEach((element) {
        if(!element.isEmpty) {
        intBuffer.add(int.parse(element.trim()));
      }
    });
    cluster_small.add(intBuffer);
  },
  onDone: () {
    print('Finished reading in file in ${watch.elapsedMilliseconds / 1000} secs.');
    print('There are ${cluster_small.length} edges in this graph.');
    primst(cluster_small, nodes).then((clusterResults) {
      print('Finished computing the minimum spanning tree in ${watch.elapsedMilliseconds / 1000} secs.');
      print('Calculating the maximum spacing of a 4-clustering for this graph...');
      var cluster_spacings = clusterResults.data.map((x) => x.elementAt(2)).toList()
        ..sort();
      print('The maximum spacing of a 4-clustering for this graph is '
            '${cluster_spacings[cluster_spacings.length + 1 - cluster]}.');
    });
  },
  onError: (e) {
    print('There was an error: $e');
  });
  // Prints:
  // Finished reading in file in 0.054 secs.
  // There are 190 edges in this graph.
  // Finished computing the minimum spanning tree in 0.071 secs.
  // Calculating the maximum spacing of a 4-clustering for this graph...
  // The maximum spacing of a 4-clustering for this graph is 1951.
}
````
