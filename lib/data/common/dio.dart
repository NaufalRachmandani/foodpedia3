import 'package:dio/dio.dart';
import 'package:foodpedia/data/common/failure.dart';
import 'package:logger/logger.dart';

Dio configureDio() {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  return dio;
}

Failure dioException(DioException e) {
  Logger().e("dioException ${e.message}", error: e);

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return ConnectionTimeoutFailure(e.message);

    case DioExceptionType.connectionError:
      return ConnectionErrorFailure(e.message);

    case DioExceptionType.badCertificate:
      return BadCertificateFailure(e.message);

    case DioExceptionType.badResponse:
      return BadResponseFailure(e.message);

    case DioExceptionType.cancel:
      return CancelFailure(e.message);

    case DioExceptionType.unknown:
      return UnknownFailure(e.message);

    default:
      return UnknownFailure(e.message);
  }
}
