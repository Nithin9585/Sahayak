import 'package:isar/isar.dart';

part 'teacher.g.dart';

@collection
class Teacher {
  Id id = Isar.autoIncrement;

  @Index()
  late String teacherId; // Unique teacher ID

  late String name;
  late String schoolId;
  late String phoneNumber;

  List<String> subjects = []; // Subjects taught
  String? profileImage;

  DateTime createdAt = DateTime.now();
  DateTime? lastSync;
}
