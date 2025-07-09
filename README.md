# chucker_flutter

A lightweight Chucker-like HTTP inspector for Flutter using Dio, GetIt, and flutter_local_notifications.

This package helps developers monitor and debug network requests in real-time within their apps.

---

## Features

- ✅ Logs all HTTP requests/responses using Dio interceptor
- ✅ View full request/response details (headers, body, status, duration)
- ✅ Show local notifications for each request
- ✅ Uses GetIt for dependency injection
- ✅ Built with clean architecture
- ✅ Easy integration with plug-and-play setup

---


## 🚀 Getting Started

### Initialize Chucker in `main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:chucker_flutter/chucker_flutter.dart';

final sl = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initChuckerFlutter(sl);

  // If you already have a Dio, attach the logger manually
   dio.interceptors.add(LoggerInterceptor(sl<ChuckerLogger>()));

  runApp(MyApp());
  
}
```

## Do not forget to put the navigatorKey in your material app to handle press on notification
## The navigatorKey exist in the package inside NavigationService class

```dart
void MaterialWidget(Widget child) {
  return MaterialApp(
    navigatorKey: NavigationService.navigatorKey,
    title: 'Your App',
    home: child,
  );
}
```

### Use Dio (already configured via GetIt)

```dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final dio = GetIt.I<Dio>();

void fetchData() async {
  final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
  print(response.data);
}
```

---

### Show logs screen anywhere in your app

```dart
import 'package:flutter/material.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
void showLogsPage() async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const LogsPage()),
  );
}
```


```dart
import 'package:flutter/material.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
void showLogsDetailsPage(LoggedRequest log) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const LogDetailPage(log)),
  );
}
```

## Author

Developed with by [Mohamed Gamal](https://mohamedgamalfayed.vercel.app)

---

## License

This project is licensed under the MIT License.  
See [LICENSE](LICENSE) for full details.

---

## Acknowledgements

This package uses and respects the following awesome packages:

- [`dio`](https://pub.dev/packages/dio) – Powerful HTTP client publish by flutter.cn
- [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications) – Local notification system by Michael Bui & publish by dexterx.dev
- [`get_it`](https://pub.dev/packages/get_it) – Dependency injection publish by fluttercommunity.dev

Make sure to read and comply with their licenses if you plan to redistribute or modify this package.
