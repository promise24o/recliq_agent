import 'package:dartz/dartz.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/jobs/domain/entities/job.dart';

abstract class JobsRepository {
  Future<Either<Failure, List<Job>>> getNearbyJobs();
  Future<Either<Failure, List<Job>>> getAssignedJobs();
  Future<Either<Failure, List<Job>>> getScheduledJobs();
  Future<Either<Failure, List<Job>>> getEnterpriseJobs();
  Future<Either<Failure, Job>> getJobDetails(String jobId);
  Future<Either<Failure, Job>> acceptJob(String jobId);
  Future<Either<Failure, Job>> startPickup(String jobId);
  Future<Either<Failure, Job>> markArrived(String jobId);
  Future<Either<Failure, Job>> completeJob({
    required String jobId,
    required double actualWeight,
    String? proofImageUrl,
  });
  Future<Either<Failure, void>> rescheduleJob({
    required String jobId,
    required String newDate,
  });
}
