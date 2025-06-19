class LoggedRequest {
  final String method;
  final String path;
  final Map<String, dynamic>? headers;
  final dynamic requestBody;
  dynamic responseBody;
  int? statusCode;
  Duration? duration;
  final DateTime time;

  LoggedRequest({
    required this.method,
    required this.path,
    required this.headers,
    required this.requestBody,
    required this.time,
  });
}
