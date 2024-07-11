import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  await Hive.initFlutter();
  final _Mybox = Hive.openBox("Mybox");
  runApp(const Text("Hehe"));
}
