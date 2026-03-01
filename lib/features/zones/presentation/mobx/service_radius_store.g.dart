// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_radius_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServiceRadiusStore on _ServiceRadiusStore, Store {
  late final _$isLoadingAtom = Atom(
    name: '_ServiceRadiusStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_ServiceRadiusStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$successMessageAtom = Atom(
    name: '_ServiceRadiusStore.successMessage',
    context: context,
  );

  @override
  String? get successMessage {
    _$successMessageAtom.reportRead();
    return super.successMessage;
  }

  @override
  set successMessage(String? value) {
    _$successMessageAtom.reportWrite(value, super.successMessage, () {
      super.successMessage = value;
    });
  }

  late final _$citiesAtom = Atom(
    name: '_ServiceRadiusStore.cities',
    context: context,
  );

  @override
  List<City> get cities {
    _$citiesAtom.reportRead();
    return super.cities;
  }

  @override
  set cities(List<City> value) {
    _$citiesAtom.reportWrite(value, super.cities, () {
      super.cities = value;
    });
  }

  late final _$zonesAtom = Atom(
    name: '_ServiceRadiusStore.zones',
    context: context,
  );

  @override
  List<Zone> get zones {
    _$zonesAtom.reportRead();
    return super.zones;
  }

  @override
  set zones(List<Zone> value) {
    _$zonesAtom.reportWrite(value, super.zones, () {
      super.zones = value;
    });
  }

  late final _$serviceRadiusAtom = Atom(
    name: '_ServiceRadiusStore.serviceRadius',
    context: context,
  );

  @override
  ServiceRadius? get serviceRadius {
    _$serviceRadiusAtom.reportRead();
    return super.serviceRadius;
  }

  @override
  set serviceRadius(ServiceRadius? value) {
    _$serviceRadiusAtom.reportWrite(value, super.serviceRadius, () {
      super.serviceRadius = value;
    });
  }

  late final _$currentRadiusAtom = Atom(
    name: '_ServiceRadiusStore.currentRadius',
    context: context,
  );

  @override
  double get currentRadius {
    _$currentRadiusAtom.reportRead();
    return super.currentRadius;
  }

  @override
  set currentRadius(double value) {
    _$currentRadiusAtom.reportWrite(value, super.currentRadius, () {
      super.currentRadius = value;
    });
  }

  late final _$autoExpandRadiusAtom = Atom(
    name: '_ServiceRadiusStore.autoExpandRadius',
    context: context,
  );

  @override
  bool get autoExpandRadius {
    _$autoExpandRadiusAtom.reportRead();
    return super.autoExpandRadius;
  }

  @override
  set autoExpandRadius(bool value) {
    _$autoExpandRadiusAtom.reportWrite(value, super.autoExpandRadius, () {
      super.autoExpandRadius = value;
    });
  }

  late final _$restrictDuringPeakHoursAtom = Atom(
    name: '_ServiceRadiusStore.restrictDuringPeakHours',
    context: context,
  );

  @override
  bool get restrictDuringPeakHours {
    _$restrictDuringPeakHoursAtom.reportRead();
    return super.restrictDuringPeakHours;
  }

  @override
  set restrictDuringPeakHours(bool value) {
    _$restrictDuringPeakHoursAtom.reportWrite(
      value,
      super.restrictDuringPeakHours,
      () {
        super.restrictDuringPeakHours = value;
      },
    );
  }

  late final _$selectedZoneIdsAtom = Atom(
    name: '_ServiceRadiusStore.selectedZoneIds',
    context: context,
  );

  @override
  ObservableSet<String> get selectedZoneIds {
    _$selectedZoneIdsAtom.reportRead();
    return super.selectedZoneIds;
  }

  @override
  set selectedZoneIds(ObservableSet<String> value) {
    _$selectedZoneIdsAtom.reportWrite(value, super.selectedZoneIds, () {
      super.selectedZoneIds = value;
    });
  }

  late final _$selectedCityAtom = Atom(
    name: '_ServiceRadiusStore.selectedCity',
    context: context,
  );

  @override
  String? get selectedCity {
    _$selectedCityAtom.reportRead();
    return super.selectedCity;
  }

  @override
  set selectedCity(String? value) {
    _$selectedCityAtom.reportWrite(value, super.selectedCity, () {
      super.selectedCity = value;
    });
  }

  late final _$loadCitiesAsyncAction = AsyncAction(
    '_ServiceRadiusStore.loadCities',
    context: context,
  );

  @override
  Future<void> loadCities() {
    return _$loadCitiesAsyncAction.run(() => super.loadCities());
  }

  late final _$loadZonesAsyncAction = AsyncAction(
    '_ServiceRadiusStore.loadZones',
    context: context,
  );

  @override
  Future<void> loadZones({String? city}) {
    return _$loadZonesAsyncAction.run(() => super.loadZones(city: city));
  }

  late final _$loadServiceRadiusAsyncAction = AsyncAction(
    '_ServiceRadiusStore.loadServiceRadius',
    context: context,
  );

  @override
  Future<void> loadServiceRadius() {
    return _$loadServiceRadiusAsyncAction.run(() => super.loadServiceRadius());
  }

  late final _$updateServiceRadiusAsyncAction = AsyncAction(
    '_ServiceRadiusStore.updateServiceRadius',
    context: context,
  );

  @override
  Future<bool> updateServiceRadius() {
    return _$updateServiceRadiusAsyncAction.run(
      () => super.updateServiceRadius(),
    );
  }

  late final _$_ServiceRadiusStoreActionController = ActionController(
    name: '_ServiceRadiusStore',
    context: context,
  );

  @override
  void clearMessages() {
    final _$actionInfo = _$_ServiceRadiusStoreActionController.startAction(
      name: '_ServiceRadiusStore.clearMessages',
    );
    try {
      return super.clearMessages();
    } finally {
      _$_ServiceRadiusStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRadius(double value) {
    final _$actionInfo = _$_ServiceRadiusStoreActionController.startAction(
      name: '_ServiceRadiusStore.setRadius',
    );
    try {
      return super.setRadius(value);
    } finally {
      _$_ServiceRadiusStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAutoExpandRadius(bool value) {
    final _$actionInfo = _$_ServiceRadiusStoreActionController.startAction(
      name: '_ServiceRadiusStore.setAutoExpandRadius',
    );
    try {
      return super.setAutoExpandRadius(value);
    } finally {
      _$_ServiceRadiusStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRestrictDuringPeakHours(bool value) {
    final _$actionInfo = _$_ServiceRadiusStoreActionController.startAction(
      name: '_ServiceRadiusStore.setRestrictDuringPeakHours',
    );
    try {
      return super.setRestrictDuringPeakHours(value);
    } finally {
      _$_ServiceRadiusStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleZoneSelection(String zoneId) {
    final _$actionInfo = _$_ServiceRadiusStoreActionController.startAction(
      name: '_ServiceRadiusStore.toggleZoneSelection',
    );
    try {
      return super.toggleZoneSelection(zoneId);
    } finally {
      _$_ServiceRadiusStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCity(String? city) {
    final _$actionInfo = _$_ServiceRadiusStoreActionController.startAction(
      name: '_ServiceRadiusStore.setSelectedCity',
    );
    try {
      return super.setSelectedCity(city);
    } finally {
      _$_ServiceRadiusStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
successMessage: ${successMessage},
cities: ${cities},
zones: ${zones},
serviceRadius: ${serviceRadius},
currentRadius: ${currentRadius},
autoExpandRadius: ${autoExpandRadius},
restrictDuringPeakHours: ${restrictDuringPeakHours},
selectedZoneIds: ${selectedZoneIds},
selectedCity: ${selectedCity}
    ''';
  }
}
