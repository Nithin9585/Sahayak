import 'package:flutter/material.dart';
import '../data/nali_kali_sample_data.dart';
import 'activity_detail_screen.dart';

class NaliKaliNavigatorScreen extends StatefulWidget {
  const NaliKaliNavigatorScreen({super.key});

  @override
  State<NaliKaliNavigatorScreen> createState() => _NaliKaliNavigatorScreenState();
}

class _NaliKaliNavigatorScreenState extends State<NaliKaliNavigatorScreen> {
  String selectedCategory = 'All';

  List<Map<String, dynamic>> get filteredActivities {
    if (selectedCategory == 'All') {
      return naliKaliActivities;
    }
    return naliKaliActivities
        .where((milestone) => milestone['category'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nali Kali Activities'),
      ),
      body: Column(
        children: [
          // Category Filter Chips
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip('All'),
                  _buildCategoryChip('Math'),
                  _buildCategoryChip('Language'),
                  _buildCategoryChip('EVS'),
                ],
              ),
            ),
          ),
          
          // Activity List
          Expanded(
            child: filteredActivities.isEmpty
                ? Center(
                    child: Text(
                      'No activities in this category',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredActivities.length,
                    itemBuilder: (context, index) {
                      final milestone = filteredActivities[index];
                      return _buildMilestoneCard(milestone);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedCategory = category;
          });
        },
        backgroundColor: Colors.white,
        selectedColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
        checkmarkColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildMilestoneCard(Map<String, dynamic> milestone) {
    final activities = milestone['activities'] as List;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getCategoryColor(milestone['category']),
          child: Text(
            milestone['category'][0],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          milestone['milestone'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${activities.length} activities',
          style: TextStyle(color: Colors.grey[600]),
        ),
        children: activities.map((activity) {
          return _buildActivityTile(activity);
        }).toList(),
      ),
    );
  }

  Widget _buildActivityTile(Map<String, dynamic> activity) {
    return ListTile(
      leading: Icon(
        Icons.auto_stories,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(activity['title']),
      subtitle: Text(
        '${activity['duration']} min • ${activity['groupType']}',
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: activity['isCached']
          ? const Icon(Icons.offline_pin, color: Colors.green, size: 20)
          : const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityDetailScreen(activity: activity),
          ),
        );
      },
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Math':
        return Colors.blue;
      case 'Language':
        return Colors.purple;
      case 'EVS':
        return Colors.green;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }
}
