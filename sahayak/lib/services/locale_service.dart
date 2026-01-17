import 'package:flutter/material.dart';

// 1. The Global Locale Controller
final ValueNotifier<Locale> appLocaleNotifier = ValueNotifier(const Locale('en'));

// 2. The Translations Map
class AppStrings {
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // Navigation
      'nav_home': 'Home',
      'nav_activities': 'Activities',
      'nav_students': 'Students',
      'nav_chat': 'Chat',
      'nav_profile': 'Profile',
      
      // Home Dashboard
      'home_quick_intervention': '📢 Quick Intervention',
      'home_pedagogical_tools': '🛠️ Pedagogical Tools',
      'home_micro_strategies': '⚡ Micro-Strategies',
      'home_view_all': 'View All',
      'home_featured': 'Featured Strategy',
      'tool_nk_nav': 'Nali Kali\nNavigator',
      'tool_tarl_acc': 'TaRL\nAccelerator',
      'strategy_deployed': 'Strategy Deployed',
      'instructions': 'INSTRUCTIONS',
      'mins': 'mins',
      'energy': 'Energy',
      
      // Headers
      'app_name': 'Sahayak',
      'welcome': 'Welcome to Sahayak',
      'sahayak_desc': 'Your Pedagogical Copilot',
      'nali_kali_title': 'Nali Kali Activities',
      'students_title': 'Students & Groups',
      'chat_title': 'Sahayak Assistant',
      'profile_title': 'My Profile',
      
      // Categories
      'cat_all': 'All',
      'cat_math': 'Math',
      'cat_lang': 'Language',
      'cat_evs': 'EVS',
      'no_activities': 'No activities in this category',
      
      // Students
      'btn_add_student': 'Add Student',
      'search_student': 'Search students...',
      'level_unassessed': 'Unassessed',
      
      // Profile
      'teacher_name': 'Teacher Ravi',
      'school_name': 'GHPS H.D. Kote | ID: KA-MYS-004',
      'section_sync': 'Sync & Data',
      'section_prefs': 'Preferences',
      'section_support': 'Support',
      'lang_title': 'App Language',
      'lang_subtitle': 'English',
      'logout': 'Log Out',
      
      // Strategies
      'The Graveyard': 'The Graveyard',
      'The Graveyard_desc': 'Instant silence game for chaotic moments.',
      'The Graveyard_content': '1. Scream "GRAVEYARD!"\n2. All students must drop to the floor and "play dead".\n3. The teacher walks around checking for movement.\n4. If anyone moves/giggles, they are "out".\n5. Last one remaining is the Zombie King/Queen.',
      
      'Silent Ball': 'Silent Ball',
      'Silent Ball_desc': 'Focus builder using a soft ball.',
      'Silent Ball_content': '1. Students sit on desks or stand.\n2. Pass a soft ball silently.\n3. If you drop it, you sit down.\n4. If you talk, you sit down.\n5. If you make a bad throw, you sit down.',
      
      'Thunder Clap': 'Thunder Clap',
      'Thunder Clap_desc': 'Reset energy with a rhythmic clap.',
      'Thunder Clap_content': '1. Teacher: "Thunder!"\n2. Students: *Stomp Stomp*\n3. Teacher: "Lightning!"\n4. Students: *Clap Clap*\n5. Repeat faster until perfect synchronization.',
      
      '3-2-1 Blast Off': '3-2-1 Blast Off',
      '3-2-1 Blast Off_desc': 'Quick transition helper.',
      '3-2-1 Blast Off_content': 'Use this for transitions (e.g., books away).\n1. Teacher counts down "3... 2... 1..."\n2. Students must be in "Blast Off" pose (seated, hands folded) by 0.\n3. Reward the fastest row/group.',
      
      'lbl_materials': 'MATERIALS NEEDED',
      'btn_mark_complete': 'Mark as Complete',

      // New Screens
      'assess_title': 'Reading Assessment',
      'assess_instruction': 'Ask the student to read aloud. Tap any word they mispronounce.',
      'assess_error_count': 'Errors',
      'assess_accuracy': 'Accuracy',
      'assess_level': 'Level',
      'assess_save': 'SAVE ASSESSMENT',
      'assess_result': 'Assessed as',
      
      'routine_title': 'Daily Classroom Routine',
      'routine_morning_circle': 'Morning Circle',
      'routine_subtitle': 'Complete these tasks with students before starting Nali Kali activities.',
      'routine_weather_q': 'How is the weather today?',
      'routine_attendance': 'Attendance',
      'routine_attendance_sub': 'Mark attendance in register',
      'routine_slate': 'Wall Slate Update',
      'routine_slate_sub': 'Clean and date the blackboard',
      'routine_complete': 'COMPLETE ROUTINE',
      
      'student_detail_standing': 'Current Standing',
      'student_detail_recommend': 'Recommended Actions',
      'student_detail_assess_prompt': 'Assess Reading Level',
      'student_detail_not_assessed': 'Student has not been assessed yet.',
      
      // Activities (Nali Kali) - Math
      
      // Activities (Nali Kali) - Math
      'act_nk_math_001_title': 'Tamarind Seed Counting',
      'act_nk_math_001_desc': 'Children count tamarind seeds to recognize numbers 1-10',
      'act_nk_math_001_instr': 'Arrange children in groups of 4-5\nGive each group 20 tamarind seeds and a bowl\nShow a number card (e.g., \'5\')\nChildren count out that many seeds into the bowl',
      'act_nk_math_001_mats': '100 Tamarind seeds|Small bowls (5)|Number cards (1-10)',
      
      'act_nk_math_002_title': 'Stone Sorting Game',
      'act_nk_math_002_desc': 'Sorting stones by size to understand comparison',
      'act_nk_math_002_instr': 'Collect smooth stones of different sizes\nLabel 3 boxes: Small, Medium, Large\nChildren sort stones',
      'act_nk_math_002_mats': '30 small stones|3 cardboard boxes',

      'act_nk_math_003_title': 'Number Line Jumping',
      'act_nk_math_003_desc': 'Physical activity to learn addition and subtraction',
      'act_nk_math_003_instr': 'Draw a number line 0-10 on the ground\nCall out "Start at 3, jump forward 2"\nStudent jumps and answers',
      'act_nk_math_003_mats': 'Chalk|Open ground space',

      // Activities - Language
      'act_nk_lang_001_title': 'Sand Writing Practice',
      'act_nk_lang_001_desc': 'Children trace Kannada letters in sand trays',
      'act_nk_lang_001_instr': 'Show a letter flashcard\nDemonstrate tracing in sand\nChildren practice tracing',
      'act_nk_lang_001_mats': 'Sand trays|Letter flashcards',

      'act_nk_lang_002_title': 'Story Picture Walk',
      'act_nk_lang_002_desc': 'Using picture cards to build vocabulary',
      'act_nk_lang_002_instr': 'Display picture cards in sequence\nAsk children to describe\nRecord new words',
      'act_nk_lang_002_mats': 'Story cards|Chart paper',

      // Activities - EVS
      'act_nk_evs_001_title': 'Leaf Collection Walk',
      'act_nk_evs_001_desc': 'Nature walk to collect and identify local leaves',
      'act_nk_evs_001_instr': 'Take children on a walk\nCollect leaves\nSort by shape/size',
      'act_nk_evs_001_mats': 'Plastic bags|Chart paper|Glue',
    },
    'kn': {
      // Navigation
      'nav_home': 'ಮುಖಪುಟ',
      'nav_activities': 'ಚಟುವಟಿಕೆಗಳು',
      'nav_students': 'ವಿದ್ಯಾರ್ಥಿಗಳು',
      'nav_chat': 'ಸಹಾಯಕ',
      'nav_profile': 'ಪ್ರೊಫೈಲ್',

      // Home Dashboard
      'home_quick_intervention': '📢 ತ್ವರಿತ ಹಸ್ತಕ್ಷೇಪ', // Tvarita Hastakshepa
      'home_pedagogical_tools': '🛠️ ಶೈಕ್ಷಣಿಕ ಪರಿಕರಗಳು', // Shaikshanika Parikaragalu
      'home_micro_strategies': '⚡ ಕಿರು-ತಂತ್ರಗಳು', // Kiru-Tantragalu
      'home_view_all': 'ಎಲ್ಲವನ್ನೂ ವೀಕ್ಷಿಸಿ', // Ellavannu Veekshisi
      'home_featured': 'ವಿಶೇಷ ತಂತ್ರ', // Vishesha Tantra
      'tool_nk_nav': 'ನಲಿ-ಕಲಿ\nನ್ಯಾವಿಗೇಟರ್',
      'tool_tarl_acc': 'TaRL\nವೇಗವರ್ಧಕ', // Vegavardhaka
      'strategy_deployed': 'ತಂತ್ರವನ್ನು ಬಳಸಲಾಗಿದೆ', // Tantravannu Balasalagide
      'instructions': 'ಸೂಚನೆಗಳು', // Souchanegalu
      'mins': 'ನಿಮಿಷ', // Nimisha
      'energy': 'ಶಕ್ತಿ', // Shakti
      
      // Headers
      'app_name': 'ಸಹಾಯಕ',
      'welcome': 'ಸಹಾಯಕಕ್ಕೆ ಸುಸ್ವಾಗತ',
      'sahayak_desc': 'ನಿಮ್ಮ ಶೈಕ್ಷಣಿಕ ಸಹಾಯಕ',
      'nali_kali_title': 'ನಲಿ-ಕಲಿ ಚಟುವಟಿಕೆಗಳು',
      'students_title': 'ವಿದ್ಯಾರ್ಥಿಗಳು ಮತ್ತು ಗುಂಪುಗಳು',
      'chat_title': 'ಸಹಾಯಕ ಚಾಟ್',
      'profile_title': 'ನನ್ನ ಪ್ರೊಫೈಲ್',
      
      // Categories
      'cat_all': 'ಎಲ್ಲಾ',
      'cat_math': 'ಗಣಿತ', // Ganitha
      'cat_lang': 'ಭಾಷೆ', // Bhashe
      'cat_evs': 'ಪರಿಸರ', // Parisara (EVS)
      'no_activities': 'ಈ ವಿಭಾಗದಲ್ಲಿ ಯಾವುದೇ ಚಟುವಟಿಕೆಗಳಿಲ್ಲ',
      
      // Students
      'btn_add_student': 'ವಿದ್ಯಾರ್ಥಿಯನ್ನು ಸೇರಿಸಿ',
      'search_student': 'ವಿದ್ಯಾರ್ಥಿಗಳನ್ನು ಹುಡುಕಿ...',
      'level_unassessed': 'ಮೌಲ್ಯಮಾಪನ ಮಾಡಲಾಗಿಲ್ಲ',
      
      // Profile
      'teacher_name': 'ಶಿಕ್ಷಕ ರವಿ',
      'school_name': 'ಜಿ.ಎಚ್.ಪಿ.ಎಸ್ ಎಚ್.ಡಿ.ಕೋಟೆ',
      'section_sync': 'ಸಿಂಕ್ ಮತ್ತು ಡೇಟಾ',
      'section_prefs': 'ಆದ್ಯತೆಗಳು',
      'section_support': 'ಬೆಂಬಲ',
      'lang_title': 'ಅಪ್ಲಿಕೇಶನ್ ಭಾಷೆ',
      'lang_subtitle': 'ಕನ್ನಡ',
      'logout': 'ಲಾಗ್ ಔಟ್',
      
      // Strategies
      'The Graveyard': 'ಸ್ಮಶಾನ ಮೌನ (The Graveyard)',
      'The Graveyard_desc': 'ಗೊಂದಲದ ಕ್ಷಣಗಳಿಗೆ ತ್ವರಿತ ಮೌನ ಆಟ.',
      'The Graveyard_content': '1. "ಸ್ಮಶಾನ!" ಎಂದು ಜೋರಾಗಿ ಹೇಳಿ.\n2. ಎಲ್ಲ ವಿದ್ಯಾರ್ಥಿಗಳು ನೆಲದ ಮೇಲೆ ಬಿದ್ದು "ಸತ್ತವರಂತೆ" ನಟಿಸಬೇಕು.\n3. ಶಿಕ್ಷಕರು ಯಾರು ಚಲಿಸುತ್ತಿದ್ದಾರೆ ಎಂದು ಪರಿಶೀಲಿಸುತ್ತಾರೆ.\n4. ಯಾರಾದರೂ ಚಲಿಸಿದರೆ/ನಕ್ಕರೆ ಅವರು "ಔಟ್".\n5. ಕೊನೆಯಲ್ಲಿ ಉಳಿದವರು "ಝಾಂಬಿ ರಾಜ/ರಾಣಿ".',
      
      'Silent Ball': 'ನಿಶಬ್ದ ಚೆಂಡು (Silent Ball)',
      'Silent Ball_desc': 'ಮೆದು ಚೆಂಡನ್ನು ಬಳಸಿ ಏಕಾಗ್ರತೆಯನ್ನು ಹೆಚ್ಚಿಸುವುದು.',
      'Silent Ball_content': '1. ವಿದ್ಯಾರ್ಥಿಗಳು ಡೆಸ್ಕ್‌ಗಳ ಮೇಲೆ ಅಥವಾ ನಿಲ್ಲಿ.\n2. ಮೆದು ಚೆಂಡನ್ನು ಶಬ್ದವಿಲ್ಲದೆ ಪಾಸ್ ಮಾಡಿ.\n3. ನೀವು ಅದನ್ನು ಕೆಳಗೆ ಹಾಕಿದರೆ, ಕುಳಿತುಕೊಳ್ಳಿ.\n4. ನೀವು ಮಾತನಾಡಿದರೆ, ಕುಳಿತುಕೊಳ್ಳಿ.\n5. ನೀವು ಕೆಟ್ಟದಾಗಿ ಎಸೆದರೆ, ಕುಳಿತುಕೊಳ್ಳಿ.',
      
      'Thunder Clap': 'ಗುಡುಗು ಚಪ್ಪಾಳೆ (Thunder Clap)',
      'Thunder Clap_desc': 'ಲಯಬದ್ಧ ಚಪ್ಪಾಳೆಯೊಂದಿಗೆ ಶಕ್ತಿಯನ್ನು ಮರುಹೊಂದಿಸಿ.',
      'Thunder Clap_content': '1. ಶಿಕ್ಷಕರು: "ಗುಡುಗು!"\n2. ವಿದ್ಯಾರ್ಥಿಗಳು: *ದಬ್ ದಬ್ (ಕಾಲಿನಿಂದ)*\n3. ಶಿಕ್ಷಕರು: "ಮಿಂಚು!"\n4. ವಿದ್ಯಾರ್ಥಿಗಳು: *ಚಪ್ಪಾಳೆ (ಕೈಯಿಂದ)*\n5. ಪರಿಪೂರ್ಣವಾಗುವವರೆಗೆ ವೇಗವಾಗಿ ಪುನರಾವರ್ತಿಸಿ.',
      
      '3-2-1 Blast Off': '3-2-1 ರಾಕೆಟ್ (Blast Off)',
      '3-2-1 Blast Off_desc': 'ತ್ವರಿತ ಬದಲಾವಣೆಗೆ ಸಹಾಯಕ.',
      '3-2-1 Blast Off_content': 'ಇದನ್ನು ಚಟುವಟಿಕೆ ಬದಲಾಯಿಸಲು ಬಳಸಿ.\n1. ಶಿಕ್ಷಕರು ಎಣಿಸುತ್ತಾರೆ "3... 2... 1..."\n2. "0" ಗೆ ಬರುವ ಮೊದಲು ವಿದ್ಯಾರ್ಥಿಗಳು "ರಾಕೆಟ್" ಭಂಗಿಯಲ್ಲಿರಬೇಕು (ಕೈ ಕಟ್ಟಿ ಕುಳಿತುಕೊಳ್ಳಿ).\n3. ವೇಗವಾಗಿ ಮಾಡಿದ ಸಾಲು/ಗುಂಪಿಗೆ ಬಹುಮಾನ ನೀಡಿ.',
      
      'lbl_materials': 'ಅಗತ್ಯವಿರುವ ಸಾಮಗ್ರಿಗಳು',
      'btn_mark_complete': 'ಪೂರ್ಣಗೊಂಡಿದೆ ಎಂದು ಗುರುತಿಸಿ',

      // New Screens (Kannada)
      'assess_title': 'ಓದುವ ಮೌಲ್ಯಮಾಪನ', // Odhuva Moulyamapana
      'assess_instruction': 'ವಿದ್ಯಾರ್ಥಿಗೆ ಜೋರಾಗಿ ಓದಲು ಹೇಳಿ. ತಪ್ಪು ಉಚ್ಚರಿಸಿದ ಪದವನ್ನು ಟ್ಯಾಪ್ ಮಾಡಿ.',
      'assess_error_count': 'ತಪ್ಪುಗಳು',
      'assess_accuracy': 'ನಿಖರತೆ',
      'assess_level': 'ಹಂತ',
      'assess_save': 'ಮೌಲ್ಯಮಾಪನ ಉಳಿಸಿ',
      'assess_result': 'ಫಲಿತಾಂಶ',
      
      'routine_title': 'ದೈನಂದಿನ ತರಗತಿ ದಿನಚರಿ', // Dainandina Taragati Dinachari
      'routine_morning_circle': 'ಬೆಳಗಿನ ವೃತ್ತ (Morning Circle)',
      'routine_subtitle': 'ನಲಿ-ಕಲಿ ಚಟುವಟಿಕೆಗಳನ್ನು ಪ್ರಾರಂಭಿಸುವ ಮೊದಲು ಇವುಗಳನ್ನು ಪೂರ್ಣಗೊಳಿಸಿ.',
      'routine_weather_q': 'ಇಂದು ಹವಾಮಾನ ಹೇಗಿದೆ?',
      'routine_attendance': 'ಹಾಜರಾತಿ',
      'routine_attendance_sub': 'ಹಾಜರಾತಿಯನ್ನು ಗುರುತಿಸಿ',
      'routine_slate': 'ಗೋಡೆ ಸ್ಲೇಟ್ ನವೀಕರಣ',
      'routine_slate_sub': 'ಕಪ್ಪುಹಲಗೆಯನ್ನು ಸ್ವಚ್ಛಗೊಳಿಸಿ ದಿನಾಂಕ ಬರೆಯಿರಿ',
      'routine_complete': 'ದಿನಚರಿ ಪೂರ್ಣಗೊಳಿಸಿ',
      
      'student_detail_standing': 'ಪ್ರಸ್ತುತ ಸ್ಥಿತಿ',
      'student_detail_recommend': 'ಶಿಫಾರಸು ಮಾಡಿದ ಕ್ರಮಗಳು',
      'student_detail_assess_prompt': 'ಓದುವ ಮಟ್ಟವನ್ನು ಪರೀಕ್ಷಿಸಿ',
      'student_detail_not_assessed': 'ಇನ್ನೂ ಮೌಲ್ಯಮಾಪನ ಮಾಡಲಾಗಿಲ್ಲ.',
      
      // Activities (Nali Kali) - Math
      
      // Activities (Nali Kali) - Math
      'act_nk_math_001_title': 'ಹುಣಸೆ ಬೀಜ ಎಣಿಕೆ',
      'act_nk_math_001_desc': '1-10 ಸಂಖ್ಯೆಗಳನ್ನು ಗುರುತಿಸಲು ಹುಣಸೆ ಬೀಜಗಳನ್ನು ಎಣಿಸುವುದು',
      'act_nk_math_001_instr': 'ಮಕ್ಕಳನ್ನು 4-5 ತಂಡಗಳಲ್ಲಿ ಜೋಡಿಸಿ\nಪ್ರತಿ ಗುಂಪಿಗೆ 20 ಬೀಜಗಳನ್ನು ನೀಡಿ\nಒಂದು ಸಂಖ್ಯೆ ಕಾರ್ಡ್ ತೋರಿಸಿ\nಮಕ್ಕಳು ಆ ಸಂಖ್ಯೆಯಷ್ಟು ಬೀಜಗಳನ್ನು ಎಣಿಸಲಿ',
      'act_nk_math_001_mats': '100 ಹುಣಸೆ ಬೀಜಗಳು|ಬಟ್ಟಲುಗಳು|ಸಂಖ್ಯೆ ಕಾರ್ಡ್‌ಗಳು (1-10)',
      
      'act_nk_math_002_title': 'ಕಲ್ಲುಗಳ ವಿಂಗಡಣೆ ಆಟ',
      'act_nk_math_002_desc': 'ಗಾತ್ರದ ಆಧಾರದ ಮೇಲೆ ಕಲ್ಲುಗಳನ್ನು ವಿಂಗಡಿಸುವುದು',
      'act_nk_math_002_instr': 'ವಿವಿಧ ಗಾತ್ರದ ಕಲ್ಲುಗಳನ್ನು ಸಂಗ್ರಹಿಸಿ\n3 ಪೆಟ್ಟಿಗೆಗಳನ್ನು ಇಡಿ: ಚಿಕ್ಕ, ಮಧ್ಯಮ, ದೊಡ್ಡ\nಮಕ್ಕಳು ಕಲ್ಲುಗಳನ್ನು ವಿಂಗಡಿಸಲಿ',
      'act_nk_math_002_mats': '30 ಸಣ್ಣ ಕಲ್ಲುಗಳು|3 ಪೆಟ್ಟಿಗೆಗಳು',

      'act_nk_math_003_title': 'ಸಂಖ್ಯಾ ರೇಖೆ ಜಿಗಿತ',
      'act_nk_math_003_desc': 'ಸಂಕಲನ ಮತ್ತು ವ್ಯವಕಲನ ಕಲಿಯಲು ದೈಹಿಕ ಚಟುವಟಿಕೆ',
      'act_nk_math_003_instr': 'ನೆಲದ ಮೇಲೆ 0-10 ರೇಖೆ ಎಳೆಯಿರಿ\n"3 ರಿಂದ ಪ್ರಾರಂಭಿಸಿ, 2 ಮುಂದೆ ಜಿಗಿಯಿರಿ" ಎಂದು ಹೇಳಿ\nವಿದ್ಯಾರ್ಥಿ ಜಿಗಿದು ಉತ್ತರ ಹೇಳಲಿ',
      'act_nk_math_003_mats': 'ಸೀಮೆಸುಣ್ಣ (Chalk)|ಖಾಲಿ ಜಾಗ',

      // Activities - Language
      'act_nk_lang_001_title': 'ಮರಳಿನ ಬರಹ ಅಭ್ಯಾಸ',
      'act_nk_lang_001_desc': 'ಮಕ್ಕಳು ಮರಳಿನಲ್ಲಿ ಅಕ್ಷರಗಳನ್ನು ತಿದ್ದುತ್ತಾರೆ',
      'act_nk_lang_001_instr': 'ಅಕ್ಷರ ಕಾರ್ಡ್ ತೋರಿಸಿ\nಮರಳಿನಲ್ಲಿ ಬರೆಯುವುದನ್ನು ತೋರಿಸಿ\nಮಕ್ಕಳು ಅಭ್ಯಾಸ ಮಾಡಲಿ',
      'act_nk_lang_001_mats': 'ಮರಳು ತಟ್ಟೆಗಳು|ಅಕ್ಷರ ಕಾರ್ಡ್‌ಗಳು',

      'act_nk_lang_002_title': 'ಚಿತ್ರದ ನಡಿಗೆ (Picture Walk)',
      'act_nk_lang_002_desc': 'ಶಬ್ದಕೋಶವನ್ನು ಬೆಳೆಸಲು ಚಿತ್ರ ಕಾರ್ಡ್‌ಗಳು',
      'act_nk_lang_002_instr': 'ಚಿತ್ರ ಕಾರ್ಡ್‌ಗಳನ್ನು ಅನುಕ್ರಮವಾಗಿ ತೋರಿಸಿ\nಮಕ್ಕಳು ವಿವರಿಸಲಿ\nಹೊಸ ಪದಗಳನ್ನು ಬರೆಯಿರಿ',
      'act_nk_lang_002_mats': 'ಕಥೆಯ ಕಾರ್ಡ್‌ಗಳು|ಚಾರ್ಟ್ ಪೇಪರ್',

      // Activities - EVS
      'act_nk_evs_001_title': 'ಎಲೆಗಳ ಸಂಗ್ರಹ ನಡಿಗೆ',
      'act_nk_evs_001_desc': 'ಸ್ಥಳೀಯ ಎಲೆಗಳನ್ನು ಸಂಗ್ರಹಿಸಲು ನಿಸರ್ಗ ನಡಿಗೆ',
      'act_nk_evs_001_instr': 'ಮಕ್ಕಳನ್ನು ನಡಿಗೆಗೆ ಕರೆದೊಯ್ಯಿರಿ\nಎಲೆಗಳನ್ನು ಸಂಗ್ರಹಿಸಿ\nಗಾತ್ರ/ಆಕಾರದ ಪ್ರಕಾರ ವಿಂಗಡಿಸಿ',
      'act_nk_evs_001_mats': 'ಪ್ಲಾಸ್ಟಿಕ್ ಚೀಲಗಳು|ಚಾರ್ಟ್ ಪೇಪರ್|ಅಂಟು',
    },
  };

  static String get(String key) {
    final locale = appLocaleNotifier.value.languageCode;
    return _localizedValues[locale]?[key] ?? _localizedValues['en']?[key] ?? key;
  }
}
