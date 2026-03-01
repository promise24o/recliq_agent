// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VehicleDetailsStore on _VehicleDetailsStore, Store {
  Computed<bool>? _$hasVehicleComputed;

  @override
  bool get hasVehicle => (_$hasVehicleComputed ??= Computed<bool>(
    () => super.hasVehicle,
    name: '_VehicleDetailsStore.hasVehicle',
  )).value;
  Computed<bool>? _$canEditVehicleComputed;

  @override
  bool get canEditVehicle => (_$canEditVehicleComputed ??= Computed<bool>(
    () => super.canEditVehicle,
    name: '_VehicleDetailsStore.canEditVehicle',
  )).value;

  late final _$vehicleDetailsAtom = Atom(
    name: '_VehicleDetailsStore.vehicleDetails',
    context: context,
  );

  @override
  vehicle.VehicleDetails? get vehicleDetails {
    _$vehicleDetailsAtom.reportRead();
    return super.vehicleDetails;
  }

  @override
  set vehicleDetails(vehicle.VehicleDetails? value) {
    _$vehicleDetailsAtom.reportWrite(value, super.vehicleDetails, () {
      super.vehicleDetails = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_VehicleDetailsStore.isLoading',
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

  late final _$isSavingAtom = Atom(
    name: '_VehicleDetailsStore.isSaving',
    context: context,
  );

  @override
  bool get isSaving {
    _$isSavingAtom.reportRead();
    return super.isSaving;
  }

  @override
  set isSaving(bool value) {
    _$isSavingAtom.reportWrite(value, super.isSaving, () {
      super.isSaving = value;
    });
  }

  late final _$isCreatingAtom = Atom(
    name: '_VehicleDetailsStore.isCreating',
    context: context,
  );

  @override
  bool get isCreating {
    _$isCreatingAtom.reportRead();
    return super.isCreating;
  }

  @override
  set isCreating(bool value) {
    _$isCreatingAtom.reportWrite(value, super.isCreating, () {
      super.isCreating = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_VehicleDetailsStore.errorMessage',
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
    name: '_VehicleDetailsStore.successMessage',
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

  late final _$loadVehicleDetailsAsyncAction = AsyncAction(
    '_VehicleDetailsStore.loadVehicleDetails',
    context: context,
  );

  @override
  Future<void> loadVehicleDetails() {
    return _$loadVehicleDetailsAsyncAction.run(
      () => super.loadVehicleDetails(),
    );
  }

  late final _$createVehicleDetailsAsyncAction = AsyncAction(
    '_VehicleDetailsStore.createVehicleDetails',
    context: context,
  );

  @override
  Future<bool> createVehicleDetails(vehicle.CreateVehicleRequest request) {
    return _$createVehicleDetailsAsyncAction.run(
      () => super.createVehicleDetails(request),
    );
  }

  late final _$updateVehicleDetailsAsyncAction = AsyncAction(
    '_VehicleDetailsStore.updateVehicleDetails',
    context: context,
  );

  @override
  Future<bool> updateVehicleDetails(vehicle.UpdateVehicleRequest request) {
    return _$updateVehicleDetailsAsyncAction.run(
      () => super.updateVehicleDetails(request),
    );
  }

  late final _$updateVehicleStatusAsyncAction = AsyncAction(
    '_VehicleDetailsStore.updateVehicleStatus',
    context: context,
  );

  @override
  Future<bool> updateVehicleStatus(vehicle.UpdateVehicleStatusRequest request) {
    return _$updateVehicleStatusAsyncAction.run(
      () => super.updateVehicleStatus(request),
    );
  }

  late final _$uploadVehicleDocumentAsyncAction = AsyncAction(
    '_VehicleDetailsStore.uploadVehicleDocument',
    context: context,
  );

  @override
  Future<bool> uploadVehicleDocument({
    required String documentType,
    required File document,
  }) {
    return _$uploadVehicleDocumentAsyncAction.run(
      () => super.uploadVehicleDocument(
        documentType: documentType,
        document: document,
      ),
    );
  }

  late final _$refreshVehicleDetailsAsyncAction = AsyncAction(
    '_VehicleDetailsStore.refreshVehicleDetails',
    context: context,
  );

  @override
  Future<void> refreshVehicleDetails() {
    return _$refreshVehicleDetailsAsyncAction.run(
      () => super.refreshVehicleDetails(),
    );
  }

  late final _$_VehicleDetailsStoreActionController = ActionController(
    name: '_VehicleDetailsStore',
    context: context,
  );

  @override
  void updateVehicleType(vehicle.VehicleType type) {
    final _$actionInfo = _$_VehicleDetailsStoreActionController.startAction(
      name: '_VehicleDetailsStore.updateVehicleType',
    );
    try {
      return super.updateVehicleType(type);
    } finally {
      _$_VehicleDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateMaxLoadWeight(int weight) {
    final _$actionInfo = _$_VehicleDetailsStoreActionController.startAction(
      name: '_VehicleDetailsStore.updateMaxLoadWeight',
    );
    try {
      return super.updateMaxLoadWeight(weight);
    } finally {
      _$_VehicleDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateMaxLoadVolume(int volume) {
    final _$actionInfo = _$_VehicleDetailsStoreActionController.startAction(
      name: '_VehicleDetailsStore.updateMaxLoadVolume',
    );
    try {
      return super.updateMaxLoadVolume(volume);
    } finally {
      _$_VehicleDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateMaterialCompatibility(List<vehicle.MaterialType> materials) {
    final _$actionInfo = _$_VehicleDetailsStoreActionController.startAction(
      name: '_VehicleDetailsStore.updateMaterialCompatibility',
    );
    try {
      return super.updateMaterialCompatibility(materials);
    } finally {
      _$_VehicleDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePlateNumber(String plateNumber) {
    final _$actionInfo = _$_VehicleDetailsStoreActionController.startAction(
      name: '_VehicleDetailsStore.updatePlateNumber',
    );
    try {
      return super.updatePlateNumber(plateNumber);
    } finally {
      _$_VehicleDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateVehicleColor(String color) {
    final _$actionInfo = _$_VehicleDetailsStoreActionController.startAction(
      name: '_VehicleDetailsStore.updateVehicleColor',
    );
    try {
      return super.updateVehicleColor(color);
    } finally {
      _$_VehicleDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateRegistrationExpiryDate(DateTime date) {
    final _$actionInfo = _$_VehicleDetailsStoreActionController.startAction(
      name: '_VehicleDetailsStore.updateRegistrationExpiryDate',
    );
    try {
      return super.updateRegistrationExpiryDate(date);
    } finally {
      _$_VehicleDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateInsuranceExpiryDate(DateTime date) {
    final _$actionInfo = _$_VehicleDetailsStoreActionController.startAction(
      name: '_VehicleDetailsStore.updateInsuranceExpiryDate',
    );
    try {
      return super.updateInsuranceExpiryDate(date);
    } finally {
      _$_VehicleDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateFuelType(vehicle.FuelType fuelType) {
    final _$actionInfo = _$_VehicleDetailsStoreActionController.startAction(
      name: '_VehicleDetailsStore.updateFuelType',
    );
    try {
      return super.updateFuelType(fuelType);
    } finally {
      _$_VehicleDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMessages() {
    final _$actionInfo = _$_VehicleDetailsStoreActionController.startAction(
      name: '_VehicleDetailsStore.clearMessages',
    );
    try {
      return super.clearMessages();
    } finally {
      _$_VehicleDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
vehicleDetails: ${vehicleDetails},
isLoading: ${isLoading},
isSaving: ${isSaving},
isCreating: ${isCreating},
errorMessage: ${errorMessage},
successMessage: ${successMessage},
hasVehicle: ${hasVehicle},
canEditVehicle: ${canEditVehicle}
    ''';
  }
}
