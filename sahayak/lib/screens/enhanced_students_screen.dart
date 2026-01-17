import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';
import 'assessment_wizard_screen.dart';
import 'grouping_view_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.view_list),
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
          : _students.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 100,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No students added yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap + to add your first student',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _students.length,
                  itemBuilder: (context, index) {
                    final student = _students[index];
                    return _buildStudentCard(student);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddStudentDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStudentCard(Student student) {
    final hasAssessment = student.readingLevel != null || student.mathLevel != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
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
            hasAssessment ? Icons.edit : Icons.assignment,
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
