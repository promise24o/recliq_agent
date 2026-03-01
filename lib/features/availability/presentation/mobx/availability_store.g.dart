// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AvailabilityStore on _AvailabilityStore, Store {
  Computed<bool>? _$hasChangesComputed;

  @override
  bool get hasChanges => (_$hasChangesComputed ??= Computed<bool>(
    () => super.hasChanges,
    name: '_AvailabilityStore.hasChanges',
  )).value;

  late final _$availabilityAtom = Atom(
    name: '_AvailabilityStore.availability',
    context: context,
  );

  @override
  AgentAvailability? get availability {
    _$availabilityAtom.reportRead();
    return super.availability;
  }

  @override
  set availability(AgentAvailability? value) {
    _$availabilityAtom.reportWrite(value, super.availability, () {
      super.availability = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_AvailabilityStore.isLoading',
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
    name: '_AvailabilityStore.isSaving',
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

  late final _$errorMessageAtom = Atom(
    name: '_AvailabilityStore.errorMessage',
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
    name: '_AvailabilityStore.successMessage',
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

  late final _$_isTogglingOnlineAtom = Atom(
    name: '_AvailabilityStore._isTogglingOnline',
    context: context,
  );

  @override
  bool get _isTogglingOnline {
    _$_isTogglingOnlineAtom.reportRead();
    return super._isTogglingOnline;
  }

  @override
  set _isTogglingOnline(bool value) {
    _$_isTogglingOnlineAtom.reportWrite(value, super._isTogglingOnline, () {
      super._isTogglingOnline = value;
    });
  }

  late final _$loadAvailabilityAsyncAction = AsyncAction(
    '_AvailabilityStore.loadAvailability',
    context: context,
  );

  @override
  Future<void> loadAvailability() {
    return _$loadAvailabilityAsyncAction.run(() => super.loadAvailability());
  }

  late final _$saveAvailabilityAsyncAction = AsyncAction(
    '_AvailabilityStore.saveAvailability',
    context: context,
  );

  @override
  Future<bool> saveAvailability() {
    return _$saveAvailabilityAsyncAction.run(() => super.saveAvailability());
  }

  late final _$toggleOnlineStatusAsyncAction = AsyncAction(
    '_AvailabilityStore.toggleOnlineStatus',
    context: context,
  );

  @override
  Future<bool> toggleOnlineStatus() {
    return _$toggleOnlineStatusAsyncAction.run(
      () => super.toggleOnlineStatus(),
    );
  }

  late final _$_AvailabilityStoreActionController = ActionController(
    name: '_AvailabilityStore',
    context: context,
  );

  @override
  void updateDaySchedule(String day, DaySchedule schedule) {
    final _$actionInfo = _$_AvailabilityStoreActionController.startAction(
      name: '_AvailabilityStore.updateDaySchedule',
    );
    try {
      return super.updateDaySchedule(day, schedule);
    } finally {
      _$_AvailabilityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleDayEnabled(String day) {
    final _$actionInfo = _$_AvailabilityStoreActionController.startAction(
      name: '_AvailabilityStore.toggleDayEnabled',
    );
    try {
      return super.toggleDayEnabled(day);
    } finally {
      _$_AvailabilityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTimeSlot(String day, TimeSlot slot) {
    final _$actionInfo = _$_AvailabilityStoreActionController.startAction(
      name: '_AvailabilityStore.addTimeSlot',
    );
    try {
      return super.addTimeSlot(day, slot);
    } finally {
      _$_AvailabilityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTimeSlot(String day, int index) {
    final _$actionInfo = _$_AvailabilityStoreActionController.startAction(
      name: '_AvailabilityStore.removeTimeSlot',
    );
    try {
      return super.removeTimeSlot(day, index);
    } finally {
      _$_AvailabilityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTimeSlot(String day, int index, TimeSlot slot) {
    final _$actionInfo = _$_AvailabilityStoreActionController.startAction(
      name: '_AvailabilityStore.updateTimeSlot',
    );
    try {
      return super.updateTimeSlot(day, index, slot);
    } finally {
      _$_AvailabilityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleEnterpriseJobs(bool value) {
    final _$actionInfo = _$_AvailabilityStoreActionController.startAction(
      name: '_AvailabilityStore.toggleEnterpriseJobs',
    );
    try {
      return super.toggleEnterpriseJobs(value);
    } finally {
      _$_AvailabilityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAutoGoOnline(bool value) {
    final _$actionInfo = _$_AvailabilityStoreActionController.startAction(
      name: '_AvailabilityStore.toggleAutoGoOnline',
    );
    try {
      return super.toggleAutoGoOnline(value);
    } finally {
      _$_AvailabilityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMessages() {
    final _$actionInfo = _$_AvailabilityStoreActionController.startAction(
      name: '_AvailabilityStore.clearMessages',
    );
    try {
      return super.clearMessages();
    } finally {
      _$_AvailabilityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
availability: ${availability},
isLoading: ${isLoading},
isSaving: ${isSaving},
errorMessage: ${errorMessage},
successMessage: ${successMessage},
hasChanges: ${hasChanges}
    ''';
  }
}
