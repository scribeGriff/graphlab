// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

/**
 * Example using the function 2sat() to determine the satisfiability
 * of a 2d array of clauses.  Implements Kosaraju's algorithm to allow
 * a linear bound on this special case of the general NPC boolean
 * satisfiability problem.
 */

import 'package:graphlab/graphlab.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

void main() {
  String filename = 'data/2sat6.txt';
  List<List<int>> satfile = [];
  Stopwatch watch = new Stopwatch()..start();
  Stream stream = new File(filename).openRead();
  stream
      .transform(UTF8.decoder)
      .transform(new LineSplitter())
      .listen((String line) {
        List<String> stringBuffer = line.split(" ");
        List<int> intBuffer = [];
        stringBuffer.forEach((element) {
          if(!element.isEmpty) intBuffer.add(int.parse(element.trim()));
        });
        satfile.add(intBuffer);
      },
      onDone: () {
        print('There are ${satfile.length} clauses in this graph.');
        print('Finished reading in file in ${watch.elapsedMilliseconds / 1000} secs');
        twosat(satfile).then((isSat) {
          print('Finished computing the 2-SAT problem in ${watch.elapsedMilliseconds / 1000} secs');
          if (isSat) {
            print('The graph is satisfiable.');
          } else {
            print('The graph is not satisfiable.');
          }
        },
        onError: (e) {
          print('There was an error computing the 2-SAT: $e');
        });
      },
      onError: (e) {
        print('There was an error opening the file: $e');
      });
  // Prints:
  // There are 1000000 clauses in this graph.
  // Finished reading in file in 4.507 secs
  // Finished creating graphs in 7.134 secs
  // finished first DFS in 1.106 secs
  // finished second DFS in 2.113 secs
  // Finished calculating data in 0.019 secs
  // Finished computing the 2-SAT problem in 21.955 secs
  // The graph is not satisfiable.
}

