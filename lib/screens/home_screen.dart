import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_note_application/Screens/add_task_screen.dart';
import 'package:flutter_note_application/models/task.dart';
import 'package:flutter_note_application/widgets/task_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box<Task>('taskBox');
  bool isChecked = false;
  bool isFabVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
        centerTitle: true,
        backgroundColor: Color(0xff18DDA3),
      ),
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: (context, value, child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  setState(() {
                    if (notification.direction == ScrollDirection.forward) {
                      isFabVisible = true;
                    }
                    if (notification.direction == ScrollDirection.reverse) {
                      isFabVisible = false;
                    }
                  });
                  return true;
                },
                child: ListView.builder(
                  itemCount: taskBox.values.length,
                  itemBuilder: (context, index) {
                    var task = taskBox.values.toList()[index];
                    return getListItem(task);
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            );
          },
          backgroundColor: Color(0xff18DAA3),
          child: Image.asset('assets/images/icon_add.png'),
        ),
      ),
    );
  }

  Widget getListItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        task.delete();
      },
      child: TaskWidget(task: task),
    );
  }
}
