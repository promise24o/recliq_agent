// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardStore on _DashboardStore, Store {
  Computed<bool>? _$hasDataComputed;

  @override
  bool get hasData => (_$hasDataComputed ??= Computed<bool>(
    () => super.hasData,
    name: '_DashboardStore.hasData',
  )).value;

  late final _$dashboardDataAtom = Atom(
    name: '_DashboardStore.dashboardData',
    context: context,
  );

  @override
  DashboardData? get dashboardData {
    _$dashboardDataAtom.reportRead();
    return super.dashboardData;
  }

  @override
  set dashboardData(DashboardData? value) {
    _$dashboardDataAtom.reportWrite(value, super.dashboardData, () {
      super.dashboardData = value;
    });
  }

  late final _$agentStatsAtom = Atom(
    name: '_DashboardStore.agentStats',
    context: context,
  );

  @override
  AgentStats? get agentStats {
    _$agentStatsAtom.reportRead();
    return super.agentStats;
  }

  @override
  set agentStats(AgentStats? value) {
    _$agentStatsAtom.reportWrite(value, super.agentStats, () {
      super.agentStats = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_DashboardStore.isLoading',
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
    name: '_DashboardStore.errorMessage',
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

  late final _$isOnlineAtom = Atom(
    name: '_DashboardStore.isOnline',
    context: context,
  );

  @override
  bool get isOnline {
    _$isOnlineAtom.reportRead();
    return super.isOnline;
  }

  @override
  set isOnline(bool value) {
    _$isOnlineAtom.reportWrite(value, super.isOnline, () {
      super.isOnline = value;
    });
  }

  late final _$_isTogglingOnlineAtom = Atom(
    name: '_DashboardStore._isTogglingOnline',
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

  late final _$loadDashboardAsyncAction = AsyncAction(
    '_DashboardStore.loadDashboard',
    context: context,
  );

  @override
  Future<void> loadDashboard() {
    return _$loadDashboardAsyncAction.run(() => super.loadDashboard());
  }

  late final _$loadStatsAsyncAction = AsyncAction(
    '_DashboardStore.loadStats',
    context: context,
  );

  @override
  Future<void> loadStats() {
    return _$loadStatsAsyncAction.run(() => super.loadStats());
  }

  late final _$toggleOnlineAsyncAction = AsyncAction(
    '_DashboardStore.toggleOnline',
    context: context,
  );

  @override
  Future<void> toggleOnline() {
    return _$toggleOnlineAsyncAction.run(() => super.toggleOnline());
  }

  late final _$refreshAsyncAction = AsyncAction(
    '_DashboardStore.refresh',
    context: context,
  );

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  @override
  String toString() {
    return '''
dashboardData: ${dashboardData},
agentStats: ${agentStats},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
isOnline: ${isOnline},
hasData: ${hasData}
    ''';
  }
}
