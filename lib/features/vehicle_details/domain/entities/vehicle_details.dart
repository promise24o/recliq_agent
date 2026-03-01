enum VehicleType {
  motorcycle,
  tricycle,
  car,
  mini_truck,
  truck,
  specialized_recycling;

  static VehicleType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'motorcycle':
        return VehicleType.motorcycle;
      case 'tricycle':
        return VehicleType.tricycle;
      case 'car':
        return VehicleType.car;
      case 'mini_truck':
        return VehicleType.mini_truck;
      case 'truck':
        return VehicleType.truck;
      case 'specialized_recycling':
        return VehicleType.specialized_recycling;
      default:
        throw ArgumentError('Invalid vehicle type: $value');
    }
  }

  String toJson() {
    return name;
  }

  @override
  String toString() {
    switch (this) {
      case VehicleType.motorcycle:
        return 'Motorcycle';
      case VehicleType.tricycle:
        return 'Tricycle';
      case VehicleType.car:
        return 'Car';
      case VehicleType.mini_truck:
        return 'Mini Truck';
      case VehicleType.truck:
        return 'Truck';
      case VehicleType.specialized_recycling:
        return 'Specialized Recycling';
    }
  }
}

enum FuelType {
  petrol,
  diesel,
  electric,
  hybrid;

  static FuelType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'petrol':
        return FuelType.petrol;
      case 'diesel':
        return FuelType.diesel;
      case 'electric':
        return FuelType.electric;
      case 'hybrid':
        return FuelType.hybrid;
      default:
        throw ArgumentError('Invalid fuel type: $value');
    }
  }

  String toJson() {
    return name;
  }

  @override
  String toString() {
    switch (this) {
      case FuelType.petrol:
        return 'Petrol';
      case FuelType.diesel:
        return 'Diesel';
      case FuelType.electric:
        return 'Electric';
      case FuelType.hybrid:
        return 'Hybrid';
    }
  }
}

enum MaterialType {
  PET,
  Metals,
  Mixed,
  E_waste,
  Organic,
  Paper,
  Plastic,
  Glass,
  Textiles,
  Batteries;

  static MaterialType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'pet':
        return MaterialType.PET;
      case 'metals':
        return MaterialType.Metals;
      case 'mixed':
        return MaterialType.Mixed;
      case 'e-waste':
      case 'e_waste':
        return MaterialType.E_waste;
      case 'organic':
        return MaterialType.Organic;
      case 'paper':
        return MaterialType.Paper;
      case 'plastic':
        return MaterialType.Plastic;
      case 'glass':
        return MaterialType.Glass;
      case 'textiles':
        return MaterialType.Textiles;
      case 'batteries':
        return MaterialType.Batteries;
      default:
        throw ArgumentError('Invalid material type: $value');
    }
  }

  String toJson() {
    return name;
  }

  @override
  String toString() {
    switch (this) {
      case MaterialType.PET:
        return 'PET';
      case MaterialType.Metals:
        return 'Metals';
      case MaterialType.Mixed:
        return 'Mixed';
      case MaterialType.E_waste:
        return 'E-waste';
      case MaterialType.Organic:
        return 'Organic';
      case MaterialType.Paper:
        return 'Paper';
      case MaterialType.Plastic:
        return 'Plastic';
      case MaterialType.Glass:
        return 'Glass';
      case MaterialType.Textiles:
        return 'Textiles';
      case MaterialType.Batteries:
        return 'Batteries';
    }
  }
}

enum DocumentType {
  registration,
  insurance,
  roadworthiness,
  inspection_certificate;

  static DocumentType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'registration':
        return DocumentType.registration;
      case 'insurance':
        return DocumentType.insurance;
      case 'roadworthiness':
        return DocumentType.roadworthiness;
      case 'inspection_certificate':
      case 'inspection-certificate':
        return DocumentType.inspection_certificate;
      default:
        throw ArgumentError('Invalid document type: $value');
    }
  }

  String toJson() {
    return name;
  }

  @override
  String toString() {
    switch (this) {
      case DocumentType.registration:
        return 'Registration';
      case DocumentType.insurance:
        return 'Insurance';
      case DocumentType.roadworthiness:
        return 'Road Worthiness';
      case DocumentType.inspection_certificate:
        return 'Inspection Certificate';
    }
  }
}

enum DocumentStatus {
  pending,
  verified,
  rejected;

  static DocumentStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'pending':
        return DocumentStatus.pending;
      case 'verified':
        return DocumentStatus.verified;
      case 'rejected':
        return DocumentStatus.rejected;
      default:
        throw ArgumentError('Invalid document status: $value');
    }
  }

  String toJson() {
    return name;
  }

  @override
  String toString() {
    switch (this) {
      case DocumentStatus.pending:
        return 'Pending';
      case DocumentStatus.verified:
        return 'Verified';
      case DocumentStatus.rejected:
        return 'Rejected';
    }
  }
}

enum VehicleStatus {
  pending,
  verified,
  rejected,
  approved;

  static VehicleStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'pending':
        return VehicleStatus.pending;
      case 'verified':
        return VehicleStatus.verified;
      case 'rejected':
        return VehicleStatus.rejected;
      case 'approved':
        return VehicleStatus.approved;
      default:
        throw ArgumentError('Invalid vehicle status: $value');
    }
  }

  String toJson() {
    return name;
  }

  @override
  String toString() {
    switch (this) {
      case VehicleStatus.pending:
        return 'Pending';
      case VehicleStatus.verified:
        return 'Verified';
      case VehicleStatus.rejected:
        return 'Rejected';
      case VehicleStatus.approved:
        return 'Approved';
    }
  }
}

class VehicleDocument {
  final DocumentType documentType;
  final String documentUrl;
  final DocumentStatus status;
  final DateTime uploadedAt;
  final DateTime? verifiedAt;
  final String? rejectionReason;

  const VehicleDocument({
    required this.documentType,
    required this.documentUrl,
    required this.status,
    required this.uploadedAt,
    this.verifiedAt,
    this.rejectionReason,
  });

  factory VehicleDocument.fromJson(Map<String, dynamic> json) {
    return VehicleDocument(
      documentType: DocumentType.fromString(json['documentType'] as String),
      documentUrl: json['documentUrl'] as String,
      status: DocumentStatus.fromString(json['status'] as String),
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      verifiedAt: json['verifiedAt'] != null 
          ? DateTime.parse(json['verifiedAt'] as String) 
          : null,
      rejectionReason: json['rejectionReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentType': documentType.toJson(),
      'documentUrl': documentUrl,
      'status': status.toJson(),
      'uploadedAt': uploadedAt.toIso8601String(),
      if (verifiedAt != null) 'verifiedAt': verifiedAt!.toIso8601String(),
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
    };
  }

  VehicleDocument copyWith({
    DocumentType? documentType,
    String? documentUrl,
    DocumentStatus? status,
    DateTime? uploadedAt,
    DateTime? verifiedAt,
    String? rejectionReason,
  }) {
    return VehicleDocument(
      documentType: documentType ?? this.documentType,
      documentUrl: documentUrl ?? this.documentUrl,
      status: status ?? this.status,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VehicleDocument &&
        other.documentType == documentType &&
        other.documentUrl == documentUrl &&
        other.status == status &&
        other.uploadedAt == uploadedAt &&
        other.verifiedAt == verifiedAt &&
        other.rejectionReason == rejectionReason;
  }

  @override
  int get hashCode {
    return documentType.hashCode ^
        documentUrl.hashCode ^
        status.hashCode ^
        uploadedAt.hashCode ^
        verifiedAt.hashCode ^
        rejectionReason.hashCode;
  }
}

class VehicleDetails {
  final VehicleType vehicleType;
  final int maxLoadWeight;
  final int maxLoadVolume;
  final List<MaterialType> materialCompatibility;
  final String plateNumber;
  final String vehicleColor;
  final DateTime registrationExpiryDate;
  final DateTime insuranceExpiryDate;
  final List<VehicleDocument> documents;
  final FuelType fuelType;
  final VehicleStatus status;
  final bool isActive;
  final bool isUnderMaintenance;
  final bool isEnterpriseEligible;
  final DateTime updatedAt;
  final DateTime? approvedAt;
  final String? approvedBy;
  final String? rejectionReason;

  const VehicleDetails({
    required this.vehicleType,
    required this.maxLoadWeight,
    required this.maxLoadVolume,
    required this.materialCompatibility,
    required this.plateNumber,
    required this.vehicleColor,
    required this.registrationExpiryDate,
    required this.insuranceExpiryDate,
    required this.documents,
    required this.fuelType,
    required this.status,
    required this.isActive,
    required this.isUnderMaintenance,
    required this.isEnterpriseEligible,
    required this.updatedAt,
    this.approvedAt,
    this.approvedBy,
    this.rejectionReason,
  });

  factory VehicleDetails.fromJson(Map<String, dynamic> json) {
    return VehicleDetails(
      vehicleType: VehicleType.fromString(json['vehicleType'] as String),
      maxLoadWeight: json['maxLoadWeight'] as int,
      maxLoadVolume: json['maxLoadVolume'] as int? ?? 0,
      materialCompatibility: (json['materialCompatibility'] as List<dynamic>?)
          ?.map((type) => MaterialType.fromString(type as String))
          .toList() ?? [],
      plateNumber: json['plateNumber'] as String,
      vehicleColor: json['vehicleColor'] as String,
      registrationExpiryDate: DateTime.parse(json['registrationExpiryDate'] as String),
      insuranceExpiryDate: DateTime.parse(json['insuranceExpiryDate'] as String),
      documents: (json['documents'] as List<dynamic>?)
          ?.map((doc) => VehicleDocument.fromJson(doc as Map<String, dynamic>))
          .toList() ?? [],
      fuelType: FuelType.fromString(json['fuelType'] as String),
      status: VehicleStatus.fromString(json['status'] as String),
      isActive: json['isActive'] as bool,
      isUnderMaintenance: json['isUnderMaintenance'] as bool,
      isEnterpriseEligible: json['isEnterpriseEligible'] as bool,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      approvedAt: json['approvedAt'] != null 
          ? DateTime.parse(json['approvedAt'] as String) 
          : null,
      approvedBy: json['approvedBy'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleType': vehicleType.toJson(),
      'maxLoadWeight': maxLoadWeight,
      'maxLoadVolume': maxLoadVolume,
      'materialCompatibility': materialCompatibility.map((m) => m.toJson()).toList(),
      'plateNumber': plateNumber,
      'vehicleColor': vehicleColor,
      'registrationExpiryDate': registrationExpiryDate.toIso8601String(),
      'insuranceExpiryDate': insuranceExpiryDate.toIso8601String(),
      'documents': documents.map((doc) => doc.toJson()).toList(),
      'fuelType': fuelType.toJson(),
      'status': status.toJson(),
      'isActive': isActive,
      'isUnderMaintenance': isUnderMaintenance,
      'isEnterpriseEligible': isEnterpriseEligible,
      'updatedAt': updatedAt.toIso8601String(),
      if (approvedAt != null) 'approvedAt': approvedAt!.toIso8601String(),
      if (approvedBy != null) 'approvedBy': approvedBy,
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
    };
  }

  VehicleDetails copyWith({
    VehicleType? vehicleType,
    int? maxLoadWeight,
    int? maxLoadVolume,
    List<MaterialType>? materialCompatibility,
    String? plateNumber,
    String? vehicleColor,
    DateTime? registrationExpiryDate,
    DateTime? insuranceExpiryDate,
    List<VehicleDocument>? documents,
    FuelType? fuelType,
    VehicleStatus? status,
    bool? isActive,
    bool? isUnderMaintenance,
    bool? isEnterpriseEligible,
    DateTime? updatedAt,
    DateTime? approvedAt,
    String? approvedBy,
    String? rejectionReason,
  }) {
    return VehicleDetails(
      vehicleType: vehicleType ?? this.vehicleType,
      maxLoadWeight: maxLoadWeight ?? this.maxLoadWeight,
      maxLoadVolume: maxLoadVolume ?? this.maxLoadVolume,
      materialCompatibility: materialCompatibility ?? this.materialCompatibility,
      plateNumber: plateNumber ?? this.plateNumber,
      vehicleColor: vehicleColor ?? this.vehicleColor,
      registrationExpiryDate: registrationExpiryDate ?? this.registrationExpiryDate,
      insuranceExpiryDate: insuranceExpiryDate ?? this.insuranceExpiryDate,
      documents: documents ?? this.documents,
      fuelType: fuelType ?? this.fuelType,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      isUnderMaintenance: isUnderMaintenance ?? this.isUnderMaintenance,
      isEnterpriseEligible: isEnterpriseEligible ?? this.isEnterpriseEligible,
      updatedAt: updatedAt ?? this.updatedAt,
      approvedAt: approvedAt ?? this.approvedAt,
      approvedBy: approvedBy ?? this.approvedBy,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VehicleDetails &&
        other.vehicleType == vehicleType &&
        other.maxLoadWeight == maxLoadWeight &&
        other.maxLoadVolume == maxLoadVolume &&
        other.plateNumber == plateNumber &&
        other.vehicleColor == vehicleColor &&
        other.registrationExpiryDate == registrationExpiryDate &&
        other.insuranceExpiryDate == insuranceExpiryDate &&
        other.fuelType == fuelType &&
        other.isActive == isActive &&
        other.isUnderMaintenance == isUnderMaintenance &&
        other.isEnterpriseEligible == isEnterpriseEligible &&
        other.updatedAt == updatedAt &&
        other.approvedAt == approvedAt &&
        other.approvedBy == approvedBy &&
        other.rejectionReason == rejectionReason;
  }

  @override
  int get hashCode {
    return vehicleType.hashCode ^
        maxLoadWeight.hashCode ^
        maxLoadVolume.hashCode ^
        plateNumber.hashCode ^
        vehicleColor.hashCode ^
        registrationExpiryDate.hashCode ^
        insuranceExpiryDate.hashCode ^
        fuelType.hashCode ^
        isActive.hashCode ^
        isUnderMaintenance.hashCode ^
        isEnterpriseEligible.hashCode ^
        updatedAt.hashCode ^
        approvedAt.hashCode ^
        approvedBy.hashCode ^
        rejectionReason.hashCode;
  }
}

class CreateVehicleRequest {
  final VehicleType vehicleType;
  final int maxLoadWeight;
  final int maxLoadVolume;
  final List<MaterialType> materialCompatibility;
  final String plateNumber;
  final String vehicleColor;
  final DateTime registrationExpiryDate;
  final DateTime insuranceExpiryDate;
  final FuelType fuelType;

  const CreateVehicleRequest({
    required this.vehicleType,
    required this.maxLoadWeight,
    required this.maxLoadVolume,
    required this.materialCompatibility,
    required this.plateNumber,
    required this.vehicleColor,
    required this.registrationExpiryDate,
    required this.insuranceExpiryDate,
    required this.fuelType,
  });

  Map<String, dynamic> toJson() {
    return {
      'vehicleType': vehicleType.toJson(),
      'maxLoadWeight': maxLoadWeight,
      'maxLoadVolume': maxLoadVolume,
      'materialCompatibility': materialCompatibility.map((m) => m.toJson()).toList(),
      'plateNumber': plateNumber,
      'vehicleColor': vehicleColor,
      'registrationExpiryDate': registrationExpiryDate.toIso8601String().split('T')[0],
      'insuranceExpiryDate': insuranceExpiryDate.toIso8601String().split('T')[0],
      'fuelType': fuelType.toJson(),
    };
  }
}

class UpdateVehicleRequest {
  final VehicleType? vehicleType;
  final int? maxLoadWeight;
  final int? maxLoadVolume;
  final List<MaterialType>? materialCompatibility;
  final String? plateNumber;
  final String? vehicleColor;
  final DateTime? registrationExpiryDate;
  final DateTime? insuranceExpiryDate;
  final FuelType? fuelType;

  const UpdateVehicleRequest({
    this.vehicleType,
    this.maxLoadWeight,
    this.maxLoadVolume,
    this.materialCompatibility,
    this.plateNumber,
    this.vehicleColor,
    this.registrationExpiryDate,
    this.insuranceExpiryDate,
    this.fuelType,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    
    if (vehicleType != null) data['vehicleType'] = vehicleType!.toJson();
    if (maxLoadWeight != null) data['maxLoadWeight'] = maxLoadWeight;
    if (maxLoadVolume != null) data['maxLoadVolume'] = maxLoadVolume;
    if (materialCompatibility != null) {
      data['materialCompatibility'] = materialCompatibility!.map((m) => m.toJson()).toList();
    }
    if (plateNumber != null) data['plateNumber'] = plateNumber;
    if (vehicleColor != null) data['vehicleColor'] = vehicleColor;
    if (registrationExpiryDate != null) {
      data['registrationExpiryDate'] = registrationExpiryDate!.toIso8601String().split('T')[0];
    }
    if (insuranceExpiryDate != null) {
      data['insuranceExpiryDate'] = insuranceExpiryDate!.toIso8601String().split('T')[0];
    }
    if (fuelType != null) data['fuelType'] = fuelType!.toJson();
    
    return data;
  }
}

class UpdateVehicleStatusRequest {
  final bool? isActive;
  final bool? isUnderMaintenance;

  const UpdateVehicleStatusRequest({
    this.isActive,
    this.isUnderMaintenance,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    
    if (isActive != null) data['isActive'] = isActive;
    if (isUnderMaintenance != null) data['isUnderMaintenance'] = isUnderMaintenance;
    
    return data;
  }
}
