library wallet_whitelabel;
extension StringExtension on String {
  String get onlyNumber {
    String text = "";
    split("").forEach((e) => text += int.tryParse(e) != null ? e : "");
    return text;
  }
}
