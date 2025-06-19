import '../data/models/logged_request.dart';

class ChuckerLogger {
  final List<LoggedRequest> _logs = [];

  List<LoggedRequest> get logs => _logs;

  void add(LoggedRequest log) {
    _logs.insert(0, log);
  }

  void clear() => _logs.clear();
}
