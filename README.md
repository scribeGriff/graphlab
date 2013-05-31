![](http://www.scribegriff.com/dartlang/github/graphlab/graphlab-logo.png)

# Graphlab #

## A small library of graph algorithms. ##

## Overview ##
The graphlab library is a `Future<>` based library supporting the following graph algorithms:

- `scc()`: Strongly Connected Components (with Kosaraju)
- `twosat()`: 2-Sat Problem (with Kosaraju)
- `primst()`: Prim's MST
- `kmst()`: Kruskal's MST 
- `apsp()`: All Pair's Shortest Path (with Floyd-Warshall)
- `knap()`: Knapsack Problem 

Libary access is through top level function calls.

### Library Usage ##

Add the following to your pubspec.yaml:

    graphlab:
      git: git://github.com/scribeGriff/graphlab.git

Then import the library to your app:

    import 'package:graphlab/graphlab.dart';

An example of the computing the strongly connected components of a directed graph given a 2D array of type `List<List<int>>` called ***mysccfile***:

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
