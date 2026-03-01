import 'package:equatable/equatable.dart';

enum ActionType {
  login,
  agentAction,
  userAction,
  financeAction,
  zoneAction,
  sensitiveView,
  passwordChange,
}

enum RiskLevel {
  low,
  medium,
  high,
}

enum Source {
  web,
  mobile,
  api,
}

enum Outcome {
  success,
  failed,
  pending,
}

enum EntityType {
  vehicleDetails,
  agentAvailability,
  serviceRadius,
  user,
  finance,
  zone,
  system,
}

class ActivityLog extends Equatable {
  final String id;
  final ActionType action;
  final RiskLevel riskLevel;
  final Source source;
  final Outcome outcome;
  final EntityType entityType;
  final String entityName;
  final String description;
  final DateTime timestamp;
  final String? ipAddress;
  final String? userAgent;
  final Map<String, dynamic>? metadata;

  const ActivityLog({
    required this.id,
    required this.action,
    required this.riskLevel,
    required this.source,
    required this.outcome,
    required this.entityType,
    required this.entityName,
    required this.description,
    required this.timestamp,
    this.ipAddress,
    this.userAgent,
    this.metadata,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      id: json['id'] as String,
      action: _parseActionType(json['action'] as String?),
      riskLevel: _parseRiskLevel(json['riskLevel'] as String?),
      source: _parseSource(json['source'] as String?),
      outcome: _parseOutcome(json['outcome'] as String?),
      entityType: _parseEntityType(json['entityType'] as String?),
      entityName: json['entityName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      timestamp: DateTime.parse(json['timestamp'] as String),
      ipAddress: json['ipAddress'] as String?,
      userAgent: json['device'] as String?, // API uses 'device' field
      metadata: _buildMetadata(json),
    );
  }

  static ActionType _parseActionType(String? action) {
    switch (action) {
      case 'login':
        return ActionType.login;
      case 'agent_action':
        return ActionType.agentAction;
      case 'user_action':
        return ActionType.userAction;
      case 'finance_action':
        return ActionType.financeAction;
      case 'zone_action':
        return ActionType.zoneAction;
      case 'sensitive_view':
        return ActionType.sensitiveView;
      case 'password_change':
        return ActionType.passwordChange;
      default:
        return ActionType.userAction;
    }
  }

  static RiskLevel _parseRiskLevel(String? riskLevel) {
    switch (riskLevel) {
      case 'low':
        return RiskLevel.low;
      case 'medium':
        return RiskLevel.medium;
      case 'high':
        return RiskLevel.high;
      default:
        return RiskLevel.low;
    }
  }

  static Source _parseSource(String? source) {
    switch (source) {
      case 'web':
        return Source.web;
      case 'mobile':
        return Source.mobile;
      case 'api':
        return Source.api;
      default:
        return Source.mobile;
    }
  }

  static Outcome _parseOutcome(String? outcome) {
    switch (outcome) {
      case 'success':
        return Outcome.success;
      case 'failed':
        return Outcome.failed;
      case 'pending':
        return Outcome.pending;
      default:
        return Outcome.success;
    }
  }

  static EntityType _parseEntityType(String? entityType) {
    switch (entityType) {
      case 'Vehicle Details':
        return EntityType.vehicleDetails;
      case 'Agent Availability':
        return EntityType.agentAvailability;
      case 'Service Radius':
        return EntityType.serviceRadius;
      case 'User':
        return EntityType.user;
      case 'Finance':
        return EntityType.finance;
      case 'Zone':
        return EntityType.zone;
      case 'System':
        return EntityType.system;
      default:
        return EntityType.user;
    }
  }

  static Map<String, dynamic> _buildMetadata(Map<String, dynamic> json) {
    final metadata = <String, dynamic>{};
    
    // Add common API fields to metadata
    if (json['entityId'] != null) metadata['entityId'] = json['entityId'];
    if (json['auditRef'] != null) metadata['auditRef'] = json['auditRef'];
    if (json['location'] != null) metadata['location'] = json['location'];
    if (json['device'] != null) metadata['device'] = json['device'];
    if (json['actionLabel'] != null) metadata['actionLabel'] = json['actionLabel'];
    
    return metadata;
  }

  @override
  List<Object?> get props => [
        id,
        action,
        riskLevel,
        source,
        outcome,
        entityType,
        entityName,
        description,
        timestamp,
        ipAddress,
        userAgent,
        metadata,
      ];
}

class ActivityLogResponse extends Equatable {
  final List<ActivityLog> logs;
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  const ActivityLogResponse({
    required this.logs,
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory ActivityLogResponse.fromJson(Map<String, dynamic> json) {
    return ActivityLogResponse(
      logs: (json['events'] as List)
          .map((log) => ActivityLog.fromJson(log as Map<String, dynamic>))
          .toList(),
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 20,
      total: json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 1,
    );
  }

  @override
  List<Object?> get props => [logs, page, limit, total, totalPages];
}

// Extension methods for display names
extension ActionTypeExtension on ActionType {
  String get displayName {
    switch (this) {
      case ActionType.login:
        return 'Login/Logout';
      case ActionType.agentAction:
        return 'Agent Action';
      case ActionType.userAction:
        return 'User Action';
      case ActionType.financeAction:
        return 'Finance Action';
      case ActionType.zoneAction:
        return 'Zone Action';
      case ActionType.sensitiveView:
        return 'Sensitive View';
      case ActionType.passwordChange:
        return 'Password Change';
    }
  }
}

extension RiskLevelExtension on RiskLevel {
  String get displayName {
    switch (this) {
      case RiskLevel.low:
        return 'Low';
      case RiskLevel.medium:
        return 'Medium';
      case RiskLevel.high:
        return 'High';
    }
  }
}

extension SourceExtension on Source {
  String get displayName {
    switch (this) {
      case Source.web:
        return 'Web';
      case Source.mobile:
        return 'Mobile';
      case Source.api:
        return 'API';
    }
  }
}

extension OutcomeExtension on Outcome {
  String get displayName {
    switch (this) {
      case Outcome.success:
        return 'Success';
      case Outcome.failed:
        return 'Failed';
      case Outcome.pending:
        return 'Pending';
    }
  }
}

extension EntityTypeExtension on EntityType {
  String get displayName {
    switch (this) {
      case EntityType.vehicleDetails:
        return 'Vehicle Details';
      case EntityType.agentAvailability:
        return 'Agent Availability';
      case EntityType.serviceRadius:
        return 'Service Radius';
      case EntityType.user:
        return 'User';
      case EntityType.finance:
        return 'Finance';
      case EntityType.zone:
        return 'Zone';
      case EntityType.system:
        return 'System';
    }
  }
}
