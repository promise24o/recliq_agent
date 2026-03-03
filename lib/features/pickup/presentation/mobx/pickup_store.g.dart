// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PickupStore on _PickupStore, Store {
  Computed<int>? _$pendingCountComputed;

  @override
  int get pendingCount => (_$pendingCountComputed ??= Computed<int>(
    () => super.pendingCount,
    name: '_PickupStore.pendingCount',
  )).value;
  Computed<bool>? _$hasPendingRequestsComputed;

  @override
  bool get hasPendingRequests =>
      (_$hasPendingRequestsComputed ??= Computed<bool>(
        () => super.hasPendingRequests,
        name: '_PickupStore.hasPendingRequests',
      )).value;

  late final _$pendingRequestsAtom = Atom(
    name: '_PickupStore.pendingRequests',
    context: context,
  );

  @override
  ObservableList<PickupRequest> get pendingRequests {
    _$pendingRequestsAtom.reportRead();
    return super.pendingRequests;
  }

  @override
  set pendingRequests(ObservableList<PickupRequest> value) {
    _$pendingRequestsAtom.reportWrite(value, super.pendingRequests, () {
      super.pendingRequests = value;
    });
  }

  late final _$selectedPickupAtom = Atom(
    name: '_PickupStore.selectedPickup',
    context: context,
  );

  @override
  PickupRequest? get selectedPickup {
    _$selectedPickupAtom.reportRead();
    return super.selectedPickup;
  }

  @override
  set selectedPickup(PickupRequest? value) {
    _$selectedPickupAtom.reportWrite(value, super.selectedPickup, () {
      super.selectedPickup = value;
    });
  }

  late final _$trackingLocationAtom = Atom(
    name: '_PickupStore.trackingLocation',
    context: context,
  );

  @override
  TrackingLocation? get trackingLocation {
    _$trackingLocationAtom.reportRead();
    return super.trackingLocation;
  }

  @override
  set trackingLocation(TrackingLocation? value) {
    _$trackingLocationAtom.reportWrite(value, super.trackingLocation, () {
      super.trackingLocation = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_PickupStore.isLoading',
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

  late final _$isRespondingAtom = Atom(
    name: '_PickupStore.isResponding',
    context: context,
  );

  @override
  bool get isResponding {
    _$isRespondingAtom.reportRead();
    return super.isResponding;
  }

  @override
  set isResponding(bool value) {
    _$isRespondingAtom.reportWrite(value, super.isResponding, () {
      super.isResponding = value;
    });
  }

  late final _$isUpdatingStatusAtom = Atom(
    name: '_PickupStore.isUpdatingStatus',
    context: context,
  );

  @override
  bool get isUpdatingStatus {
    _$isUpdatingStatusAtom.reportRead();
    return super.isUpdatingStatus;
  }

  @override
  set isUpdatingStatus(bool value) {
    _$isUpdatingStatusAtom.reportWrite(value, super.isUpdatingStatus, () {
      super.isUpdatingStatus = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_PickupStore.errorMessage',
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
    name: '_PickupStore.successMessage',
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

  late final _$loadPendingRequestsAsyncAction = AsyncAction(
    '_PickupStore.loadPendingRequests',
    context: context,
  );

  @override
  Future<void> loadPendingRequests() {
    return _$loadPendingRequestsAsyncAction.run(
      () => super.loadPendingRequests(),
    );
  }

  late final _$loadPickupDetailsAsyncAction = AsyncAction(
    '_PickupStore.loadPickupDetails',
    context: context,
  );

  @override
  Future<void> loadPickupDetails(String pickupId) {
    return _$loadPickupDetailsAsyncAction.run(
      () => super.loadPickupDetails(pickupId),
    );
  }

  late final _$acceptPickupAsyncAction = AsyncAction(
    '_PickupStore.acceptPickup',
    context: context,
  );

  @override
  Future<bool> acceptPickup({
    required String pickupId,
    int? estimatedArrivalMinutes,
  }) {
    return _$acceptPickupAsyncAction.run(
      () => super.acceptPickup(
        pickupId: pickupId,
        estimatedArrivalMinutes: estimatedArrivalMinutes,
      ),
    );
  }

  late final _$declinePickupAsyncAction = AsyncAction(
    '_PickupStore.declinePickup',
    context: context,
  );

  @override
  Future<bool> declinePickup({
    required String pickupId,
    required String reason,
  }) {
    return _$declinePickupAsyncAction.run(
      () => super.declinePickup(pickupId: pickupId, reason: reason),
    );
  }

  late final _$loadTrackingLocationAsyncAction = AsyncAction(
    '_PickupStore.loadTrackingLocation',
    context: context,
  );

  @override
  Future<void> loadTrackingLocation(String pickupId) {
    return _$loadTrackingLocationAsyncAction.run(
      () => super.loadTrackingLocation(pickupId),
    );
  }

  late final _$updateStatusAsyncAction = AsyncAction(
    '_PickupStore.updateStatus',
    context: context,
  );

  @override
  Future<bool> updateStatus({
    required String pickupId,
    required String status,
  }) {
    return _$updateStatusAsyncAction.run(
      () => super.updateStatus(pickupId: pickupId, status: status),
    );
  }

  late final _$completePickupAsyncAction = AsyncAction(
    '_PickupStore.completePickup',
    context: context,
  );

  @override
  Future<bool> completePickup({
    required String pickupId,
    required double actualWeight,
    String? proofImageUrl,
  }) {
    return _$completePickupAsyncAction.run(
      () => super.completePickup(
        pickupId: pickupId,
        actualWeight: actualWeight,
        proofImageUrl: proofImageUrl,
      ),
    );
  }

  late final _$_PickupStoreActionController = ActionController(
    name: '_PickupStore',
    context: context,
  );

  @override
  void addNewRequest(PickupRequest request) {
    final _$actionInfo = _$_PickupStoreActionController.startAction(
      name: '_PickupStore.addNewRequest',
    );
    try {
      return super.addNewRequest(request);
    } finally {
      _$_PickupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeRequest(String pickupId) {
    final _$actionInfo = _$_PickupStoreActionController.startAction(
      name: '_PickupStore.removeRequest',
    );
    try {
      return super.removeRequest(pickupId);
    } finally {
      _$_PickupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateRequest(PickupRequest updatedRequest) {
    final _$actionInfo = _$_PickupStoreActionController.startAction(
      name: '_PickupStore.updateRequest',
    );
    try {
      return super.updateRequest(updatedRequest);
    } finally {
      _$_PickupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMessages() {
    final _$actionInfo = _$_PickupStoreActionController.startAction(
      name: '_PickupStore.clearMessages',
    );
    try {
      return super.clearMessages();
    } finally {
      _$_PickupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pendingRequests: ${pendingRequests},
selectedPickup: ${selectedPickup},
trackingLocation: ${trackingLocation},
isLoading: ${isLoading},
isResponding: ${isResponding},
isUpdatingStatus: ${isUpdatingStatus},
errorMessage: ${errorMessage},
successMessage: ${successMessage},
pendingCount: ${pendingCount},
hasPendingRequests: ${hasPendingRequests}
    ''';
  }
}
