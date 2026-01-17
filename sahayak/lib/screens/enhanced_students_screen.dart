import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';
import '../services/locale_service.dart';
import 'assessment_wizard_screen.dart';
import 'grouping_view_screen.dart';
import 'student_detail_screen.dart';
import '../widgets/fade_in_wrapper.dart';

class EnhancedStudentsScreen extends StatefulWidget {
  const EnhancedStudentsScreen({super.key});

  @override
  State<EnhancedStudentsScreen> createState() => _EnhancedStudentsScreenState();
}

class _EnhancedStudentsScreenState extends State<EnhancedStudentsScreen> {
  final StudentService _studentService = StudentService();
  List<Student> _students = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    setState(() => _isLoading = true);
    try {
      final students = await _studentService.getAllStudents();
      setState(() {
        _students = students;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading students: $e')),
        );
      }
    }
  }

  Future<void> _seedSampleStudents() async {
    setState(() => _isLoading = true);
    final names = ['Ananya', 'Raju', 'Priya', 'Mohan', 'Lakshmi', 'Suresh'];
    final levels = ['Story Level', 'Word Level', 'Beginner Level', 'Paragraph Level', 'Story Level', 'Word Level'];
    
    for (var i = 0; i < names.length; i++) {
       final s = Student()
        ..name = names[i]
        ..age = 8 + (i % 3)
        ..gender = i % 2 == 0 ? 'Female' : 'Male'
        ..readingLevel = levels[i]
        ..createdAt = DateTime.now();
       await _studentService.addStudent(s);
    }
    await _loadStudents();
  }

  void _showAddStudentDialog() {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    String selectedGender = 'Male';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add New Student'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Student Name',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Male', 'Female', 'Other'].map((gender) {
                    return DropdownMenuItem(value: gender, child: Text(gender));
                  }).toList(),
                  onChanged: (value) {
                    setDialogState(() => selectedGender = value!);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty || ageController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }

                final student = Student()
                  ..name = nameController.text
                  ..age = int.tryParse(ageController.text) ?? 0
                  ..gender = selectedGender
                  ..createdAt = DateTime.now();

                await _studentService.addStudent(student);
                if (context.mounted) Navigator.pop(context);
                _loadStudents();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassAnalytics() {
   // Calculate counts
   int levelStory = _students.where((s) => s.readingLevel == 'Story Level').length;
   int levelPara = _students.where((s) => s.readingLevel == 'Paragraph Level').length;
   int levelWord = _students.where((s) => s.readingLevel == 'Word Level').length;
   int levelBeginner = _students.where((s) => s.readingLevel == 'Beginner Level' || s.readingLevel == null).length;
   int total = _students.length;
   
   // if (total == 0) return const SizedBox.shrink(); // Disabled to show chart always

   return Container(
     margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
     padding: const EdgeInsets.all(16),
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(16),
       boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 4, offset:const Offset(0,2))],
     ),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
          const Text('Class Reading Levels', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Row(
               children: [
                 _buildBarSegment(levelStory, total, Colors.green),
                 _buildBarSegment(levelPara, total, Colors.lightGreen),
                 _buildBarSegment(levelWord, total, Colors.orange),
                 _buildBarSegment(levelBeginner, total, Colors.redAccent),
               ],
            ),
          ),
          const SizedBox(height: 12),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLegend('Story', levelStory, Colors.green),
              _buildLegend('Para', levelPara, Colors.lightGreen),
              _buildLegend('Word', levelWord, Colors.orange),
              _buildLegend('Start', levelBeginner, Colors.redAccent),
            ],
          )
       ],
     ),
   );
 }

 Widget _buildBarSegment(int count, int total, Color color) {
    if (count == 0) return const SizedBox.shrink();
    return Expanded(
      flex: count,
      child: Container(
        height: 16,
        color: color,
      ),
    ); 
 }
 
 Widget _buildLegend(String label, int count, Color color) {
   return Row(
     children: [
       CircleAvatar(radius: 4, backgroundColor: color),
       const SizedBox(width: 4),
       Text('$label: $count', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
     ],
   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('students_title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_upload_rounded),
            onPressed: _seedSampleStudents, // New Function
            tooltip: 'Seed Sample Data',
          ),
          IconButton(
            icon: const Icon(Icons.view_list_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GroupingViewScreen(),
                ),
              );
            },
            tooltip: 'View Groups',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column( // Always show column
                  children: [
                    _buildClassAnalytics(), // Show this always
                    Expanded(
                      child: _students.isEmpty 
                        ? Center(child: Text('Add students to see analytics'))
                        : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _students.length,
                        itemBuilder: (context, index) {
                          final student = _students[index];
                          return FadeInWrapper(
                            delay: index * 100,
                            child: _buildStudentCard(student),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddStudentDialog,
        child: const Icon(Icons.add_rounded),
        tooltip: AppStrings.get('btn_add_student'),
      ),
    );
  }

  Widget _buildStudentCard(Student student) {
    final hasAssessment = student.readingLevel != null || student.mathLevel != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
               builder: (context) => StudentDetailScreen(student: student),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundColor: hasAssessment
              ? Theme.of(context).colorScheme.tertiary
              : Colors.grey[300],
          child: Text(
            student.name[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          student.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: hasAssessment
            ? Text(
                'Reading: ${student.readingLevel ?? "—"} | Math: ${student.mathLevel ?? "—"}',
                style: const TextStyle(fontSize: 12),
              )
            : const Text(
                'Not assessed yet',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
        trailing: IconButton(
          icon: Icon(
            hasAssessment ? Icons.edit_rounded : Icons.assignment_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssessmentWizardScreen(student: student),
              ),
            );
            if (result == true) {
              _loadStudents();
            }
          },
          tooltip: hasAssessment ? 'Edit Assessment' : 'Start Assessment',
        ),
      ),
    );
  }
}
