// Copyright (c) 2012, scribeGriff (Richard Griffith)
// https://github.com/scribeGriff/ConvoLab
// All rights reserved.  Please see the LICENSE.md file.

part of graphlab;

/**
 *   Standard library exception.
*/

class GraphLabException implements Exception {
  const GraphLabException([String msg]);
  String toString() => "Algorithm exception encountered.";
}
