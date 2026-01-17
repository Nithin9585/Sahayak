import 'package:isar/isar.dart';
import '../models/micro_strategy.dart';

class StrategyService {
  static late Isar isar;

  Future<void> seedStrategies() async {
    final count = await isar.microStrategys.count();
    if (count > 0) return;

    final strategies = [
      MicroStrategy()
        ..title = 'The Graveyard'
        ..description = 'Instant silence game for chaotic moments.'
        ..content = '1. Scream "GRAVEYARD!"\n2. All students must drop to the floor and "play dead".\n3. The teacher walks around checking for movement.\n4. If anyone moves/giggles, they are "out".\n5. Last one remaining is the Zombie King/Queen.'
        ..category = 'Silence'
        ..energyLevel = 'Low'
        ..durationSeconds = 120
        ..iconName = 'accessibility_new',
      
      MicroStrategy()
        ..title = 'Silent Ball'
        ..description = 'Focus builder using a soft ball.'
        ..content = '1. Students sit on desks or stand.\n2. Pass a soft ball silently.\n3. If you drop it, you sit down.\n4. If you talk, you sit down.\n5. If you make a bad throw, you sit down.'
        ..category = 'Focus'
        ..energyLevel = 'Low'
        ..durationSeconds = 180
        ..iconName = 'sports_baseball',

      MicroStrategy()
        ..title = 'Thunder Clap'
        ..description = 'Reset energy with a rhythmic clap.'
        ..content = '1. Teacher: "Thunder!"\n2. Students: *Stomp Stomp*\n3. Teacher: "Lightning!"\n4. Students: *Clap Clap*\n5. Repeat faster until perfect synchronization.'
        ..category = 'Energy'
        ..energyLevel = 'High'
        ..durationSeconds = 60
        ..iconName = 'flash_on',
        
      MicroStrategy()
        ..title = '3-2-1 Blast Off'
        ..description = 'Quick transition helper.'
        ..content = 'Use this for transitions (e.g., books away).\n1. Teacher counts down "3... 2... 1..."\n2. Students must be in "Blast Off" pose (seated, hands folded) by 0.\n3. Reward the fastest row/group.'
        ..category = 'Transition'
        ..energyLevel = 'High'
        ..durationSeconds = 30
        ..iconName = 'rocket_launch',
    ];

    await isar.writeTxn(() async {
      await isar.microStrategys.putAll(strategies);
    });
  }

  Future<List<MicroStrategy>> getAllStrategies() async {
    return await isar.microStrategys.where().findAll();
  }
}
