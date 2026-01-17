import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    child: Text(
                      student.name[0], 
                      style: TextStyle(fontSize: 40, color: Theme.of(context).colorScheme.primary)
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(student.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('${student.age} Years • ${student.gender}'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Current Standing
            const Text('Current Standing', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatusCard(context, 'Reading', student.readingLevel ?? 'Not Assessed', Colors.orange)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatusCard(context, 'Math', student.mathLevel ?? 'Not Assessed', Colors.blue)),
              ],
            ),

            const SizedBox(height: 32),

            // AI Recommendations
            const Text('Recommended Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (student.readingLevel == null)
              _buildActionCard(
                icon: Icons.assignment_late_rounded,
                title: 'Assess Reading Level',
                subtitle: 'Student has not been assessed yet.',
                color: Colors.red,
              )
            else
              _buildRemedialAction(student.readingLevel!),

          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, String subject, String level, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subject, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(level, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRemedialAction(String level) {
    String title = '';
    String subtitle = '';
    Color color = Colors.green;

    switch (level) {
      case 'Beginner Level':
        title = 'Teach Letter Recognition';
        subtitle = 'Use Flashcards and Sand Tracing for basic alphabet.';
        color = Colors.red;
        break;
      case 'Letter Level':
        title = 'Word Formation Game';
        subtitle = 'Combine letters to form simple 2-letter words.';
        color = Colors.orange;
        break;
      case 'Word Level':
        title = 'Paragraph Reading';
        subtitle = 'Practice with 4-line stories. Focus on flow.';
        color = Colors.amber;
        break;
      case 'Paragraph Level':
        title = 'Story Comprehension';
        subtitle = 'Read full story and ask "Why/How" questions.';
        color = Colors.blue;
        break;
      case 'Story Level':
        title = 'Advanced Writing';
        subtitle = 'Encourage creative writing and essays.';
        color = Colors.green;
        break;
      default:
        title = 'General Review';
        subtitle = 'Review basics.';
    }

    return _buildActionCard(
      icon: Icons.lightbulb_rounded,
      title: title,
      subtitle: subtitle,
      color: color,
    );
  }

  Widget _buildActionCard({required IconData icon, required String title, required String subtitle, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade100, blurRadius: 8, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
