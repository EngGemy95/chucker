import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/chucker_logger.dart';
import '../widgets/log_detail_page.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({super.key});

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  String searchQuery = '';
  String methodFilter = 'All';

  List<String> get _methods => ['All', 'GET', 'POST', 'PUT', 'DELETE'];

  @override
  Widget build(BuildContext context) {
    final logs = GetIt.instance<ChuckerLogger>().logs.where((log) {
      final matchesMethod = methodFilter == 'All' || log.method == methodFilter;
      final matchesSearch =
      log.path.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesMethod && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chucker Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Clear Logs',
            onPressed: () {
              GetIt.instance<ChuckerLogger>().clear();
              setState(() {}); // rebuild cleanly
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          const Divider(height: 0),
          Expanded(
            child: logs.isEmpty
                ? const Center(child: Text('No logs found.'))
                : ListView.builder(
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
                    MaterialPageRoute(
                      builder: (_) => LogDetailPage(log),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by path...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: methodFilter,
            items: _methods
                .map((method) => DropdownMenuItem(
              value: method,
              child: Text(method),
            ))
                .toList(),
            onChanged: (value) => setState(() => methodFilter = value!),
          ),
        ],
      ),
    );
  }
}


// class _LogsPageState extends State<LogsPage> {
//   @override
//   Widget build(BuildContext context) {
//     final logs = sl<ChuckerLogger>().logs;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Chucker Logs'), actions: [
//         IconButton(
//           icon: Icon(Icons.delete),
//           onPressed: () {
//             sl<ChuckerLogger>().clear();
//             (context as Element).markNeedsBuild();
//           },
//         ),
//       ]),
//       body: ListView.builder(
//         itemCount: logs.length,
//         itemBuilder: (_, index) {
//           final log = logs[index];
//           return ListTile(
//             title: Text('${log.method} ${log.path}'),
//             subtitle: Text(
//               '${log.statusCode ?? 'Pending'} • ${log.duration?.inMilliseconds ?? 0} ms',
//             ),
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => LogDetailPage(log)),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
