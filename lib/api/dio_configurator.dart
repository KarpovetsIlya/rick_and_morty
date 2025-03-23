import 'package:dio/dio.dart';

final class DioConfigurator {
  const DioConfigurator();

  Dio create() {
    const timeout = Duration(seconds: 60);

    final dio = Dio();

    dio.options
      ..contentType = 'application/json'
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..sendTimeout = timeout;

    return dio;
  }
}
