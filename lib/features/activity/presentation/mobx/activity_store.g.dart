// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ActivityStore on _ActivityStore, Store {
  Computed<bool>? _$hasMorePagesComputed;

  @override
  bool get hasMorePages => (_$hasMorePagesComputed ??= Computed<bool>(
    () => super.hasMorePages,
    name: '_ActivityStore.hasMorePages',
  )).value;
  Computed<bool>? _$hasActivityLogsComputed;

  @override
  bool get hasActivityLogs => (_$hasActivityLogsComputed ??= Computed<bool>(
    () => super.hasActivityLogs,
    name: '_ActivityStore.hasActivityLogs',
  )).value;

  late final _$activityResponseAtom = Atom(
    name: '_ActivityStore.activityResponse',
    context: context,
  );

  @override
  ActivityLogResponse? get activityResponse {
    _$activityResponseAtom.reportRead();
    return super.activityResponse;
  }

  @override
  set activityResponse(ActivityLogResponse? value) {
    _$activityResponseAtom.reportWrite(value, super.activityResponse, () {
      super.activityResponse = value;
    });
  }

  late final _$activityLogsAtom = Atom(
    name: '_ActivityStore.activityLogs',
    context: context,
  );

  @override
  List<ActivityLog> get activityLogs {
    _$activityLogsAtom.reportRead();
    return super.activityLogs;
  }

  @override
  set activityLogs(List<ActivityLog> value) {
    _$activityLogsAtom.reportWrite(value, super.activityLogs, () {
      super.activityLogs = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_ActivityStore.isLoading',
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
    name: '_ActivityStore.errorMessage',
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

  late final _$currentPageAtom = Atom(
    name: '_ActivityStore.currentPage',
    context: context,
  );

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$totalPagesAtom = Atom(
    name: '_ActivityStore.totalPages',
    context: context,
  );

  @override
  int get totalPages {
    _$totalPagesAtom.reportRead();
    return super.totalPages;
  }

  @override
  set totalPages(int value) {
    _$totalPagesAtom.reportWrite(value, super.totalPages, () {
      super.totalPages = value;
    });
  }

  late final _$selectedActionAtom = Atom(
    name: '_ActivityStore.selectedAction',
    context: context,
  );

  @override
  ActionType? get selectedAction {
    _$selectedActionAtom.reportRead();
    return super.selectedAction;
  }

  @override
  set selectedAction(ActionType? value) {
    _$selectedActionAtom.reportWrite(value, super.selectedAction, () {
      super.selectedAction = value;
    });
  }

  late final _$selectedRiskLevelAtom = Atom(
    name: '_ActivityStore.selectedRiskLevel',
    context: context,
  );

  @override
  RiskLevel? get selectedRiskLevel {
    _$selectedRiskLevelAtom.reportRead();
    return super.selectedRiskLevel;
  }

  @override
  set selectedRiskLevel(RiskLevel? value) {
    _$selectedRiskLevelAtom.reportWrite(value, super.selectedRiskLevel, () {
      super.selectedRiskLevel = value;
    });
  }

  late final _$selectedSourceAtom = Atom(
    name: '_ActivityStore.selectedSource',
    context: context,
  );

  @override
  Source? get selectedSource {
    _$selectedSourceAtom.reportRead();
    return super.selectedSource;
  }

  @override
  set selectedSource(Source? value) {
    _$selectedSourceAtom.reportWrite(value, super.selectedSource, () {
      super.selectedSource = value;
    });
  }

  late final _$selectedOutcomeAtom = Atom(
    name: '_ActivityStore.selectedOutcome',
    context: context,
  );

  @override
  Outcome? get selectedOutcome {
    _$selectedOutcomeAtom.reportRead();
    return super.selectedOutcome;
  }

  @override
  set selectedOutcome(Outcome? value) {
    _$selectedOutcomeAtom.reportWrite(value, super.selectedOutcome, () {
      super.selectedOutcome = value;
    });
  }

  late final _$selectedEntityTypeAtom = Atom(
    name: '_ActivityStore.selectedEntityType',
    context: context,
  );

  @override
  EntityType? get selectedEntityType {
    _$selectedEntityTypeAtom.reportRead();
    return super.selectedEntityType;
  }

  @override
  set selectedEntityType(EntityType? value) {
    _$selectedEntityTypeAtom.reportWrite(value, super.selectedEntityType, () {
      super.selectedEntityType = value;
    });
  }

  late final _$dateFromAtom = Atom(
    name: '_ActivityStore.dateFrom',
    context: context,
  );

  @override
  DateTime? get dateFrom {
    _$dateFromAtom.reportRead();
    return super.dateFrom;
  }

  @override
  set dateFrom(DateTime? value) {
    _$dateFromAtom.reportWrite(value, super.dateFrom, () {
      super.dateFrom = value;
    });
  }

  late final _$dateToAtom = Atom(
    name: '_ActivityStore.dateTo',
    context: context,
  );

  @override
  DateTime? get dateTo {
    _$dateToAtom.reportRead();
    return super.dateTo;
  }

  @override
  set dateTo(DateTime? value) {
    _$dateToAtom.reportWrite(value, super.dateTo, () {
      super.dateTo = value;
    });
  }

  late final _$loadActivityLogsAsyncAction = AsyncAction(
    '_ActivityStore.loadActivityLogs',
    context: context,
  );

  @override
  Future<void> loadActivityLogs({bool refresh = false}) {
    return _$loadActivityLogsAsyncAction.run(
      () => super.loadActivityLogs(refresh: refresh),
    );
  }

  late final _$loadMoreActivityLogsAsyncAction = AsyncAction(
    '_ActivityStore.loadMoreActivityLogs',
    context: context,
  );

  @override
  Future<void> loadMoreActivityLogs() {
    return _$loadMoreActivityLogsAsyncAction.run(
      () => super.loadMoreActivityLogs(),
    );
  }

  late final _$_ActivityStoreActionController = ActionController(
    name: '_ActivityStore',
    context: context,
  );

  @override
  void setFilters({
    ActionType? action,
    RiskLevel? riskLevel,
    Source? source,
    Outcome? outcome,
    EntityType? entityType,
    DateTime? dateFrom,
    DateTime? dateTo,
  }) {
    final _$actionInfo = _$_ActivityStoreActionController.startAction(
      name: '_ActivityStore.setFilters',
    );
    try {
      return super.setFilters(
        action: action,
        riskLevel: riskLevel,
        source: source,
        outcome: outcome,
        entityType: entityType,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );
    } finally {
      _$_ActivityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFilters() {
    final _$actionInfo = _$_ActivityStoreActionController.startAction(
      name: '_ActivityStore.clearFilters',
    );
    try {
      return super.clearFilters();
    } finally {
      _$_ActivityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void refresh() {
    final _$actionInfo = _$_ActivityStoreActionController.startAction(
      name: '_ActivityStore.refresh',
    );
    try {
      return super.refresh();
    } finally {
      _$_ActivityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
activityResponse: ${activityResponse},
activityLogs: ${activityLogs},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
currentPage: ${currentPage},
totalPages: ${totalPages},
selectedAction: ${selectedAction},
selectedRiskLevel: ${selectedRiskLevel},
selectedSource: ${selectedSource},
selectedOutcome: ${selectedOutcome},
selectedEntityType: ${selectedEntityType},
dateFrom: ${dateFrom},
dateTo: ${dateTo},
hasMorePages: ${hasMorePages},
hasActivityLogs: ${hasActivityLogs}
    ''';
  }
}
