import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../data/logger_interceptor.dart';
import '../domain/chucker_logger.dart';
import 'notification_helper.dart';

final sl = GetIt.instance;

Future<void> initChuckerFlutter() async {
  sl.registerLazySingleton(() => ChuckerLogger());

  sl.registerLazySingleton(() => Dio()
    ..interceptors.add(LoggerInterceptor(sl<ChuckerLogger>())));

  await NotificationHelper.init(); // Init local notifications
}
