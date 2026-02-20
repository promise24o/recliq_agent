import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/errors/exceptions.dart';
import 'package:recliq_agent/core/errors/failures.dart';
import 'package:recliq_agent/features/jobs/data/datasources/jobs_remote_datasource.dart';
import 'package:recliq_agent/features/jobs/domain/entities/job.dart';
import 'package:recliq_agent/features/jobs/domain/repositories/jobs_repository.dart';

@LazySingleton(as: JobsRepository)
class JobsRepositoryImpl implements JobsRepository {
  final JobsRemoteDataSource _remoteDataSource;

  JobsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Job>>> getNearbyJobs() async {
    try {
      final result = await _remoteDataSource.getNearbyJobs();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getAssignedJobs() async {
    try {
      final result = await _remoteDataSource.getAssignedJobs();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getScheduledJobs() async {
    try {
      final result = await _remoteDataSource.getScheduledJobs();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getEnterpriseJobs() async {
    try {
      final result = await _remoteDataSource.getEnterpriseJobs();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Job>> getJobDetails(String jobId) async {
    try {
      final result = await _remoteDataSource.getJobDetails(jobId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Job>> acceptJob(String jobId) async {
    try {
      final result = await _remoteDataSource.acceptJob(jobId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Job>> startPickup(String jobId) async {
    try {
      final result = await _remoteDataSource.startPickup(jobId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Job>> markArrived(String jobId) async {
    try {
      final result = await _remoteDataSource.markArrived(jobId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Job>> completeJob({
    required String jobId,
    required double actualWeight,
    String? proofImageUrl,
  }) async {
    try {
      final result = await _remoteDataSource.completeJob(
        jobId: jobId,
        actualWeight: actualWeight,
        proofImageUrl: proofImageUrl,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rescheduleJob({
    required String jobId,
    required String newDate,
  }) async {
    try {
      await _remoteDataSource.rescheduleJob(jobId: jobId, newDate: newDate);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.serverError(e.message));
    } catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }
}
