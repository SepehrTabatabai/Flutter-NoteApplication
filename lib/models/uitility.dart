import 'package:flutter_note_application/models/type_enum.dart';
import 'package:flutter_note_application/widgets/task_type.dart';

List<TaskType> getTaskTypeList() {
  var List = [
    TaskType(
      image: "assets/images/meditate.png",
      title: "Foucs",
      taskTypeEnum: TaskTypeEnum.foucs,
    ),
    TaskType(
      image: "assets/images/social_fr.png",
      title: "Meeting ",
      taskTypeEnum: TaskTypeEnum.date,
    ),
    TaskType(
      image: "assets/images/hard_working.png",
      title: "Working",
      taskTypeEnum: TaskTypeEnum.working,
    ),
    TaskType(
      image: "assets/images/banking.png",
      title: "Banking",
      taskTypeEnum: TaskTypeEnum.working,
    ),
    TaskType(
      image: "assets/images/workout.png",
      title: "Work Out",
      taskTypeEnum: TaskTypeEnum.working,
    ),
    TaskType(
      image: "assets/images/work_meeting.png",
      title: "Metting",
      taskTypeEnum: TaskTypeEnum.working,
    ),
  ];

  return List;
}
