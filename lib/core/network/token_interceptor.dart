import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:recliq_agent/core/constants/app_config.dart';

@lazySingleton
class TokenInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage;

  TokenInterceptor(this._secureStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.read(key: AppConfig.authTokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken =
            await _secureStorage.read(key: AppConfig.refreshTokenKey);
        if (refreshToken != null) {
          final dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
          final response = await dio.post(
            AppConfig.refreshTokenEndpoint,
            data: {'refreshToken': refreshToken},
          );

          final newAccessToken = response.data['accessToken'] as String;
          final newRefreshToken = response.data['refreshToken'] as String;

          await _secureStorage.write(
            key: AppConfig.authTokenKey,
            value: newAccessToken,
          );
          await _secureStorage.write(
            key: AppConfig.refreshTokenKey,
            value: newRefreshToken,
          );

          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';

          final retryResponse = await dio.fetch(err.requestOptions);
          return handler.resolve(retryResponse);
        }
      } catch (_) {
        await _secureStorage.deleteAll();
      }
    }
    handler.next(err);
  }
}
