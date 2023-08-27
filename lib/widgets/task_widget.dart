import 'package:flutter/material.dart';
import 'package:flutter_note_application/Screens/edit_task_screen.dart';
import 'package:flutter_note_application/models/task.dart';

// ignore: must_be_immutable
class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key, required this.task}) : super(key: key);
  Task task;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;
  @override
  void initState() {
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        height: 160.0,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: getMainContetn(),
        ),
      ),
    );
  }

  Row getMainContetn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      value: isBoxChecked,
                      onChanged: (isChecked) {},
                    ),
                  ),
                  Text(widget.task.title)
                ],
              ),
              Text(
                widget.task.subTitle,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              getTimeAndEditBadgs()
            ],
          ),
        ),
        Image.asset(widget.task.taskType.image)
      ],
    );
  }

  Row getTimeAndEditBadgs() {
    return Row(
      children: [
        Container(
          width: 100.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: Color(0xff18DAA3),
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.task.time.hour} : ${getMinUnderTen(widget.task.time)}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 28.0,
                child: Image.asset('assets/images/icon_time.png'),
              ),
            ],
          ),
        ),
        SizedBox(width: 5),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return EditTaskScreen(
                    task: widget.task,
                  );
                },
              ),
            );
          },
          child: Container(
            width: 90.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: Color(0xffE2F6F1),
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Edit Task",
                  style: TextStyle(
                    color: Color.fromARGB(255, 36, 141, 111),
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  child: Image.asset('assets/images/icon_edit.png'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String getMinUnderTen(DateTime time) {
    if (time.minute < 10) {
      return "0${time.minute}";
    } else {
      return time.minute.toString();
    }
  }
}
