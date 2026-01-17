import 'package:isar/isar.dart';

part 'activity.g.dart';

@collection
class Activity {
  Id id = Isar.autoIncrement;

  late String activityId; // Unique ID (e.g., "nalikali_math_milestone_4")
  late String title;
  late String type; // "NaliKali", "TaRL", "MicroStrategy"

  String? category; // "Math", "Language", "EVS"
  String? description;
  String? instructions;

  List<String> materialsNeeded = [];
  String? groupType; // "Self-Learning", "Peer-supported", "Teacher-guided"

  // Media
  String? imageUrl;
  String? videoUrl;
  bool isCached = false; // Offline availability flag

  DateTime createdAt = DateTime.now();
}
