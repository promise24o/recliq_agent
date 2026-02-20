import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:recliq_agent/features/jobs/domain/entities/job.dart';
import 'package:recliq_agent/features/jobs/domain/repositories/jobs_repository.dart';

part 'jobs_store.g.dart';

@injectable
class JobsStore = _JobsStore with _$JobsStore;

abstract class _JobsStore with Store {
  final JobsRepository _repository;

  _JobsStore(this._repository);

  @observable
  ObservableList<Job> nearbyJobs = ObservableList<Job>();

  @observable
  ObservableList<Job> assignedJobs = ObservableList<Job>();

  @observable
  ObservableList<Job> scheduledJobs = ObservableList<Job>();

  @observable
  ObservableList<Job> enterpriseJobs = ObservableList<Job>();

  @observable
  Job? selectedJob;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String? successMessage;

  @observable
  int selectedTabIndex = 0;

  @action
  void setSelectedTab(int index) => selectedTabIndex = index;

  @action
  void clearMessages() {
    errorMessage = null;
    successMessage = null;
  }

  @action
  Future<void> loadNearbyJobs() async {
    isLoading = true;
    final result = await _repository.getNearbyJobs();
    result.fold(
      (failure) => errorMessage = failure.message,
      (jobs) => nearbyJobs = ObservableList.of(jobs),
    );
    isLoading = false;
  }

  @action
  Future<void> loadAssignedJobs() async {
    isLoading = true;
    final result = await _repository.getAssignedJobs();
    result.fold(
      (failure) => errorMessage = failure.message,
      (jobs) => assignedJobs = ObservableList.of(jobs),
    );
    isLoading = false;
  }

  @action
  Future<void> loadScheduledJobs() async {
    isLoading = true;
    final result = await _repository.getScheduledJobs();
    result.fold(
      (failure) => errorMessage = failure.message,
      (jobs) => scheduledJobs = ObservableList.of(jobs),
    );
    isLoading = false;
  }

  @action
  Future<void> loadEnterpriseJobs() async {
    isLoading = true;
    final result = await _repository.getEnterpriseJobs();
    result.fold(
      (failure) => errorMessage = failure.message,
      (jobs) => enterpriseJobs = ObservableList.of(jobs),
    );
    isLoading = false;
  }

  @action
  Future<void> loadAllJobs() async {
    isLoading = true;
    await Future.wait([
      loadNearbyJobs(),
      loadAssignedJobs(),
      loadScheduledJobs(),
      loadEnterpriseJobs(),
    ]);
    isLoading = false;
  }

  @action
  Future<void> acceptJob(String jobId) async {
    isLoading = true;
    clearMessages();
    final result = await _repository.acceptJob(jobId);
    result.fold(
      (failure) => errorMessage = failure.message,
      (job) {
        selectedJob = job;
        successMessage = 'Job accepted successfully';
        loadAllJobs();
      },
    );
    isLoading = false;
  }

  @action
  Future<void> startPickup(String jobId) async {
    isLoading = true;
    clearMessages();
    final result = await _repository.startPickup(jobId);
    result.fold(
      (failure) => errorMessage = failure.message,
      (job) {
        selectedJob = job;
        successMessage = 'Pickup started';
      },
    );
    isLoading = false;
  }

  @action
  Future<void> markArrived(String jobId) async {
    isLoading = true;
    clearMessages();
    final result = await _repository.markArrived(jobId);
    result.fold(
      (failure) => errorMessage = failure.message,
      (job) {
        selectedJob = job;
        successMessage = 'Marked as arrived';
      },
    );
    isLoading = false;
  }

  @action
  Future<void> completeJob({
    required String jobId,
    required double actualWeight,
    String? proofImageUrl,
  }) async {
    isLoading = true;
    clearMessages();
    final result = await _repository.completeJob(
      jobId: jobId,
      actualWeight: actualWeight,
      proofImageUrl: proofImageUrl,
    );
    result.fold(
      (failure) => errorMessage = failure.message,
      (job) {
        selectedJob = job;
        successMessage = 'Job completed successfully';
        loadAllJobs();
      },
    );
    isLoading = false;
  }
}
