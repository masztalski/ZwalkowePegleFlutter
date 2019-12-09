class River {
  String shortName; //name for display
  String fullName; //name for searching stations

  River({this.shortName, this.fullName});

  static String getRiverShortName(String fullName) {
    return fullName.substring(0, fullName.lastIndexOf('(') - 1);
  }
}