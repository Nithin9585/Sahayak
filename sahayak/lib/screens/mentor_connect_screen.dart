import 'package:flutter/material.dart';
import '../services/locale_service.dart';
import '../widgets/fade_in_wrapper.dart';

class MentorConnectScreen extends StatelessWidget {
  const MentorConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentor Connect'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInWrapper(
              child: _buildMentorCard(
                context,
                name: 'Dr. Ramesh Rao',
                expertise: 'FLN Specialist',
                status: 'Available',
                imageColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            FadeInWrapper(
              delay: 100,
              child: _buildMentorCard(
                context,
                name: 'Smt. Lakshmi Devi',
                expertise: 'Inclusive Education',
                status: 'Busy',
                imageColor: Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
             FadeInWrapper(
              delay: 200,
              child: _buildMentorCard(
                context,
                name: 'Mr. John D\'Souza',
                expertise: 'Math Pedagogy',
                status: 'Offline',
                imageColor: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            const FadeInWrapper(
              delay: 300,
              child: Text(
                'Recent Escalations',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            FadeInWrapper(
              delay: 400,
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.history_edu_rounded, color: Colors.amber),
                  title: const Text('Grade 3 Subtraction Issues'),
                  subtitle: const Text('Resolved by Dr. Rao • 2 days ago'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMentorCard(
    BuildContext context, {
    required String name,
    required String expertise,
    required String status,
    required Color imageColor,
  }) {
    final isAvailable = status == 'Available';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: imageColor.withOpacity(0.2),
                  child: Text(
                    name[0],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: imageColor,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: isAvailable ? Colors.green : (status == 'Busy' ? Colors.orange : Colors.grey),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    expertise,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: isAvailable ? () => _showBookingSheet(context, name) : null,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(12),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: const Icon(Icons.call_rounded, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingSheet(BuildContext context, String mentorName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 500,
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
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Book a Session with $mentorName',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Select a time slot for a 15-minute video call.'),
            const SizedBox(height: 24),
            
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final time = '${9 + index}:00 ${index < 3 ? 'AM' : 'PM'}';
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        time,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Session booked with $mentorName!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('CONFIRM BOOKING'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
