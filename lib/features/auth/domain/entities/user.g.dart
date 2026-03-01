// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String?,
  email: json['email'] as String?,
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  role: json['role'] as String?,
  adminSubRole: json['adminSubRole'] as String?,
  isVerified: json['isVerified'] as bool? ?? false,
  biometricEnabled: json['biometricEnabled'] as bool? ?? false,
  profilePhoto: json['profilePhoto'] as String?,
  referralCode: json['referralCode'] as String?,
  location: json['location'] == null
      ? null
      : UserLocation.fromJson(json['location'] as Map<String, dynamic>),
  notifications: json['notifications'] == null
      ? null
      : UserNotifications.fromJson(
          json['notifications'] as Map<String, dynamic>,
        ),
  pin: json['pin'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'role': instance.role,
      'adminSubRole': instance.adminSubRole,
      'isVerified': instance.isVerified,
      'biometricEnabled': instance.biometricEnabled,
      'profilePhoto': instance.profilePhoto,
      'referralCode': instance.referralCode,
      'location': instance.location,
      'notifications': instance.notifications,
      'pin': instance.pin,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_$UserLocationImpl _$$UserLocationImplFromJson(Map<String, dynamic> json) =>
    _$UserLocationImpl(
      type: json['type'] as String? ?? 'Point',
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$$UserLocationImplToJson(_$UserLocationImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
    };

_$UserNotificationsImpl _$$UserNotificationsImplFromJson(
  Map<String, dynamic> json,
) => _$UserNotificationsImpl(
  priceUpdates: json['priceUpdates'] as bool? ?? true,
  loginEmails: json['loginEmails'] as bool? ?? true,
);

Map<String, dynamic> _$$UserNotificationsImplToJson(
  _$UserNotificationsImpl instance,
) => <String, dynamic>{
  'priceUpdates': instance.priceUpdates,
  'loginEmails': instance.loginEmails,
};
