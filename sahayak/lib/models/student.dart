import 'package:isar/isar.dart';

part 'student.g.dart';

@collection
class Student {
  Id id = Isar.autoIncrement;

  late String name;
  late int age;
  String? gender;

  // FLN Level tracking
  String? readingLevel; // Beginner, Letter, Word, Paragraph, Story
  String? mathLevel; // Recognition, Comparison, Addition, Subtraction, Division

  // Group assignment
  String? currentGroup; // e.g., "Word Level Group"

  DateTime createdAt = DateTime.now();
  DateTime? lastAssessment;
}
