class Locale {
  final Map<String, List<String>> cities;

  Locale(this.cities);

  factory Locale.fromJson(Map<String, dynamic> json) {
    return Locale(Map<String, List<String>>.from(json));
  }
}
