import 'package:hive_flutter/hive_flutter.dart';

part 'type_enum.g.dart';

@HiveType(typeId: 5)
enum TaskTypeEnum {
  @HiveField(0)
  working,
  @HiveField(1)
  date,
  @HiveField(2)
  foucs,
}
