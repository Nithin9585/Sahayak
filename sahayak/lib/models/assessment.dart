import 'package:isar/isar.dart';

part 'assessment.g.dart';

@collection
class Assessment {
  Id id = Isar.autoIncrement;

  late int studentId; // Link to Student
  late DateTime assessmentDate;

  // Reading Assessment
  String? readingLevel;
  int? readingScore;

  // Math Assessment
  String? mathLevel;
  int? mathScore;

  // Rubric details (stored as JSON or separate fields)
  String? notes;
  String? calculatedLevel; // Auto-calculated from scores

  DateTime createdAt = DateTime.now();
}
