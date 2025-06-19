import 'package:flutter/material.dart';
import '../../../domain/chucker_logger.dart';
import '../../../core/di.dart';
import '../widgets/log_detail_page.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = sl<ChuckerLogger>().logs;

    return Scaffold(
      appBar: AppBar(title: const Text('Chucker Logs')),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (_, index) {
          final log = logs[index];
          return ListTile(
            title: Text('${log.method} ${log.path}'),
            subtitle: Text(
              '${log.statusCode ?? 'Pending'} • ${log.duration?.inMilliseconds ?? 0} ms',
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LogDetailPage(log)),
            ),
          );
        },
      ),
    );
  }
}
