import 'package:isar/isar.dart';

part 'chat_history.g.dart';

@collection
class ChatHistory {
  Id id = Isar.autoIncrement;

  late String message; // User query
  late String response; // RAG response
  late DateTime timestamp;

  String? source; // Citation (e.g., "NCERT Grade 2, Page 45")
  bool isOffline = false; // Was this query answered offline?

  DateTime createdAt = DateTime.now();
}
