import 'package:flutter/material.dart';
import '../services/locale_service.dart';
import 'home_screen.dart'; // To navigate to home
import '../main.dart'; // To navigate to MainScaffold

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const OnboardingScreen({super.key, required this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                   _buildLanguagePage(),
                   _buildWelcomePage(),
                   _buildRolePage(),
                ],
              ),
            ),
            
            // Bottom Controls
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Indicator
                  Row(
                    children: List.generate(3, (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? const Color(0xFF00695C) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    )),
                  ),
                  
                  // Action Button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < 2) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        widget.onFinish();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00695C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    child: Text(_currentPage == 2 ? 'GET STARTED' : 'NEXT'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguagePage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.language, size: 80, color: Color(0xFF00695C)),
          const SizedBox(height: 32),
          const Text(
            'Namaste! Welcome to Sahayak.',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Please select your preferred language / ದಯವಿಟ್ಟು ನಿಮ್ಮ ಭಾಷೆಯನ್ನು ಆರಿಸಿ',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 48),
          _buildLangOption('English', 'en'),
          const SizedBox(height: 16),
          _buildLangOption('ಕನ್ನಡ (Kannada)', 'kn'),
        ],
      ),
    );
  }

  Widget _buildLangOption(String label, String code) {
    final isSelected = appLocaleNotifier.value.languageCode == code;
    return InkWell(
      onTap: () {
        appLocaleNotifier.value = Locale(code);
        setState(() {}); // refresh UI
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00695C).withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF00695C) : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFF00695C) : Colors.black87,
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF00695C)),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Image.network(
             'https://cdn-icons-png.flaticon.com/512/3429/3429149.png', // Teacher Icon
             height: 150,
             errorBuilder: (c,e,s) => const Icon(Icons.school_rounded, size: 100, color: Colors.orange),
           ),
           const SizedBox(height: 40),
           Text(
             AppStrings.get('app_title') == 'Sahayak' ? 'Your Pedagogical Copilot' : 'ನಿಮ್ಮ ಬೋಧನಾ ಸಹಾಯಕ',
             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
             textAlign: TextAlign.center,
           ),
           const SizedBox(height: 16),
           const Text(
             'Just-in-Time support for Nali Kali, FLN, and Classroom Management.\n\nNow with Offline AI.',
             textAlign: TextAlign.center,
             style: TextStyle(fontSize: 16, color: Colors.grey),
           ),
        ],
      ),
    );
  }

  Widget _buildRolePage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_pin_circle_rounded, size: 80, color: Colors.teal),
          const SizedBox(height: 32),
          const Text(
            'Confirm Role',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          // Mock Profile Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: const Row(
              children: [
                CircleAvatar(child: Text('TR')),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('T. Ramesh', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('GHPS HD Kote • Nali Kali Lead'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          const Text(
             'We have loaded your profile from the ShikshaLokam Registry.',
             textAlign: TextAlign.center,
             style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
