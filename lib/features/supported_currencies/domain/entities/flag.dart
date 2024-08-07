class Flag {
  final String countryCode;
  final String url;

  Flag({
    required this.countryCode,
    required this.url,
  });

  // Convert a Flag into a Map.
  Map<String, dynamic> toMap() {
    return {
      'countryCode': countryCode,
      'url': url,
    };
  }

  // Convert a Map into a Flag.
  factory Flag.fromMap(Map<String, dynamic> map) {
    return Flag(
      countryCode: map['countryCode'],
      url: map['url'],
    );
  }
}
