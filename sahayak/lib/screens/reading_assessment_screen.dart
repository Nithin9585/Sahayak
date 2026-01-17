import 'package:flutter/material.dart';
import '../widgets/fade_in_wrapper.dart';

import '../services/locale_service.dart';

class ReadingAssessmentScreen extends StatefulWidget {
  final String studentName;
  const ReadingAssessmentScreen({super.key, required this.studentName});

  @override
  State<ReadingAssessmentScreen> createState() => _ReadingAssessmentScreenState();
}

class _ReadingAssessmentScreenState extends State<ReadingAssessmentScreen> {
  // Sample paragraphs for testing
  final String _passage = "Raju has a little dog. The dog likes to play with a ball. One day, the ball fell into the water.";
  late List<String> _words;
  late List<bool> _isError; // true if word was misread
  
  @override
  void initState() {
    super.initState();
    _words = _passage.split(' ');
    _isError = List.filled(_words.length, false);
  }

  int get _errorCount => _isError.where((e) => e).length;
  int get _totalWords => _words.length;
  double get _accuracy => ((_totalWords - _errorCount) / _totalWords) * 100;

  String get _calculatedLevel {
    if (_accuracy > 90) return 'Story Level';
    if (_accuracy > 70) return 'Paragraph Level';
    if (_accuracy > 40) return 'Word Level';
    return 'Beginner Level';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppStrings.get('assess_title')}: ${widget.studentName}'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. Instruction Header
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                const Icon(Icons.touch_app_rounded, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    AppStrings.get('assess_instruction'),
                    style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),

          // 2. The Passage (Interactive)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: List.generate(_words.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _isError[index] = !_isError[index];
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: _isError[index] ? Colors.red.shade100 : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: _isError[index] 
                              ? Border.all(color: Colors.red) 
                              : Border.all(color: Colors.transparent),
                        ),
                        child: Text(
                          _words[index],
                          style: TextStyle(
                            fontSize: 24,
                            height: 1.5,
                            color: _isError[index] ? Colors.red.shade900 : Colors.black87,
                            decoration: _isError[index] ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),

          // 3. Live Stats & Result
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -4),
                  blurRadius: 16,
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat(AppStrings.get('assess_error_count'), '$_errorCount', Colors.red),
                    _buildStat(AppStrings.get('assess_accuracy'), '${_accuracy.toStringAsFixed(0)}%', Colors.blue),
                    _buildStat(AppStrings.get('assess_level'), _calculatedLevel, Colors.green),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, _calculatedLevel);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${AppStrings.get('assess_result')} $_calculatedLevel')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(AppStrings.get('assess_save')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
