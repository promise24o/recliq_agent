class TimeSlot {
  final String startTime;
  final String endTime;

  const TimeSlot({
    required this.startTime,
    required this.endTime,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  TimeSlot copyWith({
    String? startTime,
    String? endTime,
  }) {
    return TimeSlot(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimeSlot &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode;
}

class DaySchedule {
  final bool enabled;
  final List<TimeSlot> timeSlots;

  const DaySchedule({
    required this.enabled,
    required this.timeSlots,
  });

  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    return DaySchedule(
      enabled: json['enabled'] as bool,
      timeSlots: (json['timeSlots'] as List<dynamic>?)
              ?.map((slot) => TimeSlot.fromJson(slot as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'timeSlots': timeSlots.map((slot) => slot.toJson()).toList(),
    };
  }

  DaySchedule copyWith({
    bool? enabled,
    List<TimeSlot>? timeSlots,
  }) {
    return DaySchedule(
      enabled: enabled ?? this.enabled,
      timeSlots: timeSlots ?? this.timeSlots,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DaySchedule &&
        other.enabled == enabled &&
        other.timeSlots.length == timeSlots.length;
  }

  @override
  int get hashCode => enabled.hashCode ^ timeSlots.hashCode;
}

class WeeklySchedule {
  final DaySchedule monday;
  final DaySchedule tuesday;
  final DaySchedule wednesday;
  final DaySchedule thursday;
  final DaySchedule friday;
  final DaySchedule saturday;
  final DaySchedule sunday;

  const WeeklySchedule({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory WeeklySchedule.fromJson(Map<String, dynamic> json) {
    return WeeklySchedule(
      monday: DaySchedule.fromJson(json['monday'] as Map<String, dynamic>),
      tuesday: DaySchedule.fromJson(json['tuesday'] as Map<String, dynamic>),
      wednesday: DaySchedule.fromJson(json['wednesday'] as Map<String, dynamic>),
      thursday: DaySchedule.fromJson(json['thursday'] as Map<String, dynamic>),
      friday: DaySchedule.fromJson(json['friday'] as Map<String, dynamic>),
      saturday: DaySchedule.fromJson(json['saturday'] as Map<String, dynamic>),
      sunday: DaySchedule.fromJson(json['sunday'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monday': monday.toJson(),
      'tuesday': tuesday.toJson(),
      'wednesday': wednesday.toJson(),
      'thursday': thursday.toJson(),
      'friday': friday.toJson(),
      'saturday': saturday.toJson(),
      'sunday': sunday.toJson(),
    };
  }

  DaySchedule getDay(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return monday;
      case 'tuesday':
        return tuesday;
      case 'wednesday':
        return wednesday;
      case 'thursday':
        return thursday;
      case 'friday':
        return friday;
      case 'saturday':
        return saturday;
      case 'sunday':
        return sunday;
      default:
        throw ArgumentError('Invalid day: $day');
    }
  }

  WeeklySchedule updateDay(String day, DaySchedule schedule) {
    switch (day.toLowerCase()) {
      case 'monday':
        return copyWith(monday: schedule);
      case 'tuesday':
        return copyWith(tuesday: schedule);
      case 'wednesday':
        return copyWith(wednesday: schedule);
      case 'thursday':
        return copyWith(thursday: schedule);
      case 'friday':
        return copyWith(friday: schedule);
      case 'saturday':
        return copyWith(saturday: schedule);
      case 'sunday':
        return copyWith(sunday: schedule);
      default:
        throw ArgumentError('Invalid day: $day');
    }
  }

  WeeklySchedule copyWith({
    DaySchedule? monday,
    DaySchedule? tuesday,
    DaySchedule? wednesday,
    DaySchedule? thursday,
    DaySchedule? friday,
    DaySchedule? saturday,
    DaySchedule? sunday,
  }) {
    return WeeklySchedule(
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      sunday: sunday ?? this.sunday,
    );
  }
}

class AvailabilityInsights {
  final double avgWeeklyEarnings;
  final String peakHoursStart;
  final String peakHoursEnd;
  final double totalHoursPerWeek;
  final DateTime lastUpdated;

  const AvailabilityInsights({
    required this.avgWeeklyEarnings,
    required this.peakHoursStart,
    required this.peakHoursEnd,
    required this.totalHoursPerWeek,
    required this.lastUpdated,
  });

  factory AvailabilityInsights.fromJson(Map<String, dynamic> json) {
    return AvailabilityInsights(
      avgWeeklyEarnings: (json['avgWeeklyEarnings'] as num).toDouble(),
      peakHoursStart: json['peakHoursStart'] as String,
      peakHoursEnd: json['peakHoursEnd'] as String,
      totalHoursPerWeek: (json['totalHoursPerWeek'] as num).toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avgWeeklyEarnings': avgWeeklyEarnings,
      'peakHoursStart': peakHoursStart,
      'peakHoursEnd': peakHoursEnd,
      'totalHoursPerWeek': totalHoursPerWeek,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class AgentAvailability {
  final bool isOnline;
  final WeeklySchedule weeklySchedule;
  final bool availableForEnterpriseJobs;
  final bool autoGoOnlineDuringSchedule;
  final AvailabilityInsights? insights;
  final DateTime updatedAt;

  const AgentAvailability({
    required this.isOnline,
    required this.weeklySchedule,
    required this.availableForEnterpriseJobs,
    required this.autoGoOnlineDuringSchedule,
    this.insights,
    required this.updatedAt,
  });

  factory AgentAvailability.fromJson(Map<String, dynamic> json) {
    return AgentAvailability(
      isOnline: json['isOnline'] as bool,
      weeklySchedule: WeeklySchedule.fromJson(json['weeklySchedule'] as Map<String, dynamic>),
      availableForEnterpriseJobs: json['availableForEnterpriseJobs'] as bool,
      autoGoOnlineDuringSchedule: json['autoGoOnlineDuringSchedule'] as bool,
      insights: json['insights'] != null
          ? AvailabilityInsights.fromJson(json['insights'] as Map<String, dynamic>)
          : null,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isOnline': isOnline,
      'weeklySchedule': weeklySchedule.toJson(),
      'availableForEnterpriseJobs': availableForEnterpriseJobs,
      'autoGoOnlineDuringSchedule': autoGoOnlineDuringSchedule,
      if (insights != null) 'insights': insights!.toJson(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  AgentAvailability copyWith({
    bool? isOnline,
    WeeklySchedule? weeklySchedule,
    bool? availableForEnterpriseJobs,
    bool? autoGoOnlineDuringSchedule,
    AvailabilityInsights? insights,
    DateTime? updatedAt,
  }) {
    return AgentAvailability(
      isOnline: isOnline ?? this.isOnline,
      weeklySchedule: weeklySchedule ?? this.weeklySchedule,
      availableForEnterpriseJobs: availableForEnterpriseJobs ?? this.availableForEnterpriseJobs,
      autoGoOnlineDuringSchedule: autoGoOnlineDuringSchedule ?? this.autoGoOnlineDuringSchedule,
      insights: insights ?? this.insights,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
