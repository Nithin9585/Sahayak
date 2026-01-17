import 'package:flutter/material.dart';
import '../models/student.dart';
import 'reading_assessment_screen.dart';
import '../data/tarl_rubrics.dart';
import '../services/student_service.dart';
import '../widgets/fade_in_wrapper.dart';

class AssessmentWizardScreen extends StatefulWidget {
  final Student student;

  const AssessmentWizardScreen({super.key, required this.student});

  @override
  State<AssessmentWizardScreen> createState() => _AssessmentWizardScreenState();
}

class _AssessmentWizardScreenState extends State<AssessmentWizardScreen> {
  final StudentService _studentService = StudentService();
  int _currentStep = 0;
  String? _selectedReadingLevel;
  String? _selectedMathLevel;

  @override
  void initState() {
    super.initState();
    _selectedReadingLevel = widget.student.readingLevel;
    _selectedMathLevel = widget.student.mathLevel;
  }

  Future<void> _saveAssessment() async {
    widget.student.readingLevel = _selectedReadingLevel;
    widget.student.mathLevel = _selectedMathLevel;
    widget.student.lastAssessment = DateTime.now();

    await _studentService.updateStudent(widget.student);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Assessment saved successfully!')),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assess: ${widget.student.name}'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 1) {
            setState(() => _currentStep++);
          } else {
            _saveAssessment();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          }
        },
        onStepTapped: (step) => setState(() => _currentStep = step),
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(_currentStep == 1 ? 'Save' : 'Continue'),
                ),
                const SizedBox(width: 12),
                if (_currentStep > 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Back'),
                  ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Reading Assessment'),
            content: _buildReadingAssessment(),
            isActive: _currentStep >= 0,
            state: _currentStep > 0
                ? StepState.complete
                : StepState.indexed,
          ),
          Step(
            title: const Text('Math Assessment'),
            content: _buildMathAssessment(),
            isActive: _currentStep >= 1,
            state: _currentStep > 1
                ? StepState.complete
                : StepState.indexed,
          ),
        ],
      ),
    );
  }

  Widget _buildReadingAssessment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select the highest level the student can perform:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        // Smart Assist Button
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReadingAssessmentScreen(studentName: widget.student.name)),
              );
              if (result != null) {
                setState(() => _selectedReadingLevel = result);
              }
            },
            icon: const Icon(Icons.touch_app_rounded),
            label: const Text('Use Smart Assessor Tool'),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
              foregroundColor: Colors.blue.shade900,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...TaRLRubrics.readingLevels.asMap().entries.map((entry) {
          final index = entry.key;
          final level = entry.value;
          return FadeInWrapper(
            delay: index * 100,
            child: _buildLevelCard(
              level: level['level'],
              description: level['description'],
              assessment: level['assessment'],
              color: Color(level['color']),
              isSelected: _selectedReadingLevel == level['level'],
              onTap: () {
                setState(() => _selectedReadingLevel = level['level']);
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildMathAssessment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select the highest level the student can perform:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        ...TaRLRubrics.mathLevels.asMap().entries.map((entry) {
          final index = entry.key;
          final level = entry.value;
          return FadeInWrapper(
            delay: index * 100,
            child: _buildLevelCard(
              level: level['level'],
              description: level['description'],
              assessment: level['assessment'],
              color: Color(level['color']),
              isSelected: _selectedMathLevel == level['level'],
              onTap: () {
                setState(() => _selectedMathLevel = level['level']);
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLevelCard({
    required String level,
    required String description,
    required String assessment,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? color : Colors.grey[200]!,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected
            ? [BoxShadow(color: color.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))]
            : [],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? color : color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: isSelected
                      ? const Icon(Icons.check_rounded, color: Colors.white)
                      : Text(
                          level[0],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                            fontSize: 18,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? color : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline_rounded, size: 16, color: color),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              assessment,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                height: 1.3,
                              ),
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
      ),
    );
  }
}
