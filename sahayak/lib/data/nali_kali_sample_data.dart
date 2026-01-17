// Sample Nali Kali Activities Data
// Structure: Milestones -> Activities -> Materials

const List<Map<String, dynamic>> naliKaliActivities = [
  {
    "id": "nk_math_milestone_1",
    "milestone": "Number Recognition (1-10)",
    "category": "Math",
    "activities": [
      {
        "id": "nk_math_001",
        "title": "Tamarind Seed Counting",
        "description": "Children count tamarind seeds to recognize numbers 1-10",
        "groupType": "Self-Learning Group",
        "duration": 20,
        "materialsNeeded": [
          "100 Tamarind seeds",
          "Small bowls (5)",
          "Number cards (1-10)"
        ],
        "instructions": [
          "Arrange children in groups of 4-5",
          "Give each group 20 tamarind seeds and a bowl",
          "Show a number card (e.g., '5')",
          "Children count out that many seeds into the bowl",
          "Rotate cards and repeat"
        ],
        "imageUrl": "https://via.placeholder.com/400x300.png?text=Tamarind+Seed+Counting",
        "isCached": false
      },
      {
        "id": "nk_math_002",
        "title": "Stone Sorting Game",
        "description": "Sorting stones by size to understand comparison",
        "groupType": "Peer-Supported",
        "duration": 15,
        "materialsNeeded": [
          "30 small stones",
          "3 cardboard boxes (Small, Medium, Large labels)"
        ],
        "instructions": [
          "Collect smooth stones of different sizes",
          "Label 3 boxes: Small, Medium, Large",
          "Children work in pairs to sort stones",
          "Discuss which box has 'more' or 'less'"
        ],
        "imageUrl": "https://via.placeholder.com/400x300.png?text=Stone+Sorting",
        "isCached": false
      }
    ]
  },
  {
    "id": "nk_lang_milestone_1",
    "milestone": "Letter Recognition (Kannada)",
    "category": "Language",
    "activities": [
      {
        "id": "nk_lang_001",
        "title": "Sand Writing Practice",
        "description": "Children trace Kannada letters in sand trays",
        "groupType": "Self-Learning Group",
        "duration": 25,
        "materialsNeeded": [
          "Sand trays (shallow plastic trays with sand)",
          "Letter flashcards (ಅ, ಆ, ಇ, ಈ)",
          "Sticks for writing"
        ],
        "instructions": [
          "Show a letter flashcard",
          "Demonstrate tracing in sand",
          "Children practice tracing with fingers/sticks",
          "Encourage saying the letter sound aloud"
        ],
        "imageUrl": "https://via.placeholder.com/400x300.png?text=Sand+Writing",
        "isCached": false
      },
      {
        "id": "nk_lang_002",
        "title": "Story Picture Walk",
        "description": "Using picture cards to build vocabulary",
        "groupType": "Teacher-Guided",
        "duration": 30,
        "materialsNeeded": [
          "Story picture cards (10 cards)",
          "Chart paper",
          "Markers"
        ],
        "instructions": [
          "Display picture cards in sequence",
          "Ask children to describe what they see",
          "Record new words on chart paper",
          "Create a simple story together"
        ],
        "imageUrl": "https://via.placeholder.com/400x300.png?text=Story+Picture+Walk",
        "isCached": false
      }
    ]
  },
  {
    "id": "nk_evs_milestone_1",
    "milestone": "My Environment (Local Plants)",
    "category": "EVS",
    "activities": [
      {
        "id": "nk_evs_001",
        "title": "Leaf Collection Walk",
        "description": "Nature walk to collect and identify local leaves",
        "groupType": "Teacher-Guided",
        "duration": 40,
        "materialsNeeded": [
          "Plastic bags for collection",
          "Chart paper",
          "Glue sticks",
          "Labels"
        ],
        "instructions": [
          "Take children on a supervised walk around school",
          "Collect different types of leaves",
          "Back in class, sort leaves by shape/size",
          "Create a leaf chart with labels",
          "Discuss which plants/trees they came from"
        ],
        "imageUrl": "https://via.placeholder.com/400x300.png?text=Leaf+Collection",
        "isCached": false
      }
    ]
  }
];
