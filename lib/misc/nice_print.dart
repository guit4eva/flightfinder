// =============================================================================
// Display multi-line logs in a pretty format
// =============================================================================

class Misc {
  void easyDebug(Map<String, dynamic> toPrint) {
    print("############################");

    toPrint.forEach((k, v) {
      print('## $k: ' + v.toString());
    });
    print("############################");
  }
}

// Sample output:
//
// I/flutter ( 6985): ##############################
// I/flutter ( 6985): ## foo: bar
// I/flutter ( 6985): ## listFoo: [bar, cake, llama]
// I/flutter ( 6985): ## someVar: someRandomValue
// I/flutter ( 6985): ##############################
