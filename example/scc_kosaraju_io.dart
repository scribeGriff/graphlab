// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

/**
 *  Example using the function scc() to compute the strongly connected
 *  components of a directed graph.  Implements the Kosaraju algorithm.
 */

import 'package:graphlab/graphlab.dart';
import 'dart:async';
import 'dart:io';
import 'dart:collection';
import 'dart:convert';

void main() {
  //Path to external file.
  String filename = 'data/small_scc.txt';
  List<List<int>> sccfile = [];
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
        sccfile.add(intBuffer);
      },
      onDone: () {
        print('Finished reading in file in ${watch.elapsedMilliseconds / 1000} secs.');
        print('There are ${sccfile.length} edges in this graph.');
        scc(sccfile).then((sccResults) {
          print('Finished computing all sccs in ${watch.elapsedMilliseconds / 1000} secs.');
          print('This graph contains ${sccResults.value} nodes.');
          print('The size of the 4 largest sccs is ${sccResults.data.sublist(0, 4)}.');
          print('The total number of sccs is ${sccResults.data.length}.');
          // We can reorder the results and put the scc as the key and the nodes
          // as the values. Note - don't try this on large graphs.  Very slow.
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
      },
      onError: (e) {
        print('There was an error: $e');
      });
  // Prints:
  // Finished reading in file in 0.03 secs.
  // There are 29 edges in this graph.
  // Finished computing all sccs in 0.046 secs.
  // This graph contains 15 nodes.
  // The size of the 4 largest sccs is [6, 5, 3, 1].
  // The total number of sccs is 4.
  // The map of components with a list of the nodes belonging to it:
  // {0: {11, 12, 13, 14, 15}, 1: {8, 9, 10, 5, 6, 7}, 2: {1, 2, 3}, 3: {4}}
}

