import 'package:flutter/material.dart';
import 'package:flutter_note_application/models/task.dart';
import 'package:flutter_note_application/models/uitility.dart';
import 'package:flutter_note_application/widgets/task_type_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:time_pickerr/time_pickerr.dart';

// ignore: must_be_immutable
class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({Key? key, required this.task}) : super(key: key);
  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  TextEditingController? contollerTaskTitle;
  TextEditingController? controllerTaskSubTitle;
  DateTime? _time;

  final box = Hive.box<Task>('taskBox');
  int _selectedTaskTypeItem = 0;

  @override
  void initState() {
    super.initState();

    contollerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTaskSubTitle = TextEditingController(text: widget.task.subTitle);

    negahban1.addListener(
      () {
        setState(
          () {},
        );
      },
    );

    negahban2.addListener(
      () {
        setState(
          () {},
        );
      },
    );

    var index = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });

    _selectedTaskTypeItem = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Section"),
        centerTitle: true,
        backgroundColor: Color(0xff18DDA3),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 50.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44),
                  child: TextField(
                    controller: contollerTaskTitle,
                    focusNode: negahban1,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelText: 'Task :',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: negahban1.hasFocus
                            ? Color(0xff18DAA3)
                            : Color(0xffC5C5C5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44),
                  child: TextField(
                    controller: controllerTaskSubTitle,
                    maxLines: 2,
                    focusNode: negahban2,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelText: 'Details : ',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: negahban2.hasFocus
                            ? Color(0xff18DAA3)
                            : Color(0xffC5C5C5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomHourPicker(
                  title: "Pick a Time :",
                  titleStyle: TextStyle(
                    color: Color(0xff18DAA3),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  positiveButtonText: "Add Time",
                  positiveButtonStyle: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  negativeButtonText: "Delete Time",
                  negativeButtonStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  elevation: 2.0,
                  onPositivePressed: (context, time) {
                    _time = time;
                  },
                  onNegativePressed: (context) {
                    print('onNegative');
                  },
                ),
                Container(
                  height: 150.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getTaskTypeList().length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedTaskTypeItem = index;
                          });
                        },
                        child: TaskTypeItemList(
                          taskType: getTaskTypeList()[index],
                          index: index,
                          selectedItemList: _selectedTaskTypeItem,
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff18DDA3),
                    minimumSize: Size(200.0, 40.0),
                  ),
                  onPressed: () {
                    String taskTitle = contollerTaskTitle!.text;
                    String taskSybTitle = controllerTaskSubTitle!.text;

                    editTask(taskTitle, taskSybTitle);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Edit Task",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  editTask(String taskTitle, String taskSubTitle) {
    //add task for me when user click the bottom to create a task
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubTitle;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selectedTaskTypeItem];
    widget.task.save();
  }
}
