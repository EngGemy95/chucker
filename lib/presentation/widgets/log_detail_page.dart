import 'package:flutter/material.dart';
import '../../../data/models/logged_request.dart';
import 'dart:convert';

class LogDetailPage extends StatelessWidget {
  final LoggedRequest log;

  const LogDetailPage(this.log, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${log.method} ${log.path}')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Text('Status: ${log.statusCode}', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Duration: ${log.duration?.inMilliseconds ?? '-'} ms'),
            const Divider(),
            const Text('Request Headers:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(jsonEncode(log.headers)),
            const Divider(),
            const Text('Request Body:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(jsonEncode(log.requestBody)),
            const Divider(),
            const Text('Response Body:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(jsonEncode(log.responseBody)),
          ],
        ),
      ),
    );
  }
}
