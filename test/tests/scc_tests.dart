// Copyright (c) 2013, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/graphlab
// All rights reserved.  Please see the LICENSE.md file.

part of graphlabtests;

/**
 * Unit testing of strongly connected components algorithm for the graphlab library.
 */

void sccTests() {
  logMessage('Performing strongly connected components tests.');

  List<List> sccfile1 = [[1, 1],
                         [1, 3],
                         [3, 2],
                         [2, 1],
                         [3, 5],
                         [4, 1],
                         [4, 2],
                         [4, 12],
                         [4, 13],
                         [5, 6],
                         [5, 8],
                         [6, 7],
                         [6, 8],
                         [6, 10],
                         [7, 10],
                         [8, 9],
                         [8, 10],
                         [9, 5],
                         [9, 11],
                         [10, 9],
                         [10, 11],
                         [10, 14],
                         [11, 12],
                         [11, 14],
                         [12, 13],
                         [13, 11],
                         [13, 15],
                         [14, 13],
                         [15, 14]];

  List sccSize = [6, 5, 3, 1];
  HashMap sccs = new HashMap();
  sccs[1] = 2;
  sccs[2] = 2;
  sccs[3] = 2;
  sccs[4] = 3;
  sccs[5] = 1;
  sccs[6] = 1;
  sccs[7] = 1;
  sccs[8] = 1;
  sccs[9] = 1;
  sccs[10] = 1;
  sccs[11] = 0;
  sccs[12] = 0;
  sccs[13] = 0;
  sccs[14] = 0;
  sccs[15] = 0;

  group('Testing scc algorithm:', () {
    test('Calculate scc value: Expect scc sizes [6, 5, 3, 1]', () {
      var sccFuture = scc(sccfile1).then((sccResults) {
        expect(sccResults.data, equals(sccSize));
        expect(sccResults.value, equals(15));
        expect(sccResults.sccNodes, equals(sccs));
      });
      expect(sccFuture, completes);
    });
  });
}