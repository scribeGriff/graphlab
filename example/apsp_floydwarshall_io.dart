// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

/**
 *  Example using the function apsp() to compute all pairs shortest paths
 *  of a graph using the Floyd-Warshall algorithm.
 */

import 'package:graphlab/graphlab.dart';
import 'dart:async';
import 'dart:io';
import 'dart:collection';

void main() {
  //Path to external file.
  String filename = 'data/large_apsp_negcyc.txt';
  final nodes = 1000;
  List<List<int>> apspfile = [];
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
        apspfile.add(intBuffer);
      },
      onDone: () {
        print('Finished reading in file in ${watch.elapsedMilliseconds / 1000} secs.');
        print('There are ${apspfile.length} edges in this graph.');
        apsp(apspfile, nodes, apspfile.length).then((sspResults) {
          print('Finished computing all pairs shortest paths in ${watch.elapsedMilliseconds / 1000} secs.');
          if (sspResults == null) {
            print('A negative cycle has been detected.');
          } else {
            print('The shortest shortest path length for this graph'
                ' is ${sspResults.value}.');
            print('The shortest shortest path for this graph is between'
                ' node ${sspResults.nodes[0]} and node ${sspResults.nodes[1]}');
          }
        });
      },
      onError: (e) {
        print('There was an error: $e');
      });
  // Prints:
  // Finished reading in file in 0.296 secs.
  // There are 47978 edges in this graph.
  // Finished computing all pairs shortest paths in 24.808 secs.
  // A negative cycle has been detected.
}

