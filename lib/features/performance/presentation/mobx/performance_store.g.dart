// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PerformanceStore on _PerformanceStore, Store {
  late final _$performanceDataAtom = Atom(
    name: '_PerformanceStore.performanceData',
    context: context,
  );

  @override
  PerformanceData? get performanceData {
    _$performanceDataAtom.reportRead();
    return super.performanceData;
  }

  @override
  set performanceData(PerformanceData? value) {
    _$performanceDataAtom.reportWrite(value, super.performanceData, () {
      super.performanceData = value;
    });
  }

  late final _$rankTiersAtom = Atom(
    name: '_PerformanceStore.rankTiers',
    context: context,
  );

  @override
  ObservableList<RankTierInfo> get rankTiers {
    _$rankTiersAtom.reportRead();
    return super.rankTiers;
  }

  @override
  set rankTiers(ObservableList<RankTierInfo> value) {
    _$rankTiersAtom.reportWrite(value, super.rankTiers, () {
      super.rankTiers = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_PerformanceStore.isLoading',
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
    name: '_PerformanceStore.errorMessage',
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

  late final _$loadPerformanceAsyncAction = AsyncAction(
    '_PerformanceStore.loadPerformance',
    context: context,
  );

  @override
  Future<void> loadPerformance() {
    return _$loadPerformanceAsyncAction.run(() => super.loadPerformance());
  }

  late final _$loadRankTiersAsyncAction = AsyncAction(
    '_PerformanceStore.loadRankTiers',
    context: context,
  );

  @override
  Future<void> loadRankTiers() {
    return _$loadRankTiersAsyncAction.run(() => super.loadRankTiers());
  }

  late final _$loadAllAsyncAction = AsyncAction(
    '_PerformanceStore.loadAll',
    context: context,
  );

  @override
  Future<void> loadAll() {
    return _$loadAllAsyncAction.run(() => super.loadAll());
  }

  @override
  String toString() {
    return '''
performanceData: ${performanceData},
rankTiers: ${rankTiers},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
