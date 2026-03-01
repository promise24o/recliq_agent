class Zone {
  final String id;
  final String name;
  final String city;
  final String state;
  final String? status;
  final String? coverageLevel;
  final int? agentCount;
  final double? areaKm2;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Zone({
    required this.id,
    required this.name,
    required this.city,
    required this.state,
    this.status,
    this.coverageLevel,
    this.agentCount,
    this.areaKm2,
    this.createdAt,
    this.updatedAt,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      status: json['status'] as String?,
      coverageLevel: json['coverageLevel'] as String?,
      agentCount: json['agentCount'] as int?,
      areaKm2: json['areaKm2'] != null 
          ? (json['areaKm2'] as num).toDouble() 
          : null,
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
      'city': city,
      'state': state,
      if (status != null) 'status': status,
      if (coverageLevel != null) 'coverageLevel': coverageLevel,
      if (agentCount != null) 'agentCount': agentCount,
      if (areaKm2 != null) 'areaKm2': areaKm2,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}
