// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$JobsStore on _JobsStore, Store {
  late final _$nearbyJobsAtom = Atom(
    name: '_JobsStore.nearbyJobs',
    context: context,
  );

  @override
  ObservableList<Job> get nearbyJobs {
    _$nearbyJobsAtom.reportRead();
    return super.nearbyJobs;
  }

  @override
  set nearbyJobs(ObservableList<Job> value) {
    _$nearbyJobsAtom.reportWrite(value, super.nearbyJobs, () {
      super.nearbyJobs = value;
    });
  }

  late final _$assignedJobsAtom = Atom(
    name: '_JobsStore.assignedJobs',
    context: context,
  );

  @override
  ObservableList<Job> get assignedJobs {
    _$assignedJobsAtom.reportRead();
    return super.assignedJobs;
  }

  @override
  set assignedJobs(ObservableList<Job> value) {
    _$assignedJobsAtom.reportWrite(value, super.assignedJobs, () {
      super.assignedJobs = value;
    });
  }

  late final _$scheduledJobsAtom = Atom(
    name: '_JobsStore.scheduledJobs',
    context: context,
  );

  @override
  ObservableList<Job> get scheduledJobs {
    _$scheduledJobsAtom.reportRead();
    return super.scheduledJobs;
  }

  @override
  set scheduledJobs(ObservableList<Job> value) {
    _$scheduledJobsAtom.reportWrite(value, super.scheduledJobs, () {
      super.scheduledJobs = value;
    });
  }

  late final _$enterpriseJobsAtom = Atom(
    name: '_JobsStore.enterpriseJobs',
    context: context,
  );

  @override
  ObservableList<Job> get enterpriseJobs {
    _$enterpriseJobsAtom.reportRead();
    return super.enterpriseJobs;
  }

  @override
  set enterpriseJobs(ObservableList<Job> value) {
    _$enterpriseJobsAtom.reportWrite(value, super.enterpriseJobs, () {
      super.enterpriseJobs = value;
    });
  }

  late final _$selectedJobAtom = Atom(
    name: '_JobsStore.selectedJob',
    context: context,
  );

  @override
  Job? get selectedJob {
    _$selectedJobAtom.reportRead();
    return super.selectedJob;
  }

  @override
  set selectedJob(Job? value) {
    _$selectedJobAtom.reportWrite(value, super.selectedJob, () {
      super.selectedJob = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_JobsStore.isLoading',
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
    name: '_JobsStore.errorMessage',
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
    name: '_JobsStore.successMessage',
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

  late final _$selectedTabIndexAtom = Atom(
    name: '_JobsStore.selectedTabIndex',
    context: context,
  );

  @override
  int get selectedTabIndex {
    _$selectedTabIndexAtom.reportRead();
    return super.selectedTabIndex;
  }

  @override
  set selectedTabIndex(int value) {
    _$selectedTabIndexAtom.reportWrite(value, super.selectedTabIndex, () {
      super.selectedTabIndex = value;
    });
  }

  late final _$loadNearbyJobsAsyncAction = AsyncAction(
    '_JobsStore.loadNearbyJobs',
    context: context,
  );

  @override
  Future<void> loadNearbyJobs() {
    return _$loadNearbyJobsAsyncAction.run(() => super.loadNearbyJobs());
  }

  late final _$loadAssignedJobsAsyncAction = AsyncAction(
    '_JobsStore.loadAssignedJobs',
    context: context,
  );

  @override
  Future<void> loadAssignedJobs() {
    return _$loadAssignedJobsAsyncAction.run(() => super.loadAssignedJobs());
  }

  late final _$loadScheduledJobsAsyncAction = AsyncAction(
    '_JobsStore.loadScheduledJobs',
    context: context,
  );

  @override
  Future<void> loadScheduledJobs() {
    return _$loadScheduledJobsAsyncAction.run(() => super.loadScheduledJobs());
  }

  late final _$loadEnterpriseJobsAsyncAction = AsyncAction(
    '_JobsStore.loadEnterpriseJobs',
    context: context,
  );

  @override
  Future<void> loadEnterpriseJobs() {
    return _$loadEnterpriseJobsAsyncAction.run(
      () => super.loadEnterpriseJobs(),
    );
  }

  late final _$loadAllJobsAsyncAction = AsyncAction(
    '_JobsStore.loadAllJobs',
    context: context,
  );

  @override
  Future<void> loadAllJobs() {
    return _$loadAllJobsAsyncAction.run(() => super.loadAllJobs());
  }

  late final _$acceptJobAsyncAction = AsyncAction(
    '_JobsStore.acceptJob',
    context: context,
  );

  @override
  Future<void> acceptJob(String jobId) {
    return _$acceptJobAsyncAction.run(() => super.acceptJob(jobId));
  }

  late final _$startPickupAsyncAction = AsyncAction(
    '_JobsStore.startPickup',
    context: context,
  );

  @override
  Future<void> startPickup(String jobId) {
    return _$startPickupAsyncAction.run(() => super.startPickup(jobId));
  }

  late final _$markArrivedAsyncAction = AsyncAction(
    '_JobsStore.markArrived',
    context: context,
  );

  @override
  Future<void> markArrived(String jobId) {
    return _$markArrivedAsyncAction.run(() => super.markArrived(jobId));
  }

  late final _$completeJobAsyncAction = AsyncAction(
    '_JobsStore.completeJob',
    context: context,
  );

  @override
  Future<void> completeJob({
    required String jobId,
    required double actualWeight,
    String? proofImageUrl,
  }) {
    return _$completeJobAsyncAction.run(
      () => super.completeJob(
        jobId: jobId,
        actualWeight: actualWeight,
        proofImageUrl: proofImageUrl,
      ),
    );
  }

  late final _$_JobsStoreActionController = ActionController(
    name: '_JobsStore',
    context: context,
  );

  @override
  void setSelectedTab(int index) {
    final _$actionInfo = _$_JobsStoreActionController.startAction(
      name: '_JobsStore.setSelectedTab',
    );
    try {
      return super.setSelectedTab(index);
    } finally {
      _$_JobsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMessages() {
    final _$actionInfo = _$_JobsStoreActionController.startAction(
      name: '_JobsStore.clearMessages',
    );
    try {
      return super.clearMessages();
    } finally {
      _$_JobsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nearbyJobs: ${nearbyJobs},
assignedJobs: ${assignedJobs},
scheduledJobs: ${scheduledJobs},
enterpriseJobs: ${enterpriseJobs},
selectedJob: ${selectedJob},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
successMessage: ${successMessage},
selectedTabIndex: ${selectedTabIndex}
    ''';
  }
}
