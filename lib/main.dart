import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/Domain/Entities/Text_entity.dart';
import 'package:note_app/Presentation/Screens/TextdetailsScreen.dart';
import 'package:note_app/Presentation/Screens/homeScreen.dart';
import 'package:note_app/Presentation/Screens/noteInnerScreen.dart';
import 'package:note_app/Presentation/Screens/plusTapScreen.dart';
import 'package:note_app/data/models/NoteModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(TextEntityAdapter());
  await Hive.openBox<NoteModel>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Note App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "SofiaPro"),
        home: const Homescreen(),
        initialRoute: "/",
        routes: {
          "home": (context) => const Homescreen(),
          "noteInnerScreen": (context) => const Noteinnerscreen(),
          "textdetailsScreen": (context) => const Textdetailsscreen(),
          "plusTapScreen": (context) => const Plustapscreen(),
        });
  }
}
