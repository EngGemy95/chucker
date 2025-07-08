import 'package:chucker/core/constants.dart';
import 'package:dio/dio.dart';
import '../data/models/logged_request.dart';
import '../domain/chucker_logger.dart';
import '../core/notification_helper.dart';

class LoggerInterceptor extends Interceptor {
  final ChuckerLogger logger;

  LoggerInterceptor(this.logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final log = LoggedRequest(
      method: options.method,
      path: options.uri.toString(),
      headers: options.headers,
      requestBody: options.data,
      time: DateTime.now(),
    );
    logger.add(log);
    options.extra['start_time'] = log.time;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final startTime = response.requestOptions.extra['start_time'];
    final log = logger.logs.firstWhere(
          (l) => l.time == startTime,
      orElse: () => LoggedRequest(
        method: response.requestOptions.method,
        path: response.requestOptions.uri.toString(),
        headers: {},
        requestBody: null,
        time: DateTime.now(),
      ),
    );

    log.statusCode = response.statusCode;
    log.responseBody = response.data;
    log.duration = DateTime.now().difference(log.time);
    NotificationHelper.show(
        "${log.method} ${log.statusCode}", log.path, Constants.logs);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final startTime = err.requestOptions.extra['start_time'];
    final log = logger.logs.firstWhere(
          (l) => l.time == startTime,
      orElse: () => LoggedRequest(
        method: err.requestOptions.method,
        path: err.requestOptions.uri.toString(),
        headers: {},
        requestBody: null,
        time: DateTime.now(),
      ),
    );

    log.statusCode = err.response?.statusCode ?? -1;
    log.responseBody = err.response?.data ?? err.message;
    log.duration = DateTime.now().difference(log.time);
    NotificationHelper.show(
        "${log.method} ${log.statusCode} (Error)", log.path, Constants.logs);

    super.onError(err, handler);
  }
}
