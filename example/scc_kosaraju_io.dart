// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/ConvoLab
// All rights reserved.  Please see the LICENSE.md file.

/**
 *  Example using the function scc() to compute the strongly connected
 *  components of a directed graph.  Implements the Kosaraju algorithm.
 */

import 'package:graphlab/graphlab.dart';
import 'dart:async';
import 'dart:io';
import 'dart:collection';

void main() {
  //Path for use in editor.
  //String filename = 'example/data/large_scc.txt';
  //Path for command line.
  String filename = 'data/large_scc.txt';
  List<List<int>> sccfile = [];
  Stopwatch watch = new Stopwatch()..start();
  Stream<List<int>> stream = new File(filename).openRead();
  stream
      .transform(new StringDecoder())
      .transform(new LineTransformer())
      .listen((String line) {
        var stringBuffer = line.split(" ");
        var intBuffer = [];
        stringBuffer.forEach((element) {
          if(!element.isEmpty) {
            intBuffer.add(int.parse(element.trim()));
          }
        });
        sccfile.add(intBuffer);
      },
      onDone: () {
        print('Finished reading in file in ${watch.elapsedMilliseconds / 1000} secs');
        print('There are ${sccfile.length} edges in this graph.');
        scc(sccfile).then((sccResults) {
          print('Finished computing all sccs in ${watch.elapsedMilliseconds / 1000} secs');
          print('This graph contains ${sccResults.value} nodes.');
          print('The size of the 10 largest sccs is ${sccResults.data.sublist(0, 10)}');
          print('The total number of sccs is ${sccResults.data.length}');
          // We can reorder the results and put the scc as the key and the nodes
          // as the values. Note - don't try this on large graphs.  Very slow.
//          HashMap sets = new HashMap();
//          for (var value in sccResults.sccNodes.values) {
//            if (!sets.containsKey(value)) {
//              sets[value] = new HashSet();
//              for (var key in sccResults.sccNodes.keys) {
//                if (sccResults.sccNodes[key] == value) {
//                  sets[value].add(key);
//                }
//              }
//            }
//          }
//          print('The map of components with a list of the nodes belonging to it: \n'
//              '$sets');
        });
      },
      onError: (e) {
        print('There was an error: $e');
      });
  // Prints:
  // The size of each strongly connected component is [6, 5, 3, 1].
  // There are 15 nodes in this graph.
  // The map of nodes with the scc the node belongs in:
  // {1: 2, 2: 2, 3: 2, 4: 3, 5: 1, 6: 1, 7: 1, 8: 1, 9: 1, 10: 1, 11: 0, 12: 0, 13: 0, 14: 0, 15: 0}
  // The map of components with a list of the nodes belonging to it:
  // {0: {11, 12, 13, 14, 15}, 1: {8, 9, 10, 5, 6, 7}, 2: {1, 2, 3}, 3: {4}}
}

