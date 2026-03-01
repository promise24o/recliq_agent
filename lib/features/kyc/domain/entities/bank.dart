class Bank {
  final String name;
  final String code;
  final String slug;

  const Bank({
    required this.name,
    required this.code,
    required this.slug,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      name: json['name'] as String,
      code: json['code'] as String,
      slug: json['slug'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'slug': slug,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Bank && other.code == code;
  }

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => name;
}
