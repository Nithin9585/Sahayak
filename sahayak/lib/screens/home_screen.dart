import 'package:flutter/material.dart';
import '../services/locale_service.dart';
import '../services/strategy_service.dart';
import '../models/micro_strategy.dart';
import 'package:isar/isar.dart';
import 'mentor_connect_screen.dart';
import 'samiksha_screen.dart';
import 'daily_routine_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onNavigateToActivities;
  final VoidCallback onNavigateToStudents;

  const HomeScreen({
    super.key,
    required this.onNavigateToActivities,
    required this.onNavigateToStudents,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StrategyService _strategyService = StrategyService();
  List<MicroStrategy> _strategies = [];

  @override
  void initState() {
    super.initState();
    _loadStrategies();
  }

  Future<void> _loadStrategies() async {
    final strategies = await _strategyService.getAllStrategies();
    setState(() {
      _strategies = strategies;
    });
  }

  // Helper to lookup dynamic strategy content
  String _l10n(String key) {
    return AppStrings.get(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.get('welcome'),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            Text(
              AppStrings.get('teacher_name'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.support_agent_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MentorConnectScreen()),
              );
            },
            tooltip: 'Mentor Connect',
          ),
          IconButton(
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 0. Daily Prompt (New Feature)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DailyRoutineScreen()),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                     const Icon(Icons.wb_sunny_rounded, color: Colors.orange, size: 32),
                     const SizedBox(width: 16),
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             "Good Morning!",
                             style: TextStyle(fontSize: 10, color: Colors.orange.shade800, fontWeight: FontWeight.bold),
                           ),
                           const SizedBox(height: 2),
                           Text(
                             "Tap to update Weather Chart & Attendance",
                             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.brown.shade800),
                           ),
                         ],
                       ),
                     ),
                     Icon(Icons.chevron_right_rounded, color: Colors.orange.shade800),
                  ],
                ),
              ),
            ),

            // 1. Hero Card (Micro-Strategy Spotlight)
            _buildSectionHeader(AppStrings.get('home_quick_intervention')),
            if (_strategies.isNotEmpty)
              _buildStrategyCard(_strategies.first)
            else
              const Center(child: CircularProgressIndicator()),
            
            const SizedBox(height: 24),

            // 1.5 Classroom Pulse (TinyML Monitor)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.teal.shade100),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.graphic_eq_rounded, color: Colors.teal),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Classroom Pulse',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Ambient Noise: Low (Focused Work)',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Switch(value: true, onChanged: (_) {}, activeColor: Colors.teal),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 2. Main Tools Grid
            _buildSectionHeader(AppStrings.get('home_pedagogical_tools')),
            LayoutBuilder(
              builder: (context, constraints) {
                final double cardWidth = (constraints.maxWidth - 16) / 2; // 16 is gap
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: _buildToolCard(
                        context,
                        title: AppStrings.get('tool_nk_nav'),
                        icon: Icons.school_rounded,
                        color: Colors.orange,
                        onTap: widget.onNavigateToActivities,
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildToolCard(
                        context,
                        title: AppStrings.get('tool_tarl_acc'),
                        icon: Icons.insights_rounded,
                        color: Colors.blue,
                        onTap: widget.onNavigateToStudents,
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _buildToolCard(
                        context,
                        title: 'Samiksha\n(Reflection)',
                        icon: Icons.self_improvement_rounded,
                        color: Colors.purple,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SamikshaScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 24),

            // 3. Micro-Strategies Library
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionHeader(AppStrings.get('home_micro_strategies')),
                TextButton(
                  onPressed: () {
                    // Navigate to full strategy list
                  },
                  child: Text(AppStrings.get('home_view_all')),
                ),
              ],
            ),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _strategies.length,
                itemBuilder: (context, index) {
                  return _buildMiniStrategyCard(_strategies[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildStrategyCard(MicroStrategy strategy) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showStrategyDialog(context, strategy),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.mic_rounded, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.get('home_featured'),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _l10n(strategy.title),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _l10n('${strategy.title}_desc'),
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.play_circle_filled_rounded, color: Colors.white, size: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMiniStrategyCard(MicroStrategy strategy) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: InkWell(
        onTap: () => _showStrategyDialog(context, strategy),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    _getIcon(strategy.iconName),
                    color: Colors.grey[700],
                    size: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: strategy.energyLevel == 'High' 
                          ? Colors.orange[50] 
                          : Colors.purple[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      strategy.energyLevel,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: strategy.energyLevel == 'High' 
                            ? Colors.orange 
                            : Colors.purple,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                _l10n(strategy.title),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${strategy.durationSeconds ~/ 60} ${AppStrings.get("mins")}',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'accessibility_new': return Icons.nightlight_round;
      case 'sports_baseball': return Icons.sports_volleyball_rounded;
      case 'flash_on': return Icons.thunderstorm_rounded;
      case 'rocket_launch': return Icons.rocket_launch_rounded;
      default: return Icons.lightbulb_rounded;
    }
  }

  void _showStrategyDialog(BuildContext context, MicroStrategy strategy) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(_getIcon(strategy.iconName), size: 32, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    _l10n(strategy.title),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDetailItem(Icons.timer_rounded, '${strategy.durationSeconds ~/ 60} ${AppStrings.get("mins")}'),
                  _buildDetailItem(Icons.bolt_rounded, '${strategy.energyLevel} ${AppStrings.get("energy")}'),
                  _buildDetailItem(Icons.category_rounded, strategy.category),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.get('instructions'),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _l10n('${strategy.title}_content'),
                  style: const TextStyle(fontSize: 16, height: 1.6),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check_circle_rounded),
                label: Text(AppStrings.get('strategy_deployed')),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
