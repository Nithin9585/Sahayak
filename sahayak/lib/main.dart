import 'package:flutter/material.dart';
import 'screens/nali_kali_navigator_screen.dart';
import 'screens/enhanced_students_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/home_screen.dart'; // Import Home
import 'screens/onboarding_screen.dart';
import 'widgets/offline_indicator.dart';
import 'services/student_service.dart';
import 'services/activity_service.dart';
import 'services/locale_service.dart';
import 'services/strategy_service.dart'; // Import Strategy Service
import 'package:isar/isar.dart';
import 'models/student.dart';
import 'models/activity.dart';
import 'models/micro_strategy.dart'; // Import Model
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Isar database with all schemas
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [StudentSchema, ActivitySchema, MicroStrategySchema], // Add Strategy Schema
    directory: dir.path,
  );
  
  // Assign to services
  StudentService.isar = isar;
  ActivityService.isar = isar;
  StrategyService.isar = isar;
  
  // Seed data on first launch
  final activityService = ActivityService();
  await activityService.seedActivities();

  final strategyService = StrategyService();
  await strategyService.seedStrategies();
  
  runApp(const SahayakApp());
}

class SahayakApp extends StatefulWidget {
  const SahayakApp({super.key});

  @override
  State<SahayakApp> createState() => _SahayakAppState();
}

class _SahayakAppState extends State<SahayakApp> {
  bool _showOnboarding = true; // In a real app, check SharedPreferences

  @override
  Widget build(BuildContext context) {
    // Listen to language changes
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocaleNotifier,
      builder: (context, locale, child) {
        return MaterialApp(
          title: 'Sahayak - Pedagogical Copilot',
          locale: locale,
          supportedLocales: const [
             Locale('en'),
             Locale('kn'),
          ],
          localizationsDelegates: const [
             GlobalMaterialLocalizations.delegate,
             GlobalWidgetsLocalizations.delegate,
             GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF00695C),
              onPrimary: Colors.white,
              secondary: const Color(0xFFFF8F00),
              onSecondary: Colors.white,
              tertiary: const Color(0xFF4DB6AC),
              onTertiary: Colors.white,
              surface: const Color(0xFFF7F9FA),
              onSurface: const Color(0xFF263238),
              error: const Color(0xFFD32F2F),
              onError: Colors.white,
            ),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF00695C),
              foregroundColor: Colors.white,
              elevation: 0, 
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFFFF8F00),
              foregroundColor: Colors.white,
            ),
            cardTheme: CardThemeData(
              color: Colors.white,
              elevation: 0, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.withOpacity(0.1)),
              ),
            ),
          ),
          home: _showOnboarding 
            ? OnboardingScreen(onFinish: () => setState(() => _showOnboarding = false))
            : MainScaffold(key: ValueKey(locale)), 
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define screens here to ensure they rebuild with new locale
    final List<Widget> screens = [
      HomeScreen(
        onNavigateToActivities: () => _navigateToTab(1),
        onNavigateToStudents: () => _navigateToTab(2),
      ),
      const NaliKaliNavigatorScreen(),
      const EnhancedStudentsScreen(),
      const ChatScreen(),
      const ProfileScreen(),
    ];

    // Note: We need 5 items in BottomNavBar or map them.
    // Let's hide the "Home" tab from the bar if we want, or add it.
    // Adding 5th tab is crowded. 
    // Plan: 
    // 0: Home 
    // 1: Activities 
    // 2: Students
    // 3: Assistant
    // 4: Profile
    
    return Scaffold(
      body: Column(
        children: [
          const OfflineIndicator(),
          Expanded(child: screens[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: AppStrings.get('nav_home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.auto_stories_rounded),
            label: AppStrings.get('nav_activities'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.groups_rounded),
            label: AppStrings.get('nav_students'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.assistant_rounded),
            label: AppStrings.get('nav_chat'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_rounded),
            label: AppStrings.get('nav_profile'),
          ),
        ],
      ),
    );
  }
}
