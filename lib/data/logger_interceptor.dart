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
    final log = logger.logs.first;
    log.statusCode = response.statusCode;
    log.responseBody = response.data;
    log.duration = DateTime.now().difference(log.time);
    NotificationHelper.show(
      "${log.method} ${log.statusCode}",
      log.path,
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final log = logger.logs.first;
    log.statusCode = err.response?.statusCode ?? -1;
    log.responseBody = err.response?.data ?? err.message;
    log.duration = DateTime.now().difference(log.time);
    NotificationHelper.show(
      "${log.method} ${log.statusCode} (Error)",
      log.path,
    );
    super.onError(err, handler);
  }
}
