import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:recliq_agent/features/performance/domain/entities/performance_data.dart';
import 'package:recliq_agent/features/performance/domain/repositories/performance_repository.dart';

part 'performance_store.g.dart';

@injectable
class PerformanceStore = _PerformanceStore with _$PerformanceStore;

abstract class _PerformanceStore with Store {
  final PerformanceRepository _repository;

  _PerformanceStore(this._repository);

  @observable
  PerformanceData? performanceData;

  @observable
  ObservableList<RankTierInfo> rankTiers = ObservableList<RankTierInfo>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> loadPerformance() async {
    isLoading = true;
    errorMessage = null;
    final result = await _repository.getPerformanceData();
    result.fold(
      (failure) => errorMessage = failure.message,
      (data) => performanceData = data,
    );
    isLoading = false;
  }

  @action
  Future<void> loadRankTiers() async {
    final result = await _repository.getRankTiers();
    result.fold(
      (failure) => errorMessage = failure.message,
      (tiers) => rankTiers = ObservableList.of(tiers),
    );
  }

  @action
  Future<void> loadAll() async {
    isLoading = true;
    await Future.wait([loadPerformance(), loadRankTiers()]);
    isLoading = false;
  }
}
