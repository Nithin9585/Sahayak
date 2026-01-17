import 'package:flutter/material.dart';
import 'screens/nali_kali_navigator_screen.dart';
import 'screens/enhanced_students_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/offline_indicator.dart';
import 'services/student_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Isar database
  await StudentService.initialize();
  
  runApp(const SahayakApp());
}

class SahayakApp extends StatelessWidget {
  const SahayakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sahayak - Pedagogical Copilot',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          // Primary: Deep Teal (60% - Headers, Navigation)
          primary: const Color(0xFF00695C),
          onPrimary: Colors.white,
          
          // Secondary: Amber/Marigold (10% - CTAs, Mic button)
          secondary: const Color(0xFFFF8F00),
          onSecondary: Colors.white,
          
          // Accent: Soft Teal (Highlights, active states)
          tertiary: const Color(0xFF4DB6AC),
          onTertiary: Colors.white,
          
          // Background: Off-White (30%)
          surface: const Color(0xFFF7F9FA),
          onSurface: const Color(0xFF263238), // Dark Blue-Grey text
          
          // Error states
          error: const Color(0xFFD32F2F),
          onError: Colors.white,
        ),
        useMaterial3: true,
        
        // AppBar styling
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00695C), // Deep Teal
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        
        // FloatingActionButton (Mic button)
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF8F00), // Amber
          foregroundColor: Colors.white,
        ),
        
        // Card styling
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: const Color(0xFF4DB6AC).withOpacity(0.2)),
          ),
        ),
      ),
      home: const MainScaffold(),
      debugShowCheckedModeBanner: false,
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

  static const List<Widget> _screens = <Widget>[
    NaliKaliNavigatorScreen(),
    EnhancedStudentsScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const OfflineIndicator(),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Activities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
