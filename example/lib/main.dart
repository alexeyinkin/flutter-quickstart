import 'package:flutter/widgets.dart';
import 'package:quickstart/quickstart.dart';

Future<void> main() async {
  await QuickStart.ensureInitialized();
  runApp(const QuickApp());
}
