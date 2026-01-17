import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';

class GroupingViewScreen extends StatefulWidget {
  const GroupingViewScreen({super.key});

  @override
  State<GroupingViewScreen> createState() => _GroupingViewScreenState();
}

class _GroupingViewScreenState extends State<GroupingViewScreen> {
  final StudentService _studentService = StudentService();
  String _selectedSubject = 'Reading';
  Map<String, List<Student>> _groups = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    setState(() => _isLoading = true);
    final groups = _selectedSubject == 'Reading'
        ? await _studentService.getStudentsByReadingLevel()
        : await _studentService.getStudentsByMathLevel();
    setState(() {
      _groups = groups;
      _isLoading = false;
    });
  }

  void _switchSubject(String subject) {
    setState(() => _selectedSubject = subject);
    _loadGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Groups (TaRL)'),
      ),
      body: Column(
        children: [
          // Subject Toggle
          Container(
            padding: const EdgeInsets.all(16),
            child: SegmentedButton<String>(
              selected: {_selectedSubject},
              onSelectionChanged: (Set<String> newSelection) {
                _switchSubject(newSelection.first);
              },
              segments: const [
                ButtonSegment(
                  value: 'Reading',
                  label: Text('Reading'),
                  icon: Icon(Icons.book),
                ),
                ButtonSegment(
                  value: 'Math',
                  label: Text('Math'),
                  icon: Icon(Icons.calculate),
                ),
              ],
            ),
          ),

          // Groups List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _groups.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.groups_outlined,
                              size: 80,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No assessed students yet',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _groups.keys.length,
                        itemBuilder: (context, index) {
                          final level = _groups.keys.elementAt(index);
                          final students = _groups[level]!;
                          return _buildGroupCard(level, students);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(String level, List<Student> students) {
    final color = _getLevelColor(level);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(
            students.length.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          '$level Level Group',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${students.length} student${students.length != 1 ? "s" : ""}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        children: [
          if (students.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Students List
                  ...students.map((student) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: color.withOpacity(0.2),
                            child: Text(
                              student.name[0].toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                color: color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              student.name,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          Text(
                            '${student.age} yrs',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const Divider(height: 24),

                  // Recommended Activity
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Colors.blue.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recommended Activity:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _getRecommendedActivity(level),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color _getLevelColor(String level) {
    final colorMap = {
      'Beginner': const Color(0xFFE57373),
      'Letter': const Color(0xFFFFB74D),
      'Word': const Color(0xFFFFD54F),
      'Paragraph': const Color(0xFF81C784),
      'Story': const Color(0xFF66BB6A),
      'Recognition': const Color(0xFFE57373),
      'Comparison': const Color(0xFFFFB74D),
      'Addition': const Color(0xFFFFD54F),
      'Subtraction': const Color(0xFF81C784),
      'Division': const Color(0xFF66BB6A),
    };
    return colorMap[level] ?? Colors.grey;
  }

  String _getRecommendedActivity(String level) {
    final recommendationMap = {
      // Reading
      'Beginner': 'Letter flashcard recognition games',
      'Letter': 'Sand writing practice for letter formation',
      'Word': 'Simple word matching with picture cards',
      'Paragraph': 'Guided reading with peer support',
      'Story': 'Independent reading with comprehension questions',
      
      // Math
      'Recognition': 'Number card games (1-9)',
      'Comparison': 'Bigger/Smaller sorting activities',
      'Addition': 'Tamarind seed counting games',
      'Subtraction': 'Take-away games with objects',
      'Division': 'Bundle and Sticks division activities',
      
      'Unassessed': 'Complete assessment first',
    };
    return recommendationMap[level] ?? 'Group activities based on current level';
  }
}
