import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? role,
    String? adminSubRole,
    @Default(false) bool isVerified,
    @Default(false) bool biometricEnabled,
    String? profilePhoto,
    String? referralCode,
    UserLocation? location,
    UserNotifications? notifications,
    String? pin,
    String? createdAt,
    String? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

extension UserExtension on User {
  bool get hasPin => pin != null && pin!.isNotEmpty;
}

@freezed
class UserLocation with _$UserLocation {
  const factory UserLocation({
    @Default('Point') String type,
    List<double>? coordinates,
    String? address,
    String? city,
    String? state,
    String? country,
  }) = _UserLocation;

  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);
}

@freezed
class UserNotifications with _$UserNotifications {
  const factory UserNotifications({
    @Default(true) bool priceUpdates,
    @Default(true) bool loginEmails,
  }) = _UserNotifications;

  factory UserNotifications.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationsFromJson(json);
}
