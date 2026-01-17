import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../services/activity_service.dart';
import '../services/locale_service.dart';
import '../widgets/fade_in_wrapper.dart';

class NaliKaliNavigatorScreen extends StatefulWidget {
  const NaliKaliNavigatorScreen({super.key});

  @override
  State<NaliKaliNavigatorScreen> createState() => _NaliKaliNavigatorScreenState();
}

class _NaliKaliNavigatorScreenState extends State<NaliKaliNavigatorScreen> {
  final ActivityService _activityService = ActivityService();
  
  List<Activity> _activities = [];
  List<Activity> _filteredActivities = [];
  bool _isLoading = true;
  String _selectedCategory = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final activities = await _activityService.getAllActivities();
    setState(() {
      _activities = activities;
      _filteredActivities = activities;
      _isLoading = false;
    });
  }

  void _updateFilteredList() {
    setState(() {
      var list = _activities;
      
      // 1. Filter by Category
      if (_selectedCategory != 'All') {
        list = list.where((a) => a.category == _selectedCategory).toList();
      }

      // 2. Filter by Search Query
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        list = list.where((a) {
          final title = _getActivityTitle(a).toLowerCase();
          final desc = _getActivityDesc(a).toLowerCase();
          return title.contains(query) || desc.contains(query);
        }).toList();
      }

      _filteredActivities = list;
    });
  }

  void _filterActivities(String category) {
    _selectedCategory = category;
    _updateFilteredList();
  }

  // --- Localization Helpers ---
  String _l10n(String key) => AppStrings.get(key);

  String _getActivityTitle(Activity activity) {
    final key = 'act_${activity.activityId}_title';
    final val = AppStrings.get(key);
    return val == key ? activity.title : val;
  }

  String _getActivityDesc(Activity activity) {
    final key = 'act_${activity.activityId}_desc';
    final val = AppStrings.get(key);
    // Handle nullable activity.description with a default empty string
    return val == key ? (activity.description ?? '') : val;
  }

  // --- UI Helpers ---
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Math': return Colors.orange;
      case 'Language': return Colors.blue;
      case 'EVS': return Colors.green;
      default: return Colors.grey;
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case 'Math': return _l10n('cat_math');
      case 'Language': return _l10n('cat_lang');
      case 'EVS': return _l10n('cat_evs');
      default: return _l10n('cat_all');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_l10n('nali_kali_title')),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Theme.of(context).colorScheme.surface,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip('All', _l10n('cat_all')),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Math', _l10n('cat_math')),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Language', _l10n('cat_lang')),
                  const SizedBox(width: 8),
                  _buildCategoryChip('EVS', _l10n('cat_evs')),
                  _buildCategoryChip('EVS', _l10n('cat_evs')),
                ],
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: _l10n('Search activities, materials...'),
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                _searchQuery = value;
                _updateFilteredList();
              },
            ),
          ),
          
          // Activity List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredActivities.isEmpty
                    ? Center(
                        child: Text(
                          _l10n('no_activities'),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredActivities.length,
                        itemBuilder: (context, index) {
                          final isLast = index == _filteredActivities.length - 1;
                          return FadeInWrapper(
                            delay: index * 50,
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Timeline Line & Node
                                  Column(
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: _getCategoryColor(_filteredActivities[index].category ?? 'General').withOpacity(0.2),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: _getCategoryColor(_filteredActivities[index].category ?? 'General'),
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${index + 1}',
                                            style: TextStyle(
                                              fontSize: 12, 
                                              fontWeight: FontWeight.bold,
                                              color: _getCategoryColor(_filteredActivities[index].category ?? 'General'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (!isLast)
                                        Expanded(
                                          child: Container(
                                            width: 2,
                                            margin: const EdgeInsets.symmetric(vertical: 4),
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  // Content Card
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 24),
                                      child: _buildActivityCard(_filteredActivities[index]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category, String label) {
    final isSelected = _selectedCategory == category;
    final color = category == 'All' 
        ? Theme.of(context).colorScheme.primary 
        : _getCategoryColor(category);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        _filterActivities(category);
      },
      selectedColor: color.withOpacity(0.2),
      checkmarkColor: color,
      labelStyle: TextStyle(
        color: isSelected ? color : Colors.grey[700],
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? color : Colors.grey[300]!,
        ),
      ),
    );
  }

  Widget _buildActivityCard(Activity activity) {
    // FIX: Provide default value for nullable category
    final category = activity.category ?? 'Math';
    final categoryColor = _getCategoryColor(category);
    final title = _getActivityTitle(activity);
    final desc = _getActivityDesc(activity);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showActivityDetail(activity),
          child: Column(
            children: [
              // Header with Color Strip
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Box
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: categoryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getCategoryIcon(category), // Pass non-nullable category
                        color: categoryColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  // FIX: Pass non-nullable category
                                  _getCategoryLabel(category),
                                  style: TextStyle(
                                    fontSize: 10, 
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.push_pin_outlined, size: 20),
                                color: Colors.grey[400],
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Pinned for offline access!'), duration: Duration(seconds: 1)),
                                  );
                                },
                                tooltip: 'Pin for offline',
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            desc,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Math': return Icons.calculate_rounded;
      case 'Language': return Icons.menu_book_rounded;
      case 'EVS': return Icons.forest_rounded;
      default: return Icons.school_rounded;
    }
  }

  void _showActivityDetail(Activity activity) {
    final title = _getActivityTitle(activity);
    final desc = _getActivityDesc(activity);
    
    // Resolve Materials
    List<String> materials = activity.materialsNeeded ?? [];
    final matKey = 'act_${activity.activityId}_mats';
    final matVal = AppStrings.get(matKey);
    if (matVal != matKey) {
      materials = matVal.split('|');
    }

    // Resolve Instructions
    String instructions = activity.instructions ?? '';
    final instrKey = 'act_${activity.activityId}_instr';
    final instrVal = AppStrings.get(instrKey);
    if (instrVal != instrKey) {
      instructions = instrVal;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            const SizedBox(height: 12),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  // Header
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00695C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Materials Section
                  Text(
                    _l10n('lbl_materials'),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: materials.map((m) => Chip(
                      label: Text(m),
                      backgroundColor: const Color(0xFFE0F2F1),
                      labelStyle: const TextStyle(color: Color(0xFF00695C), fontSize: 12),
                    )).toList(),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Differentiation (Just-in-Time Support for Sunita)
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.amber.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Row(children: [
                            Icon(Icons.lightbulb_outline_rounded, color: Colors.amber.shade900),
                            const SizedBox(width: 12),
                            Text('Teacher Pivot / Differentiation', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber.shade900)),
                         ]),
                         const SizedBox(height: 16),
                         // Struggling Group
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Icon(Icons.group_work_rounded, size: 16, color: Colors.orange),
                             const SizedBox(width: 8),
                             Expanded(child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 const Text('Struggling Group?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                 Text('Use concrete objects (stones). Focus only on single-digit first.', style: TextStyle(fontSize: 12, color: Colors.grey[800])),
                               ],
                             )),
                           ],
                         ),
                         const Divider(height: 24),
                         // Fast Finishers
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Icon(Icons.bolt_rounded, size: 16, color: Colors.green),
                             const SizedBox(width: 8),
                             Expanded(child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 const Text('Fast Finishers (Chaos Control)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                 Text('Assign them as "Peer Tutors" for the struggling group.', style: TextStyle(fontSize: 12, color: Colors.grey[800])),
                               ],
                             )),
                           ],
                         ),
                      ],
                    ),
                  ),

                  // Video DEMO (New Feature)
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(16),
                      // Removed NetworkImage to prevent 404s
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                           color: Colors.white.withOpacity(0.2),
                           shape: BoxShape.circle,
                           border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.play_arrow_rounded, size: 40, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Watch Peer Demo (30s)',
                      style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Instructions Section
                  Text(
                    _l10n('instructions').toUpperCase(), // existing key
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Text(
                      instructions,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Color(0xFF263238),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.check),
                      label: Text(_l10n('btn_mark_complete')),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color(0xFF00695C),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
