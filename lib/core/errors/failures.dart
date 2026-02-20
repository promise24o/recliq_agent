import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.serverError(String message) = ServerError;
  const factory Failure.networkError(String message) = NetworkError;
  const factory Failure.cacheError(String message) = CacheError;
  const factory Failure.authError(String message) = AuthError;
  const factory Failure.validationError(String message) = ValidationError;
  const factory Failure.unknownError(String message) = UnknownError;
}

extension FailureX on Failure {
  String get message => when(
        serverError: (msg) => msg,
        networkError: (msg) => msg,
        cacheError: (msg) => msg,
        authError: (msg) => msg,
        validationError: (msg) => msg,
        unknownError: (msg) => msg,
      );
}
