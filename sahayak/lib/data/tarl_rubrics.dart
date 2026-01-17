// TaRL Assessment Rubrics for Reading and Math
// Based on Pratham's Teaching at the Right Level methodology

class TaRLRubrics {
  // Reading Levels (Kannada/English)
  static const List<Map<String, dynamic>> readingLevels = [
    {
      'level': 'Beginner',
      'order': 0,
      'description': 'Cannot recognize letters',
      'assessment': 'Show letter flashcards. Student cannot identify any.',
      'color': 0xFFE57373, // Red
    },
    {
      'level': 'Letter',
      'order': 1,
      'description': 'Can recognize individual letters',
      'assessment': 'Student identifies at least 4 out of 5 letters shown.',
      'color': 0xFFFFB74D, // Orange
    },
    {
      'level': 'Word',
      'order': 2,
      'description': 'Can read simple words',
      'assessment': 'Student reads at least 3 out of 5 simple words (e.g., "cat", "dog").',
      'color': 0xFFFFD54F, // Yellow
    },
    {
      'level': 'Paragraph',
      'order': 3,
      'description': 'Can read simple paragraphs',
      'assessment': 'Student reads a Grade 1 level paragraph with few errors.',
      'color': 0xFF81C784, // Light Green
    },
    {
      'level': 'Story',
      'order': 4,
      'description': 'Can read and comprehend stories',
      'assessment': 'Student reads a Grade 2 story and answers comprehension questions.',
      'color': 0xFF66BB6A, // Green
    },
  ];

  // Math Levels
  static const List<Map<String, dynamic>> mathLevels = [
    {
      'level': 'Recognition',
      'order': 0,
      'description': 'Cannot recognize numbers 1-9',
      'assessment': 'Show number cards. Student cannot identify numbers.',
      'color': 0xFFE57373, // Red
    },
    {
      'level': 'Comparison',
      'order': 1,
      'description': 'Can recognize and compare numbers',
      'assessment': 'Student can identify which number is bigger: 5 or 3.',
      'color': 0xFFFFB74D, // Orange
    },
    {
      'level': 'Addition',
      'order': 2,
      'description': 'Can perform addition (1-9)',
      'assessment': 'Student solves: 3 + 2 = ?',
      'color': 0xFFFFD54F, // Yellow
    },
    {
      'level': 'Subtraction',
      'order': 3,
      'description': 'Can perform subtraction (1-9)',
      'assessment': 'Student solves: 5 - 2 = ?',
      'color': 0xFF81C784, // Light Green
    },
    {
      'level': 'Division',
      'order': 4,
      'description': 'Can perform simple division',
      'assessment': 'Student solves: 10 ÷ 2 = ?',
      'color': 0xFF66BB6A, // Green
    },
  ];

  // Get level by name
  static Map<String, dynamic>? getReadingLevel(String levelName) {
    return readingLevels.firstWhere(
      (level) => level['level'] == levelName,
      orElse: () => readingLevels[0],
    );
  }

  static Map<String, dynamic>? getMathLevel(String levelName) {
    return mathLevels.firstWhere(
      (level) => level['level'] == levelName,
      orElse: () => mathLevels[0],
    );
  }
}
