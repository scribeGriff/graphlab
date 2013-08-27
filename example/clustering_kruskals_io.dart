// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

/**
 *  Example of computing the maximum spacing of a 4-clustering
 *  using Kruskal's MST algorithm.
 */

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
        kmst(cluster_small, nodes).then((clusterResults) {
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
  // Finished computing the minimum spanning tree in 0.09 secs.
  // Calculating the maximum spacing of a 4-clustering for this graph...
  // The maximum spacing of a 4-clustering for this graph is 1951.
}

