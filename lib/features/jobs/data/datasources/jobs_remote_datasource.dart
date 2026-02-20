import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/features/jobs/domain/entities/job.dart';

abstract class JobsRemoteDataSource {
  Future<List<Job>> getNearbyJobs();
  Future<List<Job>> getAssignedJobs();
  Future<List<Job>> getScheduledJobs();
  Future<List<Job>> getEnterpriseJobs();
  Future<Job> getJobDetails(String jobId);
  Future<Job> acceptJob(String jobId);
  Future<Job> startPickup(String jobId);
  Future<Job> markArrived(String jobId);
  Future<Job> completeJob({
    required String jobId,
    required double actualWeight,
    String? proofImageUrl,
  });
  Future<void> rescheduleJob({
    required String jobId,
    required String newDate,
  });
}

@LazySingleton(as: JobsRemoteDataSource)
class JobsRemoteDataSourceImpl implements JobsRemoteDataSource {
  final DioClient _dioClient;

  JobsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<Job>> getNearbyJobs() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const Job(
        id: '1',
        wasteType: 'PET Bottles',
        estimatedWeight: 25.0,
        estimatedPayout: 3750.0,
        distance: 1.2,
        status: JobStatus.pending,
        type: JobType.nearby,
        customerName: 'John Doe',
        address: '15 Marina Road, Lagos',
        slaTime: '45 min',
      ),
      const Job(
        id: '2',
        wasteType: 'Aluminum Cans',
        estimatedWeight: 15.0,
        estimatedPayout: 4500.0,
        distance: 2.5,
        status: JobStatus.pending,
        type: JobType.nearby,
        customerName: 'Jane Smith',
        address: '23 Broad Street, Lagos',
        slaTime: '30 min',
      ),
      const Job(
        id: '3',
        wasteType: 'Cardboard',
        estimatedWeight: 40.0,
        estimatedPayout: 2000.0,
        distance: 0.8,
        status: JobStatus.pending,
        type: JobType.nearby,
        customerName: 'Mike Johnson',
        address: '7 Allen Avenue, Ikeja',
        slaTime: '60 min',
      ),
    ];
  }

  @override
  Future<List<Job>> getAssignedJobs() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const Job(
        id: '4',
        wasteType: 'Mixed Plastics',
        estimatedWeight: 30.0,
        estimatedPayout: 4200.0,
        distance: 3.1,
        status: JobStatus.accepted,
        type: JobType.assigned,
        customerName: 'Sarah Williams',
        customerPhone: '+2348012345678',
        address: '42 Admiralty Way, Lekki',
        slaTime: '2 hours',
      ),
    ];
  }

  @override
  Future<List<Job>> getScheduledJobs() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const Job(
        id: '5',
        wasteType: 'E-Waste',
        estimatedWeight: 10.0,
        estimatedPayout: 8000.0,
        distance: 5.0,
        status: JobStatus.pending,
        type: JobType.scheduled,
        customerName: 'Tech Corp Ltd',
        address: '100 Herbert Macaulay, Yaba',
        scheduledAt: '2025-02-21T14:30:00Z',
      ),
    ];
  }

  @override
  Future<List<Job>> getEnterpriseJobs() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const Job(
        id: '6',
        wasteType: 'Industrial Scrap',
        estimatedWeight: 200.0,
        estimatedPayout: 50000.0,
        distance: 8.0,
        status: JobStatus.pending,
        type: JobType.enterprise,
        customerName: 'MegaCorp Industries',
        address: '1 Industrial Avenue, Apapa',
        pricePerKg: 250.0,
        isEscrowSecured: true,
        complianceNotes: 'Requires safety gear. Check-in at gate B.',
      ),
    ];
  }

  @override
  Future<Job> getJobDetails(String jobId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const Job(
      id: '1',
      wasteType: 'PET Bottles',
      estimatedWeight: 25.0,
      estimatedPayout: 3750.0,
      distance: 1.2,
      status: JobStatus.pending,
      type: JobType.nearby,
      customerName: 'John Doe',
      customerPhone: '+2348012345678',
      address: '15 Marina Road, Lagos',
      latitude: 6.4541,
      longitude: 3.4082,
      slaTime: '45 min',
    );
  }

  @override
  Future<Job> acceptJob(String jobId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Job(
      id: jobId,
      wasteType: 'PET Bottles',
      estimatedWeight: 25.0,
      estimatedPayout: 3750.0,
      distance: 1.2,
      status: JobStatus.accepted,
      type: JobType.assigned,
      customerName: 'John Doe',
      address: '15 Marina Road, Lagos',
    );
  }

  @override
  Future<Job> startPickup(String jobId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Job(
      id: jobId,
      wasteType: 'PET Bottles',
      estimatedWeight: 25.0,
      estimatedPayout: 3750.0,
      distance: 1.2,
      status: JobStatus.inProgress,
      type: JobType.assigned,
      customerName: 'John Doe',
      address: '15 Marina Road, Lagos',
    );
  }

  @override
  Future<Job> markArrived(String jobId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Job(
      id: jobId,
      wasteType: 'PET Bottles',
      estimatedWeight: 25.0,
      estimatedPayout: 3750.0,
      distance: 0.0,
      status: JobStatus.arrived,
      type: JobType.assigned,
      customerName: 'John Doe',
      address: '15 Marina Road, Lagos',
    );
  }

  @override
  Future<Job> completeJob({
    required String jobId,
    required double actualWeight,
    String? proofImageUrl,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Job(
      id: jobId,
      wasteType: 'PET Bottles',
      estimatedWeight: 25.0,
      estimatedPayout: 3750.0,
      distance: 0.0,
      status: JobStatus.completed,
      type: JobType.assigned,
      customerName: 'John Doe',
      address: '15 Marina Road, Lagos',
      actualWeight: actualWeight,
      proofImageUrl: proofImageUrl,
      completedAt: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<void> rescheduleJob({
    required String jobId,
    required String newDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
