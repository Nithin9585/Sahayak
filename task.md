# Project Sahayak: Phased Implementation Tasks

This document outlines the step-by-step roadmap to build **Project Sahayak**, ensuring a complete, production-ready solution aligned with the architecture defined in `Problem_solution.md`.

## 📋 Task Types Legend
- **🔷 Flutter** - Mobile app development (Dart/Flutter)
- **🟧 FastAPI** - Backend server development (Python)
- **🔄 Both** - Requires coordination between frontend and backend

---

## Phase 1: Project Initialization & Foundation 🔷 **Flutter**
*Goal: Set up the development environment, initialize the app, and establish the core offline-first architecture.*

- [x] **1.1 Environment Setup**
  - [x] Install Flutter SDK (v3.19+): Download from `flutter.dev`.
  - [x] Install Dart SDK (bundled with Flutter).
  - [x] Install Android Studio (for Android emulator) or VS Code with Flutter extension.
  - [x] Run `flutter doctor` to verify installation.
  - [x] Set up Git repository and initial commit.
- [x] **1.2 App Initialization**
  - [x] Create Flutter project: `flutter create sahayak`.
  - [x] Install Navigation: `go_router` package.
  - [x] Install UI Library: `flutter_material` (built-in) + `flutter_animate` for animations.
- [ ] **1.3 Offline-First Database Setup (Isar)**
  - [x] Install Isar: `flutter pub add isar isar_flutter_libs`.
  - [x] Install dev dependencies: `flutter pub add -d isar_generator build_runner`.
  - [x] Define Database Schemas (Isar models):
    - [x] `Teacher` (Profile, School ID, subjects).
    - [x] `Student` (Name, FLN Level, Group assignment).
    - [x] `Assessment` (Student ID, Date, Rubric scores, Level calculated).
    - [x] `Activity` (Nali Kali/TaRL content cache).
    - [x] `MicroStrategy` (Classroom management techniques).
    - [x] `ChatHistory` (RAG queries and responses).
  - [x] Generate Isar files: `dart run build_runner build`.
  - [ ] Configure sync logic to backend CouchDB using `dio` package (when online).
- [x] **1.4 Application Shell**
  - [x] Build Main Layout: Bottom Navigation Bar (Home, Students, Chat, Profile).
  - [x] Create "Offline Mode" indicator widget.
  - [x] Set up connectivity listener using `connectivity_plus` package.
  - [x] Implement auto-sync trigger on network reconnect.

---

## Phase 2: Backend Infrastructure Setup 🟧 **FastAPI**
*Goal: Deploy backend services for sync, RAG, and telemetry.*

- [ ] **2.1 Database Server (CouchDB)**
  - [ ] Set up CouchDB instance (AWS/DigitalOcean).
  - [ ] Configure CORS for React Native sync.
  - [ ] Create databases matching RxDB schemas.
  - [ ] Set up user authentication (JWT or Basic Auth).
- [ ] **2.2 App Server (FastAPI)**
  - [ ] Initialize FastAPI project: `fastapi[all]`, `uvicorn`.
  - [ ] Create endpoints:
    - [ ] `/api/sync` - Health check for CouchDB sync.
    - [ ] `/api/rag/query` - RAG pipeline endpoint.
    - [ ] `/api/mentor/available` - Fetch available mentors from Elevate.
    - [ ] `/api/telemetry` - Receive batched telemetry events.
- [ ] **2.3 File Storage (S3)**
  - [ ] Set up AWS S3 bucket for media assets (Activity images/videos).
  - [ ] Configure CDN (CloudFront) for fast delivery.
  - [ ] Implement signed URL generation for secure downloads.

---

## Phase 3: Core UX - The "Nali Kali" Navigator 🔷 **Flutter**
*Goal: Digitize the Nali Kali learning ladder and enable offline asset retrieval.*

- [ ] **3.1 Data Ingestion & Seeding**
  - [ ] Research and obtain Nali Kali implementation manuals (PDFs).
  - [ ] Extract and structure data: `Milestones → Activities → Materials → Group Type`.
  - [ ] Convert to JSON schema compatible with RxDB.
  - [ ] Seed local database with static Nali Kali dataset.
- [ ] **3.2 Navigator UI**
  - [ ] Create `MilestoneSelectionScreen`:
    - [ ] Display Learning Ladder as a visual tree/list.
    - [ ] Tap on Milestone → Navigate to Activity Details.
  - [ ] Create `ActivityDetailScreen`:
    - [ ] Show Activity Card image.
    - [ ] List required materials (e.g., "100 Tamarind seeds").
    - [ ] Display group configuration (e.g., "Self-Learning Group").
  - [ ] Implement "Material Checklist" toggle (Mark materials as "Available").
- [ ] **3.3 Media Caching**
  - [ ] Implement lazy-loading for activity images using `cached_network_image` package.
  - [ ] Add "Pin for Offline" button to download high-res media to device storage (`path_provider` + `dio`).
  - [ ] Display offline badge on cached content.

---

## Phase 4: FLN "TaRL" Accelerator 🔷 **Flutter**
*Goal: Operationalize the "Teaching at the Right Level" assessment and grouping logic.*

- [ ] **4.1 Assessment Module**
  - [ ] Build `StudentListScreen` with CRUD operations.
  - [ ] Create `AssessmentWizard`:
    - [ ] **Reading Rubric**: Levels (Beginner, Letter, Word, Paragraph, Story).
    - [ ] **Math Rubric**: Levels (Recognition, Comparison, Addition, Subtraction, Division).
    - [ ] Real-time error tracking UI (tap on error type).
    - [ ] Auto-calculate and save "Current Level" to Student record.
- [ ] **4.2 Grouping Logic Engine**
  - [ ] Implement algorithm: Group students by current level.
  - [ ] Create `GroupViewScreen`:
    - [ ] Display groups as cards (e.g., "Word Level Group: 8 students").
    - [ ] Show recommended activity from TaRL library.
- [ ] **4.3 Activity Script Library**
  - [ ] Create database table for scripted activities (e.g., "Bundle and Sticks").
  - [ ] Build `ScriptViewScreen`:
    - [ ] Step-by-step instructions with images.
    - [ ] Voice readout option (TTS).
  - [ ] Link scripts to TaRL levels in the database.

---

## Phase 5: Classroom Management Micro-Strategies 🔷 **Flutter**
*Goal: Build a searchable library of 2-minute interventions to reset classroom energy.*

- [ ] **5.1 Data Collection**
  - [ ] Research and compile micro-strategies from pedagogical sources.
  - [ ] Categorize by:
    - [ ] Energy Level (High Energy, Low Energy, Transition).
    - [ ] Duration (1 min, 2 min, 5 min).
    - [ ] Type (Gamified Silence, Call-and-Response, Movement).
  - [ ] Examples to include:
    - [ ] "The Graveyard" (High Energy → Silence).
    - [ ] "Silent Ball" (Focused attention).
    - [ ] "7-Up" (Re-engagement game).
- [ ] **5.2 Micro-Strategy Browser UI**
  - [ ] Create `StrategyLibraryScreen`:
    - [ ] Searchable/filterable list.
    - [ ] Tap on strategy → View detailed instructions.
  - [ ] Add "Quick Access" widget on Home screen for emergencies.
- [ ] **5.3 Integration with Pulse Monitor**
  - [ ] Link TinyML "Chaos" detection → Auto-suggest relevant strategy.

---

## Phase 6: Voice Interface (The Hybrid Stack) 🔄 **Both**
*Goal: Enable hands-free interaction using both online and offline voice models.*

- [ ] **6.1 Permission Handling**
  - [ ] Request Microphone and Storage permissions using `permission_handler` package.
  - [ ] Build permission request flow with educational prompts.
- [ ] **6.2 Offline Voice (Vosk/Flutter)**
  - [ ] Install `vosk_flutter` package.
  - [ ] Download language models:
    - [ ] Vosk Hindi Small (~50MB).
    - [ ] Vosk English Small (~40MB).
  - [ ] Store models in assets or download to app documents directory (`path_provider`).
  - [ ] Implement "Push-to-Talk" button with recording indicator using `flutter_sound`.
  - [ ] Map voice commands to app actions using GoRouter:
    - [ ] "Open Math" → Navigate to Math activities.
    - [ ] "Start Assessment" → Launch AssessmentWizard.
    - [ ] "Find Silent Ball" → Search Micro-Strategies.
- [ ] **6.3 Online Voice (Bhashini API)**
  - [ ] Register at Bhashini portal and obtain API credentials.
  - [ ] Create API wrapper service using `dio` package:
    - [ ] `bhashiniASR(audioBlob, language)` → Transcribed text.
    - [ ] `bhashiniTranslate(text, sourceLang, targetLang)` → Translated text.
  - [ ] Implement auto-switch logic:
    - [ ] Check network status using `connectivity_plus`.
    - [ ] Use Bhashini if online, fallback to Vosk if offline.
  - [ ] Add language selector in settings (Hindi, Kannada, English).

---

## Phase 7: Intelligence Layer (RAG & Guardrails) 🟧 **FastAPI**
*Goal: Provide pedagogical answers using a Retrieval Augmented Generation pipeline.*

- [ ] **7.1 Corpus Preparation**
  - [ ] Collect verified PDFs:
    - [ ] NCERT Teacher Handbooks (Grades 1-3).
    - [ ] Nali Kali Implementation Manuals.
    - [ ] TaRL "Combined Activities for Maximized Learning" Guide.
    - [ ] Mantra4Change PBL Handbook.
  - [ ] Convert PDFs to text using `pdfplumber` or `PyPDF2`.
  - [ ] Chunk text into 500-token segments with overlap.
- [ ] **7.2 Vector Database (ChromaDB)**
  - [ ] Set up ChromaDB on backend server.
  - [ ] Embed chunks using AI4Bharat IndicBERT or multilingual-e5 model.
  - [ ] Index embeddings with metadata (source, page number, topic).
- [ ] **7.3 RAG Pipeline Backend**
  - [ ] Implement `/api/rag/query` endpoint:
    1. Embed user query.
    2. Search ChromaDB for top-k similar chunks (k=5).
    3. Construct prompt with context chunks.
    4. Query LLM (Llama 3 8B via Groq/Together AI or self-hosted).
    5. Return response with source citations.
  - [ ] Add response caching (Redis) for common queries.
- [ ] **7.4 Mobile Chat Interface**
  - [ ] Build `SahayakChatScreen`:
    - [ ] WhatsApp-style message bubbles.
    - [ ] Voice input button integrated.
    - [ ] "Typing..." indicator while processing.
  - [ ] Implement flow:
    - [ ] Voice → Bhashini/Vosk → Text.
    - [ ] Text → Translate to English (if needed).
    - [ ] Text → RAG API → Response.
    - [ ] Response → Translate back → Display.
  - [ ] Store chat history in RxDB for offline review.
- [ ] **7.5 Guardrails Implementation**
  - [ ] **Input Guardrails**:
    - [ ] Reject queries on politics, religion, or violence.
    - [ ] Use keyword blocklist and intent classification.
  - [ ] **Grounding Guardrails**:
    - [ ] System prompt: "Answer ONLY from the provided context. If unsure, say 'I don't know' and suggest contacting a Mentor."
  - [ ] **Citation Enforcement**:
    - [ ] Every response must include source (e.g., "Source: NCERT Grade 2 Teacher Handbook, Page 45").

---

## Phase 8: Edge AI "Pulse" Monitor 🔷 **Flutter**
*Goal: Passive classroom noise monitoring using TinyML.*

- [ ] **8.1 TFLite Model Preparation**
  - [ ] Find or train a TFLite model for audio classification:
    - [ ] Classes: "Silence", "Focused Work", "Chaotic Noise".
    - [ ] Model size: < 20KB.
  - [ ] Test model on desktop with sample audio.
- [ ] **8.2 TFLite Integration**
  - [ ] Install `tflite_flutter` package.
  - [ ] Load `.tflite` model from Flutter assets.
  - [ ] Create audio processing pipeline:
    - [ ] Capture 3-second audio buffer every 10 seconds using `record` package.
    - [ ] Convert to spectrogram (MFCC features).
    - [ ] Run inference.
- [ ] **8.3 Background Service**
  - [ ] Use `workmanager` or `android_alarm_manager_plus` for background tasks.
  - [ ] Store state: Last 5 classifications in Isar database.
- [ ] **8.4 Intervention Logic**
  - [ ] If "Chaos" detected for > 5 minutes:
    - [ ] Trigger vibration.
    - [ ] Show local notification: "Classroom noise is high. Tap for suggestions."
    - [ ] On tap → Open Micro-Strategy screen filtered to "High Energy" techniques.

---

## Phase 9: Ecosystem Integration (Elevate & Sunbird) 🔄 **Both**
*Goal: Connect the local app to the broader state infrastructure.*

- [ ] **9.1 Elevate Mentor Integration**
  - [ ] Study Elevate API documentation.
  - [ ] Create `MentorConnectScreen`:
    - [ ] Fetch list of available mentors from `/api/mentor/available`.
    - [ ] Filter by tags (e.g., #SpecialNeeds, #MathPedagogy).
  - [ ] Implement "Request Session" feature:
    - [ ] Pass current chat context as summary.
    - [ ] Book 15-minute slot via Elevate API.
  - [ ] Display confirmation and calendar invite.
- [ ] **9.2 Samiksha (Self-Observation) Integration**
  - [ ] Integrate Samiksha observation rubrics.
  - [ ] Create `SelfReflectionScreen`:
    - [ ] Checklist-style UI (e.g., "Did I use differentiated groups today?").
    - [ ] Submit observation to Sunbird Obsrv.
- [ ] **9.3 Sunbird Telemetry**
  - [ ] Install Sunbird Telemetry SDK: `@project-sunbird/telemetry-sdk`.
  - [ ] Define telemetry events:
    - [ ] `START`: App launched.
    - [ ] `INTERACT`: Button clicked, screen viewed.
    - [ ] `ASSESS`: Assessment completed.
    - [ ] `SEARCH`: RAG query executed.
    - [ ] `SHARE`: Mentor session requested.
  - [ ] Implement batch sync:
    - [ ] Store events locally in RxDB.
    - [ ] Sync to Sunbird Obsrv API every 1 hour or when online.

---

## Phase 10: Flutter Web Deployment (Optional Web Version) 🔷 **Flutter**
*Goal: Deploy a Flutter Web version for desktop access.*

- [ ] **10.1 Web Build Setup**
  - [ ] Enable Flutter web: `flutter config --enable-web`.
  - [ ] Build for web: `flutter build web`.
- [ ] **10.2 Service Worker Configuration**
  - [ ] Flutter web automatically generates service workers.
  - [ ] Customize `flutter_service_worker.js` to cache:
    - [ ] Static assets (logos, fonts).
    - [ ] API responses (stale-while-revalidate strategy).
- [ ] **10.3 Deployment**
  - [ ] Deploy to Vercel or Netlify.
  - [ ] Test offline functionality on Chrome DevTools.

---

## Phase 11: Testing, Security & Compliance 🔄 **Both**
*Goal: Ensure reliability, data privacy, and production readiness.*

- [ ] **11.1 Unit and Integration Testing**
  - [ ] Write tests for:
    - [ ] Isar schema validation.
    - [ ] TaRL grouping algorithm accuracy.
    - [ ] Voice command mapping logic.
  - [ ] Use Flutter's built-in `test` package and `integration_test`.
- [ ] **11.2 Offline Mode Testing**
  - [ ] Enable Airplane Mode and test all core features:
    - [ ] Navigate Nali Kali content.
    - [ ] Conduct assessments.
    - [ ] Use Vosk voice commands.
    - [ ] View cached chat history.
  - [ ] Verify sync after reconnection.
- [ ] **11.3 Security Audit**
  - [ ] Implement HTTPS for all API calls.
  - [ ] Encrypt sensitive data in RxDB (teacher PII).
  - [ ] Add API rate limiting to prevent abuse.
- [ ] **11.4 Data Privacy Compliance**
  - [ ] Draft Privacy Policy (GDPR, India IT Act).
  - [ ] Implement opt-in consent for Pulse monitoring.
  - [ ] Ensure voice data is not stored (only transcriptions).

---

## Phase 12: UI/UX Polish & Accessibility 🔷 **Flutter**
*Goal: Create a premium, accessible user experience.*

- [ ] **12.1 Design System**
  - [ ] Define color palette using Material Theme with custom colors.
  - [ ] Add Google Fonts using `google_fonts` package (Inter, Noto Sans).
  - [ ] Create reusable widget library (Custom Buttons, Cards, Modals).
- [ ] **12.2 Animations**
  - [ ] Add Lottie animations using `lottie` package:
    - [ ] Success states (Assessment completed, Level Up!).
    - [ ] Loading states (Syncing data, Processing voice).
  - [ ] Implement smooth transitions between screens.
- [ ] **12.3 Accessibility**
  - [ ] Add accessibility labels to all touchable elements.
  - [ ] Test with screen readers (TalkBack on Android).
  - [ ] Ensure font scaling works for visually impaired users.
  - [ ] Provide high-contrast mode toggle.

---

## Phase 13: Documentation & Handoff 🔄 **Both**
*Goal: Create comprehensive documentation for maintainers and contributors.*

- [ ] **13.1 Technical Documentation**
  - [ ] Write `ARCHITECTURE.md`:
    - [ ] System diagram (Mermaid).
    - [ ] Data flow diagrams.
    - [ ] Technology stack overview.
  - [ ] Write `API.md`:
    - [ ] Document all backend endpoints.
    - [ ] Include request/response examples.
  - [ ] Write `SETUP.md`:
    - [ ] Step-by-step development environment setup.
    - [ ] How to run app locally.
- [ ] **13.2 User Documentation**
  - [ ] Create in-app onboarding tutorial (5 screens).
  - [ ] Write user manual (PDF) covering:
    - [ ] How to conduct assessments.
    - [ ] How to use voice commands.
    - [ ] How to connect with mentors.
- [ ] **13.3 Contribution Guide**
  - [ ] Write `CONTRIBUTING.md`:
    - [ ] Code style guidelines.
    - [ ] Git workflow (feature branches).
    - [ ] How to submit issues and PRs.

---

## Phase 14: Demo Preparation & Launch 🔄 **Both**
*Goal: Prepare for hackathon presentation and public release.*

- [ ] **14.1 Demo Mode**
  - [ ] Seed app with realistic dummy data:
    - [ ] 30 students with varying FLN levels.
    - [ ] Pre-cached Nali Kali activities.
    - [ ] Sample chat history with RAG responses.
  - [ ] Create "Demo Script" document for presentation.
- [ ] **14.2 Demo Video**
  - [ ] Record 3-minute video showcasing:
    - [ ] Voice-activated Nali Kali navigation.
    - [ ] Live TaRL assessment.
    - [ ] RAG-powered chat answering a pedagogy question.
    - [ ] Pulse monitor suggesting a micro-strategy.
  - [ ] Add captions and background music.
- [ ] **14.3 APK/IPA Generation**
  - [ ] Generate signed Android APK:
    - [ ] Create keystore: `keytool -genkey -v -keystore sahayak-key.jks`.
    - [ ] Configure `android/key.properties`.
    - [ ] Build APK: `flutter build apk --release`.
  - [ ] (Optional) Build iOS IPA: `flutter build ipa --release`.
  - [ ] Test installation on physical devices.
- [ ] **14.4 Hackathon Submission**
  - [ ] Upload APK to submission portal.
  - [ ] Submit demo video and presentation slides.
  - [ ] Prepare Q&A responses for judges.

---

## Phase 15: Post-Launch & Iteration 🔄 **Both**
*Goal: Gather feedback and iterate based on real-world usage.*

- [ ] **15.1 Pilot Deployment (HD Kote Block)**
  - [ ] Deploy to 50 teachers in HD Kote, Mysore.
  - [ ] Conduct 2-week training workshop.
  - [ ] Set up feedback collection (in-app survey + WhatsApp group).
- [ ] **15.2 Analytics & Monitoring**
  - [ ] Set up Firebase Analytics or Mixpanel.
  - [ ] Track key metrics:
    - [ ] Daily Active Users (DAU).
    - [ ] Assessment completion rate.
    - [ ] RAG query success rate (positive feedback).
    - [ ] Offline usage percentage.
- [ ] **15.3 Iteration**
  - [ ] Analyze feedback and telemetry data.
  - [ ] Prioritize bug fixes and feature requests.
  - [ ] Release v1.1 with improvements.
- [ ] **15.4 State Integration**
  - [ ] Partner with Karnataka DSERT for state-level rollout.
  - [ ] Integrate with DIKSHA Karnataka tenant.
  - [ ] Scale to 4,000 Nali Kali schools.
