import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/activity.dart';

class ActivityService {
  static late Isar isar;
  
  // Initialize Isar database (call this in main.dart)
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ActivitySchema],
      directory: dir.path,
    );
  }

  // Check if database is already seeded
  Future<bool> isSeeded() async {
    final count = await isar.activitys.count();
    return count > 0;
  }

  // Seed database with initial Nali Kali activities
  Future<void> seedActivities() async {
    if (await isSeeded()) return; // Don't seed twice

    final activities = [
      // Math Activities
      Activity()
        ..activityId = 'nk_math_001'
        ..title = 'Tamarind Seed Counting'
        ..type = 'NaliKali'
        ..category = 'Math'
        ..description = 'Children count tamarind seeds to recognize numbers 1-10'
        ..instructions = 'Arrange children in groups of 4-5\nGive each group 20 tamarind seeds and a bowl\nShow a number card (e.g., \'5\')\nChildren count out that many seeds into the bowl\nRotate cards and repeat'
        ..materialsNeeded = ['100 Tamarind seeds', 'Small bowls (5)', 'Number cards (1-10)']
        ..groupType = 'Self-Learning'
        ..imageUrl = 'https://via.placeholder.com/400x300.png?text=Tamarind+Seed+Counting'
        ..isCached = false,
      
      Activity()
        ..activityId = 'nk_math_002'
        ..title = 'Stone Sorting Game'
        ..type = 'NaliKali'
        ..category = 'Math'
        ..description = 'Sorting stones by size to understand comparison'
        ..instructions = 'Collect smooth stones of different sizes\nLabel 3 boxes: Small, Medium, Large\nChildren work in pairs to sort stones\nDiscuss which box has \'more\' or \'less\''
        ..materialsNeeded = ['30 small stones', '3 cardboard boxes (Small, Medium, Large labels)']
        ..groupType = 'Peer-supported'
        ..imageUrl = 'https://via.placeholder.com/400x300.png?text=Stone+Sorting'
        ..isCached = false,

      // Language Activities
      Activity()
        ..activityId = 'nk_lang_001'
        ..title = 'Sand Writing Practice'
        ..type = 'NaliKali'
        ..category = 'Language'
        ..description = 'Children trace Kannada letters in sand trays'
        ..instructions = 'Show a letter flashcard\nDemonstrate tracing in sand\nChildren practice tracing with fingers/sticks\nEncourage saying the letter sound aloud'
        ..materialsNeeded = ['Sand trays (shallow plastic trays with sand)', 'Letter flashcards (ಅ, ಆ, ಇ, ಈ)', 'Sticks for writing']
        ..groupType = 'Self-Learning'
        ..imageUrl = 'https://via.placeholder.com/400x300.png?text=Sand+Writing'
        ..isCached = false,

      Activity()
        ..activityId = 'nk_lang_002'
        ..title = 'Story Picture Walk'
        ..type = 'NaliKali'
        ..category = 'Language'
        ..description = 'Using picture cards to build vocabulary'
        ..instructions = 'Display picture cards in sequence\nAsk children to describe what they see\nRecord new words on chart paper\nCreate a simple story together'
        ..materialsNeeded = ['Story picture cards (10 cards)', 'Chart paper', 'Markers']
        ..groupType = 'Teacher-Guided'
        ..imageUrl = 'https://via.placeholder.com/400x300.png?text=Story+Picture+Walk'
        ..isCached = false,

      // EVS Activities
      Activity()
        ..activityId = 'nk_evs_001'
        ..title = 'Leaf Collection Walk'
        ..type = 'NaliKali'
        ..category = 'EVS'
        ..description = 'Nature walk to collect and identify local leaves'
        ..instructions = 'Take children on a supervised walk around school\nCollect different types of leaves\nBack in class, sort leaves by shape/size\nCreate a leaf chart with labels\nDiscuss which plants/trees they came from'
        ..materialsNeeded = ['Plastic bags for collection', 'Chart paper', 'Glue sticks', 'Labels']
        ..groupType = 'Teacher-Guided'
        ..imageUrl = 'https://via.placeholder.com/400x300.png?text=Leaf+Collection'
        ..isCached = false,

      Activity()
        ..activityId = 'nk_math_003'
        ..title = 'Number Line Jumping'
        ..type = 'NaliKali'
        ..category = 'Math'
        ..description = 'Physical activity to learn addition and subtraction'
        ..instructions = 'Draw a number line 0-10 on the ground with chalk\nCall out "Start at 3, jump forward 2"\nStudent physically jumps and says the answer (5)\nTake turns with different numbers'
        ..materialsNeeded = ['Chalk', 'Open ground space']
        ..groupType = 'Self-Learning'
        ..imageUrl = 'https://via.placeholder.com/400x300.png?text=Number+Line+Jumping'
        ..isCached = false,
    ];

    await isar.writeTxn(() async {
      await isar.activitys.putAll(activities);
    });
  }

  // Get all activities
  Future<List<Activity>> getAllActivities() async {
    return await isar.activitys.where().findAll();
  }

  // Get activities by category
  Future<List<Activity>> getActivitiesByCategory(String category) async {
    return await isar.activitys.filter().categoryEqualTo(category).findAll();
  }

  // Get cached activities
  Future<List<Activity>> getCachedActivities() async {
    return await isar.activitys.filter().isCachedEqualTo(true).findAll();
  }

  // Update activity (for toggling cache status)
  Future<void> updateActivity(Activity activity) async {
    await isar.writeTxn(() async {
      await isar.activitys.put(activity);
    });
  }

  // Toggle cache status
  Future<void> toggleCache(String activityId) async {
    final activity = await isar.activitys
        .filter()
        .activityIdEqualTo(activityId)
        .findFirst();
    
    if (activity != null) {
      activity.isCached = !activity.isCached;
      await updateActivity(activity);
    }
  }
}
