import 'package:flutter/material.dart';
import '../widgets/fade_in_wrapper.dart';

import '../services/locale_service.dart';

class DailyRoutineScreen extends StatefulWidget {
  const DailyRoutineScreen({super.key});

  @override
  State<DailyRoutineScreen> createState() => _DailyRoutineScreenState();
}

class _DailyRoutineScreenState extends State<DailyRoutineScreen> {
  // Weather State
  String _selectedWeather = '';
  final List<Map<String, dynamic>> _weatherOptions = [
    {'label': 'Sunny', 'icon': Icons.wb_sunny_rounded, 'color': Colors.orange},
    {'label': 'Cloudy', 'icon': Icons.cloud_rounded, 'color': Colors.grey},
    {'label': 'Rainy', 'icon': Icons.thunderstorm_rounded, 'color': Colors.blue},
    {'label': 'Windy', 'icon': Icons.air_rounded, 'color': Colors.teal},
  ];

  // Tasks State
  bool _attendanceDone = false;
  bool _slateCleaned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('routine_title')),
        backgroundColor: Colors.orange.shade800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.get('routine_morning_circle'),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              AppStrings.get('routine_subtitle'),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // 1. Weather Chart
            FadeInWrapper(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange.shade100),
                  boxShadow: [
                    BoxShadow(color: Colors.orange.shade50, blurRadius: 20, offset: const Offset(0, 8))
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      AppStrings.get('routine_weather_q'),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                       alignment: WrapAlignment.center,
                      children: _weatherOptions.map((w) {
                        final isSelected = _selectedWeather == w['label'];
                        return GestureDetector(
                          onTap: () => setState(() => _selectedWeather = w['label']),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 80,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: isSelected ? w['color'].withOpacity(0.1) : Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? w['color'] : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  w['icon'],
                                  size: 32,
                                  color: isSelected ? w['color'] : Colors.grey.shade400,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  w['label'], // These labels might need translation too, but I'll leave them for now as they are basic english/visuals
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? w['color'] : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),

            // 2. Checklist
            FadeInWrapper(
              delay: 100,
              child: Column(
                children: [
                  _buildChecklistItem(
                    title: AppStrings.get('routine_attendance'),
                    subtitle: AppStrings.get('routine_attendance_sub'),
                    isDone: _attendanceDone,
                    icon: Icons.people_alt_rounded,
                    onTap: () => setState(() => _attendanceDone = !_attendanceDone),
                  ),
                  const SizedBox(height: 16),
                  _buildChecklistItem(
                    title: AppStrings.get('routine_slate'),
                    subtitle: AppStrings.get('routine_slate_sub'),
                    isDone: _slateCleaned,
                    icon: Icons.edit_note_rounded,
                    onTap: () => setState(() => _slateCleaned = !_slateCleaned),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (_selectedWeather.isNotEmpty && _attendanceDone) 
                    ? () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text('${AppStrings.get("routine_complete")}!'))
                        );
                      }
                    : null,
                icon: const Icon(Icons.check_circle_rounded),
                label: Text(AppStrings.get('routine_complete')),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade200,
                  disabledForegroundColor: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem({
    required String title,
    required String subtitle,
    required bool isDone,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDone ? Colors.green.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDone ? Colors.green.shade200 : Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDone ? Colors.green.shade100 : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: isDone ? Colors.green : Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                      color: isDone ? Colors.green.shade900 : Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            if (isDone)
              const Icon(Icons.check_circle, color: Colors.green)
            else
              Icon(Icons.circle_outlined, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}
