import 'package:isar/isar.dart';

part 'micro_strategy.g.dart';

@collection
class MicroStrategy {
  Id id = Isar.autoIncrement;

  late String title; // e.g., "The Graveyard", "Silent Ball"
  late String energyLevel; // "High", "Low", "Transition"
  late int durationMinutes; // 1, 2, 5

  late String type; // "Gamified Silence", "Call-and-Response", "Movement"
  late String instructions;

  String? whenToUse; // Contextual guidance
  bool isFavorite = false; // Quick access flag

  DateTime createdAt = DateTime.now();
}
