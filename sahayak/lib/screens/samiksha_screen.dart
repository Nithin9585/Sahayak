import 'package:flutter/material.dart';
import '../widgets/fade_in_wrapper.dart';
import '../services/locale_service.dart';

class SamikshaScreen extends StatefulWidget {
  const SamikshaScreen({super.key});

  @override
  State<SamikshaScreen> createState() => _SamikshaScreenState();
}

class _SamikshaScreenState extends State<SamikshaScreen> {
  // Rubric Data
  double _engagementLevel = 3;
  double _understandingLevel = 3;
  double _chaosLevel = 2;
  
  final TextEditingController _journalController = TextEditingController();
  
  final List<String> _tags = [
    'Visual Aids', 'Group Work', 'Storytelling', 'Tablet Activity'
  ];
  final Set<String> _selectedTags = {};

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Samiksha (Reflection)'),
          backgroundColor: Colors.purple.shade50,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'New Entry'),
              Tab(text: 'My Growth'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reflection saved successfully!')),
                );
              },
              child: const Text('SAVE', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildNewEntryForm(context),
            _buildHistoryView(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryView(BuildContext context) {
    // Mock Data for 7 days
    final history = [
      {'day': 'Mon', 'score': 3.0, 'engaged': 2.0},
      {'day': 'Tue', 'score': 3.5, 'engaged': 3.0},
      {'day': 'Wed', 'score': 4.0, 'engaged': 4.0},
      {'day': 'Thu', 'score': 3.0, 'engaged': 3.0},
      {'day': 'Fri', 'score': 4.5, 'engaged': 5.0},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Weekly Engagement Trend', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: history.map((item) {
              final height = (item['engaged'] as double) * 25; // Reduced from 30 to fit
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 30,
                    height: height,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(item['day'] as String, style: const TextStyle(fontSize: 12)),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        const Text('Past Reflections', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...List.generate(3, (i) => Card(
          elevation: 0,
          color: Colors.grey.shade50,
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.purple, child: Icon(Icons.check, color: Colors.white, size: 16)),
            title: Text('Reflection #${10 - i}'),
            subtitle: Text('Engagement: 4/5 • Understanding: 3/5'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          ),
        )),
      ],
    );
  }

  Widget _buildNewEntryForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Date
          FadeInWrapper(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, color: Colors.purple),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Class',
                        style: TextStyle(color: Colors.purple.shade900, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateTime.now().toString().split(' ')[0], // Simple date
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Rubrics Section
          const FadeInWrapper(
            delay: 100,
            child: Text(
              'Classroom Dynamics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          
          FadeInWrapper(
            delay: 200,
            child: _buildRubricSlider(
              'Student Engagement',
              'Low', 'High',
              _engagementLevel,
              Colors.blue,
              (val) => setState(() => _engagementLevel = val),
            ),
          ),
          FadeInWrapper(
            delay: 300,
            child: _buildRubricSlider(
              'Concept Understanding',
              'Confused', 'Clear',
              _understandingLevel,
              Colors.green,
              (val) => setState(() => _understandingLevel = val),
            ),
          ),
          FadeInWrapper(
            delay: 400,
            child: _buildRubricSlider(
              'Classroom Chaos/Noise',
              'Calm', 'Noisy',
              _chaosLevel,
              Colors.orange,
              (val) => setState(() => _chaosLevel = val),
            ),
          ),

          const SizedBox(height: 24),

          // Methods Used Tags
          const FadeInWrapper(
            delay: 500,
            child: Text(
              'Methods Used Today',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          FadeInWrapper(
            delay: 550,
            child: Wrap(
              spacing: 8,
              children: _tags.map((tag) {
                final isSelected = _selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                    });
                  },
                  selectedColor: Colors.purple.shade100,
                  checkmarkColor: Colors.purple,
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 24),

          // Journal Entry
          const FadeInWrapper(
            delay: 600,
            child: Text(
              'Journal / Voice Note',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          FadeInWrapper(
            delay: 650,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  TextField(
                    controller: _journalController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Write about a specific success or challenge...',
                      border: InputBorder.none,
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text('Voice recording started...')),
                           );
                        },
                        icon: const Icon(Icons.mic_rounded, color: Colors.purple),
                        label: const Text('Record Voice Note', style: TextStyle(color: Colors.purple)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildRubricSlider(
    String title, 
    String minLabel, 
    String maxLabel, 
    double value, 
    Color color,
    ValueChanged<double> onChanged,
  ) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade100),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    value.round().toString(),
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(minLabel, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                Expanded(
                  child: Slider(
                    value: value,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    activeColor: color,
                    label: value.round().toString(),
                    onChanged: onChanged,
                  ),
                ),
                Text(maxLabel, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
