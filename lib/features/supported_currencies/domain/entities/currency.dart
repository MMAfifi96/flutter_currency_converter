class Currency {
  final String code;
  final String name;

  Currency({
    required this.code,
    required this.name,
  });

  // Convert a Currency into a Map.
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
    };
  }

  // Convert a Map into a Currency.
  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      code: map['code'],
      name: map['name'],
    );
  }
}
