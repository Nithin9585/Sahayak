import 'package:flutter/material.dart';

class ActivityDetailScreen extends StatefulWidget {
  final Map<String, dynamic> activity;

  const ActivityDetailScreen({super.key, required this.activity});

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  bool isCached = false;

  @override
  void initState() {
    super.initState();
    isCached = widget.activity['isCached'] ?? false;
  }

  void _toggleCache() {
    setState(() {
      isCached = !isCached;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCached 
              ? 'Activity pinned for offline access' 
              : 'Removed from offline cache',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final materials = widget.activity['materialsNeeded'] as List;
    final instructions = widget.activity['instructions'] as List;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity['title']),
        actions: [
          IconButton(
            icon: Icon(
              isCached ? Icons.offline_pin : Icons.cloud_download,
              color: isCached ? Colors.white : Colors.white70,
            ),
            onPressed: _toggleCache,
            tooltip: isCached ? 'Remove from offline' : 'Pin for offline',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Activity Image
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[200],
              child: Image.network(
                widget.activity['imageUrl'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Text(
                    widget.activity['description'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Meta Information Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          Icons.timer,
                          '${widget.activity['duration']} min',
                          'Duration',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          Icons.groups,
                          widget.activity['groupType'].toString().split(' ')[0],
                          'Group Type',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Materials Needed Section
                  _buildSectionHeader('Materials Needed'),
                  const SizedBox(height: 12),
                  ...materials.map((material) => _buildMaterialItem(material)).toList(),
                  const SizedBox(height: 24),

                  // Instructions Section
                  _buildSectionHeader('Instructions'),
                  const SizedBox(height: 12),
                  ...instructions.asMap().entries.map((entry) {
                    return _buildInstructionItem(entry.key + 1, entry.value);
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String value, String label) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildMaterialItem(String material) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              material,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(int step, String instruction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            child: Text(
              step.toString(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              instruction,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
