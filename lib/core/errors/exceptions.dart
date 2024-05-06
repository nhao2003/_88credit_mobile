import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ErrorHelpers {
  static ApiException handleException(dynamic e) {
    if (e is DioException) {
      if (e.response != null) {
        return ApiException(
          message: e.response!.data['message'],
          statusCode: e.response!.statusCode!,
        );
      } else {
        return ApiException(
          message:
              "Something happened in setting up or sending the request that triggered an Error: $e",
          statusCode: e.response?.statusCode ?? 500,
        );
      }
    } else {
      return ApiException(message: e.toString(), statusCode: 500);
    }
  }
}

class ApiException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const ApiException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const ServerException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

class DatabaseException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const DatabaseException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

class SharedPreferencesException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const SharedPreferencesException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

class ConnectionException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const ConnectionException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const CacheException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}
