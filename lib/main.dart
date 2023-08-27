import 'package:flutter/material.dart';
import 'package:flutter_note_application/Screens/home_screen.dart';
import 'package:flutter_note_application/models/task.dart';
import 'package:flutter_note_application/models/type_enum.dart';
import 'package:flutter_note_application/widgets/task_type.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());

  await Hive.openBox<Task>('taskBox');

  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SM',
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
