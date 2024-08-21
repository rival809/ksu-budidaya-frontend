class HelperSum {
  sumTwoValueString(String? a, String? b) {
    if (a == null || b == null) {
      return "-";
    }
    return (int.parse(a) + int.parse(b)).toString();
  }
}
