import 'package:flutter/material.dart';
import '../models/student.dart';
import '../data/tarl_rubrics.dart';
import '../services/student_service.dart';

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
        ...TaRLRubrics.readingLevels.map((level) {
          return _buildLevelCard(
            level: level['level'],
            description: level['description'],
            assessment: level['assessment'],
            color: Color(level['color']),
            isSelected: _selectedReadingLevel == level['level'],
            onTap: () {
              setState(() => _selectedReadingLevel = level['level']);
            },
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
        ...TaRLRubrics.mathLevels.map((level) {
          return _buildLevelCard(
            level: level['level'],
            description: level['description'],
            assessment: level['assessment'],
            color: Color(level['color']),
            isSelected: _selectedMathLevel == level['level'],
            onTap: () {
              setState(() => _selectedMathLevel = level['level']);
            },
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
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color, width: 2),
                ),
                child: isSelected
                    ? Icon(Icons.check, color: color)
                    : null,
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
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, size: 16, color: color),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              assessment,
                              style: TextStyle(
                                fontSize: 12,
                                color: color.withOpacity(0.8),
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
