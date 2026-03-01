class City {
  final String id;
  final String name;
  final String state;
  final bool? isActive;
  final int? zoneCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const City({
    required this.id,
    required this.name,
    required this.state,
    this.isActive,
    this.zoneCount,
    this.createdAt,
    this.updatedAt,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as String,
      name: json['name'] as String,
      state: json['state'] as String,
      isActive: json['isActive'] as bool?,
      zoneCount: json['zoneCount'] as int?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state': state,
      if (isActive != null) 'isActive': isActive,
      if (zoneCount != null) 'zoneCount': zoneCount,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}
