// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String? get id => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  String? get adminSubRole => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  bool get biometricEnabled => throw _privateConstructorUsedError;
  String? get profilePhoto => throw _privateConstructorUsedError;
  String? get referralCode => throw _privateConstructorUsedError;
  UserLocation? get location => throw _privateConstructorUsedError;
  UserNotifications? get notifications => throw _privateConstructorUsedError;
  String? get pin => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? role,
    String? adminSubRole,
    bool isVerified,
    bool biometricEnabled,
    String? profilePhoto,
    String? referralCode,
    UserLocation? location,
    UserNotifications? notifications,
    String? pin,
    String? createdAt,
    String? updatedAt,
  });

  $UserLocationCopyWith<$Res>? get location;
  $UserNotificationsCopyWith<$Res>? get notifications;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? phone = freezed,
    Object? role = freezed,
    Object? adminSubRole = freezed,
    Object? isVerified = null,
    Object? biometricEnabled = null,
    Object? profilePhoto = freezed,
    Object? referralCode = freezed,
    Object? location = freezed,
    Object? notifications = freezed,
    Object? pin = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            adminSubRole: freezed == adminSubRole
                ? _value.adminSubRole
                : adminSubRole // ignore: cast_nullable_to_non_nullable
                      as String?,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            biometricEnabled: null == biometricEnabled
                ? _value.biometricEnabled
                : biometricEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            profilePhoto: freezed == profilePhoto
                ? _value.profilePhoto
                : profilePhoto // ignore: cast_nullable_to_non_nullable
                      as String?,
            referralCode: freezed == referralCode
                ? _value.referralCode
                : referralCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as UserLocation?,
            notifications: freezed == notifications
                ? _value.notifications
                : notifications // ignore: cast_nullable_to_non_nullable
                      as UserNotifications?,
            pin: freezed == pin
                ? _value.pin
                : pin // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserLocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $UserLocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserNotificationsCopyWith<$Res>? get notifications {
    if (_value.notifications == null) {
      return null;
    }

    return $UserNotificationsCopyWith<$Res>(_value.notifications!, (value) {
      return _then(_value.copyWith(notifications: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? role,
    String? adminSubRole,
    bool isVerified,
    bool biometricEnabled,
    String? profilePhoto,
    String? referralCode,
    UserLocation? location,
    UserNotifications? notifications,
    String? pin,
    String? createdAt,
    String? updatedAt,
  });

  @override
  $UserLocationCopyWith<$Res>? get location;
  @override
  $UserNotificationsCopyWith<$Res>? get notifications;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? phone = freezed,
    Object? role = freezed,
    Object? adminSubRole = freezed,
    Object? isVerified = null,
    Object? biometricEnabled = null,
    Object? profilePhoto = freezed,
    Object? referralCode = freezed,
    Object? location = freezed,
    Object? notifications = freezed,
    Object? pin = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$UserImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        adminSubRole: freezed == adminSubRole
            ? _value.adminSubRole
            : adminSubRole // ignore: cast_nullable_to_non_nullable
                  as String?,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        biometricEnabled: null == biometricEnabled
            ? _value.biometricEnabled
            : biometricEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        profilePhoto: freezed == profilePhoto
            ? _value.profilePhoto
            : profilePhoto // ignore: cast_nullable_to_non_nullable
                  as String?,
        referralCode: freezed == referralCode
            ? _value.referralCode
            : referralCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as UserLocation?,
        notifications: freezed == notifications
            ? _value.notifications
            : notifications // ignore: cast_nullable_to_non_nullable
                  as UserNotifications?,
        pin: freezed == pin
            ? _value.pin
            : pin // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.role,
    this.adminSubRole,
    this.isVerified = false,
    this.biometricEnabled = false,
    this.profilePhoto,
    this.referralCode,
    this.location,
    this.notifications,
    this.pin,
    this.createdAt,
    this.updatedAt,
  });

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String? id;
  @override
  final String? email;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final String? role;
  @override
  final String? adminSubRole;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  @JsonKey()
  final bool biometricEnabled;
  @override
  final String? profilePhoto;
  @override
  final String? referralCode;
  @override
  final UserLocation? location;
  @override
  final UserNotifications? notifications;
  @override
  final String? pin;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, phone: $phone, role: $role, adminSubRole: $adminSubRole, isVerified: $isVerified, biometricEnabled: $biometricEnabled, profilePhoto: $profilePhoto, referralCode: $referralCode, location: $location, notifications: $notifications, pin: $pin, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.adminSubRole, adminSubRole) ||
                other.adminSubRole == adminSubRole) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.biometricEnabled, biometricEnabled) ||
                other.biometricEnabled == biometricEnabled) &&
            (identical(other.profilePhoto, profilePhoto) ||
                other.profilePhoto == profilePhoto) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.notifications, notifications) ||
                other.notifications == notifications) &&
            (identical(other.pin, pin) || other.pin == pin) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    name,
    phone,
    role,
    adminSubRole,
    isVerified,
    biometricEnabled,
    profilePhoto,
    referralCode,
    location,
    notifications,
    pin,
    createdAt,
    updatedAt,
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(this);
  }
}

abstract class _User implements User {
  const factory _User({
    final String? id,
    final String? email,
    final String? name,
    final String? phone,
    final String? role,
    final String? adminSubRole,
    final bool isVerified,
    final bool biometricEnabled,
    final String? profilePhoto,
    final String? referralCode,
    final UserLocation? location,
    final UserNotifications? notifications,
    final String? pin,
    final String? createdAt,
    final String? updatedAt,
  }) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String? get id;
  @override
  String? get email;
  @override
  String? get name;
  @override
  String? get phone;
  @override
  String? get role;
  @override
  String? get adminSubRole;
  @override
  bool get isVerified;
  @override
  bool get biometricEnabled;
  @override
  String? get profilePhoto;
  @override
  String? get referralCode;
  @override
  UserLocation? get location;
  @override
  UserNotifications? get notifications;
  @override
  String? get pin;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserLocation _$UserLocationFromJson(Map<String, dynamic> json) {
  return _UserLocation.fromJson(json);
}

/// @nodoc
mixin _$UserLocation {
  String get type => throw _privateConstructorUsedError;
  List<double>? get coordinates => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;

  /// Serializes this UserLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserLocationCopyWith<UserLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLocationCopyWith<$Res> {
  factory $UserLocationCopyWith(
    UserLocation value,
    $Res Function(UserLocation) then,
  ) = _$UserLocationCopyWithImpl<$Res, UserLocation>;
  @useResult
  $Res call({
    String type,
    List<double>? coordinates,
    String? address,
    String? city,
    String? state,
    String? country,
  });
}

/// @nodoc
class _$UserLocationCopyWithImpl<$Res, $Val extends UserLocation>
    implements $UserLocationCopyWith<$Res> {
  _$UserLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? coordinates = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            coordinates: freezed == coordinates
                ? _value.coordinates
                : coordinates // ignore: cast_nullable_to_non_nullable
                      as List<double>?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            state: freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String?,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserLocationImplCopyWith<$Res>
    implements $UserLocationCopyWith<$Res> {
  factory _$$UserLocationImplCopyWith(
    _$UserLocationImpl value,
    $Res Function(_$UserLocationImpl) then,
  ) = __$$UserLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    List<double>? coordinates,
    String? address,
    String? city,
    String? state,
    String? country,
  });
}

/// @nodoc
class __$$UserLocationImplCopyWithImpl<$Res>
    extends _$UserLocationCopyWithImpl<$Res, _$UserLocationImpl>
    implements _$$UserLocationImplCopyWith<$Res> {
  __$$UserLocationImplCopyWithImpl(
    _$UserLocationImpl _value,
    $Res Function(_$UserLocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? coordinates = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
  }) {
    return _then(
      _$UserLocationImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        coordinates: freezed == coordinates
            ? _value._coordinates
            : coordinates // ignore: cast_nullable_to_non_nullable
                  as List<double>?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        state: freezed == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String?,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserLocationImpl implements _UserLocation {
  const _$UserLocationImpl({
    this.type = 'Point',
    final List<double>? coordinates,
    this.address,
    this.city,
    this.state,
    this.country,
  }) : _coordinates = coordinates;

  factory _$UserLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserLocationImplFromJson(json);

  @override
  @JsonKey()
  final String type;
  final List<double>? _coordinates;
  @override
  List<double>? get coordinates {
    final value = _coordinates;
    if (value == null) return null;
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? address;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? country;

  @override
  String toString() {
    return 'UserLocation(type: $type, coordinates: $coordinates, address: $address, city: $city, state: $state, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserLocationImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other._coordinates,
              _coordinates,
            ) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    const DeepCollectionEquality().hash(_coordinates),
    address,
    city,
    state,
    country,
  );

  /// Create a copy of UserLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserLocationImplCopyWith<_$UserLocationImpl> get copyWith =>
      __$$UserLocationImplCopyWithImpl<_$UserLocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserLocationImplToJson(this);
  }
}

abstract class _UserLocation implements UserLocation {
  const factory _UserLocation({
    final String type,
    final List<double>? coordinates,
    final String? address,
    final String? city,
    final String? state,
    final String? country,
  }) = _$UserLocationImpl;

  factory _UserLocation.fromJson(Map<String, dynamic> json) =
      _$UserLocationImpl.fromJson;

  @override
  String get type;
  @override
  List<double>? get coordinates;
  @override
  String? get address;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get country;

  /// Create a copy of UserLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserLocationImplCopyWith<_$UserLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserNotifications _$UserNotificationsFromJson(Map<String, dynamic> json) {
  return _UserNotifications.fromJson(json);
}

/// @nodoc
mixin _$UserNotifications {
  bool get priceUpdates => throw _privateConstructorUsedError;
  bool get loginEmails => throw _privateConstructorUsedError;

  /// Serializes this UserNotifications to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserNotifications
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserNotificationsCopyWith<UserNotifications> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNotificationsCopyWith<$Res> {
  factory $UserNotificationsCopyWith(
    UserNotifications value,
    $Res Function(UserNotifications) then,
  ) = _$UserNotificationsCopyWithImpl<$Res, UserNotifications>;
  @useResult
  $Res call({bool priceUpdates, bool loginEmails});
}

/// @nodoc
class _$UserNotificationsCopyWithImpl<$Res, $Val extends UserNotifications>
    implements $UserNotificationsCopyWith<$Res> {
  _$UserNotificationsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserNotifications
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? priceUpdates = null, Object? loginEmails = null}) {
    return _then(
      _value.copyWith(
            priceUpdates: null == priceUpdates
                ? _value.priceUpdates
                : priceUpdates // ignore: cast_nullable_to_non_nullable
                      as bool,
            loginEmails: null == loginEmails
                ? _value.loginEmails
                : loginEmails // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserNotificationsImplCopyWith<$Res>
    implements $UserNotificationsCopyWith<$Res> {
  factory _$$UserNotificationsImplCopyWith(
    _$UserNotificationsImpl value,
    $Res Function(_$UserNotificationsImpl) then,
  ) = __$$UserNotificationsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool priceUpdates, bool loginEmails});
}

/// @nodoc
class __$$UserNotificationsImplCopyWithImpl<$Res>
    extends _$UserNotificationsCopyWithImpl<$Res, _$UserNotificationsImpl>
    implements _$$UserNotificationsImplCopyWith<$Res> {
  __$$UserNotificationsImplCopyWithImpl(
    _$UserNotificationsImpl _value,
    $Res Function(_$UserNotificationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserNotifications
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? priceUpdates = null, Object? loginEmails = null}) {
    return _then(
      _$UserNotificationsImpl(
        priceUpdates: null == priceUpdates
            ? _value.priceUpdates
            : priceUpdates // ignore: cast_nullable_to_non_nullable
                  as bool,
        loginEmails: null == loginEmails
            ? _value.loginEmails
            : loginEmails // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserNotificationsImpl implements _UserNotifications {
  const _$UserNotificationsImpl({
    this.priceUpdates = true,
    this.loginEmails = true,
  });

  factory _$UserNotificationsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserNotificationsImplFromJson(json);

  @override
  @JsonKey()
  final bool priceUpdates;
  @override
  @JsonKey()
  final bool loginEmails;

  @override
  String toString() {
    return 'UserNotifications(priceUpdates: $priceUpdates, loginEmails: $loginEmails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserNotificationsImpl &&
            (identical(other.priceUpdates, priceUpdates) ||
                other.priceUpdates == priceUpdates) &&
            (identical(other.loginEmails, loginEmails) ||
                other.loginEmails == loginEmails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, priceUpdates, loginEmails);

  /// Create a copy of UserNotifications
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserNotificationsImplCopyWith<_$UserNotificationsImpl> get copyWith =>
      __$$UserNotificationsImplCopyWithImpl<_$UserNotificationsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserNotificationsImplToJson(this);
  }
}

abstract class _UserNotifications implements UserNotifications {
  const factory _UserNotifications({
    final bool priceUpdates,
    final bool loginEmails,
  }) = _$UserNotificationsImpl;

  factory _UserNotifications.fromJson(Map<String, dynamic> json) =
      _$UserNotificationsImpl.fromJson;

  @override
  bool get priceUpdates;
  @override
  bool get loginEmails;

  /// Create a copy of UserNotifications
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserNotificationsImplCopyWith<_$UserNotificationsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
