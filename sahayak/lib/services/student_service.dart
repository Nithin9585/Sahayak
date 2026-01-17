import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/student.dart';

class StudentService {
  static late Isar isar;
  
  // Initialize Isar database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [StudentSchema],
      directory: dir.path,
    );
  }

  // Add a new student
  Future<int> addStudent(Student student) async {
    return await isar.writeTxn(() async {
      return await isar.students.put(student);
    });
  }

  // Get all students
  Future<List<Student>> getAllStudents() async {
    return await isar.students.where().findAll();
  }

  // Update student
  Future<void> updateStudent(Student student) async {
    await isar.writeTxn(() async {
      await isar.students.put(student);
    });
  }

  // Delete student
  Future<bool> deleteStudent(int id) async {
    return await isar.writeTxn(() async {
      return await isar.students.delete(id);
    });
  }

  // Get students grouped by reading level
  Future<Map<String, List<Student>>> getStudentsByReadingLevel() async {
    final students = await getAllStudents();
    final Map<String, List<Student>> grouped = {};
    
    for (var student in students) {
      final level = student.readingLevel ?? 'Unassessed';
      if (!grouped.containsKey(level)) {
        grouped[level] = [];
      }
      grouped[level]!.add(student);
    }
    
    return grouped;
  }

  // Get students grouped by math level
  Future<Map<String, List<Student>>> getStudentsByMathLevel() async {
    final students = await getAllStudents();
    final Map<String, List<Student>> grouped = {};
    
    for (var student in students) {
      final level = student.mathLevel ?? 'Unassessed';
      if (!grouped.containsKey(level)) {
        grouped[level] = [];
      }
      grouped[level]!.add(student);
    }
    
    return grouped;
  }
}
