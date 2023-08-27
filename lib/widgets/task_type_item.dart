import 'package:flutter/material.dart';
import 'package:flutter_note_application/widgets/task_type.dart';

// ignore: must_be_immutable
class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList(
      {super.key,
      required this.taskType,
      required this.index,
      required this.selectedItemList});
  TaskType taskType;

  int index;
  int selectedItemList;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (selectedItemList == index) ? Color(0xff18DDA3) : Colors.white,
        border: Border.all(
          color: (selectedItemList == index) ? Colors.green : Colors.grey,
          width: (selectedItemList == index) ? 2.5 : 1.5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(13.0),
        ),
      ),
      margin: EdgeInsets.all(8.0),
      width: 100.0,
      child: Column(
        children: [
          Image.asset(taskType.image),
          Text(
            taskType.title,
            style: TextStyle(
              color: (selectedItemList == index) ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
