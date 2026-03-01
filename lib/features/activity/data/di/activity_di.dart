import 'package:injectable/injectable.dart';
import 'package:recliq_agent/features/activity/data/datasources/activity_remote_datasource.dart';
import 'package:recliq_agent/features/activity/data/datasources/activity_remote_datasource_impl.dart';
import 'package:recliq_agent/features/activity/domain/repositories/activity_repository.dart';
import 'package:recliq_agent/features/activity/data/repositories/activity_repository_impl.dart';
import 'package:recliq_agent/features/activity/presentation/mobx/activity_store.dart';

@module
abstract class ActivityModule {
  @Injectable(as: ActivityRemoteDataSource)
  ActivityRemoteDataSourceImpl get activityRemoteDataSource;

  @Injectable(as: ActivityRepository)
  ActivityRepositoryImpl get activityRepository;

  @lazySingleton
  ActivityStore getActivityStore(ActivityRepository repository) => ActivityStore(repository);
}
