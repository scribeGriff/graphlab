// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

/**
 *  Example using the function knsp() to compute the optimum value
 *  of a knapsack with a capacity of 10000.
 */

import 'package:graphlab/graphlab.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

void main() {
  //Path to external file.
  String filename = 'data/knapsack_small.txt';
  final capacity = 10000;
  List<List<int>> ksack_small = [];
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
        ksack_small.add(intBuffer);
      },
      onDone: () {
        print('Finished reading in file in ${watch.elapsedMilliseconds / 1000} secs.');
        print('There are ${ksack_small.length} items to choose from.');
        knap(ksack_small, capacity).then((ksackResults) {
          print('Finished computing optimum value in ${watch.elapsedMilliseconds / 1000} secs.');
          print('The optimum knapsack has a value of ${ksackResults.value}'
          ' with a weight of ${ksackResults.weight}.');
          print('The optimal solution selects the following items:');
          for (var index = 0; index < ksack_small.length; index++) {
            if (ksackResults.data[index]) {
              print(ksack_small[index]);
            }
          }
        });
      },
      onError: (e) {
        print('There was an error: $e');
      });
  // Prints:
  // Finished reading in file in 0.048 secs.
  // There are 100 items to choose from.
  // Finished computing optimum value in 0.115 secs.
  // The optimum knapsack has a value of 2493893 with a weight of 9976.
  // The optimal solution selects the following items:
  // [64441, 166]
  // [84493, 43]
  // [82328, 730]
  // [78841, 613]
  // [44304, 170]
  // [93100, 279]
  // [51817, 336]
  // [99098, 827]
  // [80980, 150]
  // [25229, 92]
  // [40195, 358]
  // [35002, 154]
  // [88125, 197]
  // [28550, 25]
  // [28636, 14]
  // [24116, 95]
  // [75630, 502]
  // [46518, 196]
  // [82189, 124]
  // [54439, 145]
  // [53178, 398]
  // [59746, 176]
  // [53636, 299]
  // [98143, 400]
  // [41595, 9]
  // [97943, 366]
  // [85696, 713]
  // [14739, 58]
  // [37336, 7]
  // [97973, 99]
  // [49096, 320]
  // [83455, 224]
  // [48906, 127]
  // [35239, 95]
  // [36551, 160]
  // [97386, 218]
  // [95273, 540]
  // [99248, 386]
  // [46043, 12]
  // [54680, 153]
}

