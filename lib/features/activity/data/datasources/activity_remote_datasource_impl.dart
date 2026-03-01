import 'package:dio/dio.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/core/network/dio_client.dart';
import 'package:recliq_agent/core/errors/exceptions.dart';
import 'package:recliq_agent/features/activity/data/datasources/activity_remote_datasource.dart';
import 'package:recliq_agent/features/activity/domain/entities/activity_log.dart';

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  final DioClient _dioClient = getIt<DioClient>();

  @override
  Future<ActivityLogResponse> getActivityLogs({
    String? action,
    String? riskLevel,
    String? source,
    String? outcome,
    String? entityType,
    DateTime? dateFrom,
    DateTime? dateTo,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      if (action != null) queryParams['action'] = action;
      if (riskLevel != null) queryParams['riskLevel'] = riskLevel;
      if (source != null) queryParams['source'] = source;
      if (outcome != null) queryParams['outcome'] = outcome;
      if (entityType != null) queryParams['entityType'] = entityType;
      if (dateFrom != null) queryParams['dateFrom'] = dateFrom.toIso8601String();
      if (dateTo != null) queryParams['dateTo'] = dateTo.toIso8601String();

      print("RemoteDataSource: Making API call");
      final response = await _dioClient.get('/user-activity/my-logs', queryParameters: queryParams);
      
      print("RemoteDataSource: Parsing response");
      final result = ActivityLogResponse.fromJson(response.data as Map<String, dynamic>);
      print("RemoteDataSource: Success with ${result.logs.length} logs");
      
      return result;
    } on DioException catch (e) {
      print("RemoteDataSource DioException: ${e.message}");
      throw ServerException(message: e.message ?? 'Failed to load activity logs');
    } catch (e) {
      print("RemoteDataSource Exception: $e");
      throw ServerException(message: e.toString());
    }
  }
}
