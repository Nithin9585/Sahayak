import 'package:isar/isar.dart';

part 'micro_strategy.g.dart';

@collection
class MicroStrategy {
  Id id = Isar.autoIncrement;

  late String title;
  late String description;
  late String content; // The script/steps
  
  @Index()
  late String category; // e.g., "Silence", "Focus", "Energy"
  
  late String energyLevel; // "High", "Low", "Neutral"
  
  late int durationSeconds; // e.g., 120 (2 mins)
  
  late String iconName; // For UI mapping
}
