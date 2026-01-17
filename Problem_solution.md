# Project Sahayak: A Comprehensive Architecture for Just-in-Time Pedagogical Support Using Societal Platform Thinking

## Executive Summary
The crisis of the Indian education system is not merely one of infrastructure or enrolment, but fundamentally one of **agency**. While the National Education Policy (NEP) 2020 and initiatives like NIPUN Bharat mandate a shift towards competency-based learning and Foundational Literacy and Numeracy (FLN), the primary change agent—the teacher—remains structurally isolated. 

**Project Sahayak** is a proposed Digital Public Good (DPG) submission for the ShikshaLokam InvokED Hackathon. It functions as an **offline-first, voice-enabled "Pedagogical Copilot"** designed to restore agency to India's 9.8 million teachers. Unlike traditional "just-in-case" training, Sahayak provides **Just-in-Time (JIT)** support using three critical layers:
1.  **Contextual Intelligence**: A RAG engine grounded in verified pedagogical frameworks (Nali Kali, TaRL).
2.  **Edge Computing**: Offline ASR (Vosk/Whisper) and TinyML for low-bandwidth environments.
3.  **Human-in-the-Loop**: Seamless escalation to mentors via ShikshaLokam’s Elevate platform.

---

## 1. Systemic Analysis: The Crisis of Teacher Support
To design an effective solution, we must first deconstruct why the current support paradigm fails.

### 1.1 The Collapse of the Cascade Model
Historically, Teacher Professional Development (TPD) relies on a "cascade model" (National -> State -> District -> Block -> Cluster). 
*   **Transmission Loss**: By the time training reaches the teacher, content is diluted and theoretical.
*   **Latency**: Training happens annually. A teacher facing a behavioral issue in July cannot wait for a workshop in October.
*   **Passive Recipients**: Teachers are treated as beneficiaries rather than practitioners with agency.

### 1.2 The Role and Reality of BRCs and CRCs
Block (BRC) and Cluster Resource Centres (CRC) are intended to provide on-site support.
*   **Operational Reality**: Cluster Resource Persons (CRPs) often function as administrative inspectors (checking MDF, UDISE+ data) rather than academic mentors.
*   **The Trust Deficit**: Because CRPs are viewed as inspectors, teachers hide their struggles. This necessitates a non-judgmental, private digital companion.

### 1.3 The Multi-Grade & FLN Challenge
*   **Nali Kali (Joyful Learning)**: In Karnataka, this methodology abolishes standard periods for "Learning Ladders" and "Milestones." Teachers must manage 5 distinct groups (e.g., "Peer supported", "Teacher guided") simultaneously.
*   **TaRL (Teaching at the Right Level)**: Requires grouping children by learning level (Beginner, Letter, Word) rather than age. Teachers often struggle with the mechanics of continuous assessment and specific activities (e.g., "Bundle and Sticks").

---

## 2. Solution Philosophy: Societal Platform Thinking
Project Sahayak is not an isolated app but a manifestation of **Societal Platform Thinking**.
*   **Restore Agency**: Shift from "Push-based" training to "Pull-based" problem solving.
*   **Distribute Ability to Solve**: Orchestrate assets from diverse actors (NGOs, State Depts) rather than creating everything centrally.
*   **Scale Efficiently**: Leverage shared DPG infrastructure (**Sunbird**, **Bhashini**) to lower marginal costs.

---

## 3. Pedagogical Architecture: The "Sahayak" Framework
Sahayak is "grounded" in the specific curricular realities of the Indian government school teacher.

### 3.1 The "Nali Kali" Navigator
Acts as a digital index for Activity Based Learning (ABL).
*   **Query**: "What materials do I need for Math Milestone 4?"
*   **Response**: Retrieves specific activity cards, material lists (e.g., "Tamarind seeds"), and group configurations from the Nali Kali implementation guides.

### 3.2 The FLN "TaRL" Accelerator
Operationalizes the "Teaching at the Right Level" methodology.
*   **Assessment Assistant**: A digital rubric for 1-on-1 assessments to automatically calculate student levels (e.g., "Paragraph Level").
*   **Scripted Support**: Provides step-by-step scripts for activities.
    *   *Example*: "Bundle and Sticks" script for teaching place values, reducing cognitive load for the teacher.

### 3.3 Classroom Management Micro-Strategies
A library of "Micro-Strategies" that take < 2 minutes to deploy.
*   **Gamified Silence**: Techniques like "The Graveyard" or "Silent Ball" to reset classroom energy.
*   **Indexed by Energy**: Strategies are tagged by "High Energy" (active games) or "Low Energy" (call-and-response).

---

## 4. Technical Architecture
The architecture is dictated by "First Mile" constraints: intermittent connectivity and low-end devices.

### 4.1 High-Level Architecture Diagram
```mermaid
graph TD
    User[Teacher] -->|Voice/Text| UI["Sahayak App (PWA/React Native)"]
    
    subgraph "Edge / Device (Offline-First)"
        UI -->|Offline Command| Vosk["Vosk / Whisper.cpp Model"]
        UI -->|Store/Retrieve| RxDB["RxDB / PouchDB (Local)"]
        UI -->|Ambient Monitor| TinyML["TinyML 'Pulse' Audio Monitor"]
    end
    
    subgraph "Cloud / Backend"
        UI -.->|Online Speech| Bhashini["Bhashini API"]
        RxDB <-->|Sync (JSON)| CouchDB["Cloud DB / Sunbird"]
        
        UI -.->|Complex Query| Backend["App Server"]
        Backend -->|RAG Pipeline| RAG
        
        subgraph "Intelligence Layer"
            RAG --> Guardrails
            Guardrails --> VectorDB[("Vector DB")]
            Guardrails --> LLM["LLM (Llama 3 / Mistral)"]
            VectorDB <--> Corpus["Pedagogical Corpus: Nali Kali, NCERT"]
        end
        
        UI -.->|Escalate| Elevate["ShikshaLokam Elevate (Mentor)"]
        UI -.->|Telemetry| Obsrv["Sunbird Obsrv"]
    end
    
    style User fill:#f9f,stroke:#333,stroke-width:2px
    style UI fill:#bbf,stroke:#333,stroke-width:2px
    style RxDB fill:#dfd,stroke:#333
    style Vosk fill:#dfd,stroke:#333
    style TinyML fill:#dfd,stroke:#333
```

### 4.2 Offline-First PWA Implementation
*   **App Shell**: Core UI cached via Workbox for instant load.
*   **Data Sync**: Uses **RxDB** (Reactive Database) on top of **PouchDB**. 
    *   *Local*: All data written locally first.
    *   *Sync*: Automatic "Master-Master" replication with the backend CouchDB when online.
*   **Assets**: "Lazy Loading" for heavy videos, with a "Pin" feature for caching specific modules.

### 4.3 Voice Interface: The Hybrid Stack
*   **Online (Bhashini)**: Uses National Language Translation Mission APIs for high-accuracy, 22-language ASR and translation.
*   **Offline (Vosk/Whisper)**: 
    *   **Vosk**: Lightweight (<50MB) model for command-and-control grammar (e.g., "Open Math Module").
    *   **Whisper.cpp**: React Native binding for higher accuracy dictation on supported devices.

### 4.4 Intelligence Layer: RAG with Guardrails
*   **Vector Knowledge Base**: Indexes high-quality PDFs (NCERT, Nali Kali Manuals) into **ChromaDB**.
*   **Guardrails**:
    *   *Input*: Rejects non-educational/political queries.
    *   *Grounding*: LLM instructed to answer *only* from provided chunks.
    *   *Citation*: Responses must cite the source document.

### 4.5 Edge AI: TinyML "Pulse"
*   **Privacy-Preserving**: Runs on-device (DSP) using TensorFlow Lite for Microcontrollers.
*   **Function**: Classification of audio into "Focused Work" vs "Chaotic Noise" without recording speech.
*   **Intervention**: Triggers a silent vibration/nudge if chaos persists > 5 mins.

---

## 5. Integration with ShikshaLokam Elevate
Sahayak acts as the "Demand Side" interface for the Elevate ecosystem.

*   **Mentor Building Block**: When AI confidence is low, Sahayak prompts: "Connect with a Mentor?"
    *   Matches teacher with an expert (e.g., #SpecialNeeds) via Elevate API.
    *   Passes conversation context to the mentor.
*   **Samiksha (Observation)**: Enables self-reflection rubrics that feed into state dashboards (Sunbird Obsrv) for systemic visibility without inspection.

---

## 6. Implementation Roadmap & Feasibility

### 6.1 Phased Rollout
1.  **Phase 1 (Hackathon MVP)**: React Native app with Bhashini/Vosk and basic RAG (Nali Kali).
2.  **Phase 2 (Cluster Pilot)**: HD Kote Block (Mysore). 50 Teachers. Focus on UX and TinyML calibration.
3.  **Phase 3 (State Integration)**: Integration with DIKSHA Karnataka tenant.

### 6.2 Cost Analysis (Pilot for 1,000 Users)
| Component | Resource | Est. Monthly Cost | Source |
| :--- | :--- | :--- | :--- |
| **Compute** | EC2 (t3.medium x2) | $60.00 | AWS |
| **Database** | Self-hosted / RDS | $52.00 | AWS |
| **Storage** | S3 (100GB) | $2.30 | AWS |
| **Data Transfer** | Outbound (1TB) | $90.00 | AWS |
| **Voice API** | Bhashini | $0.00 | Govt DPG |
| **Edge AI** | On-Device | $0.00 | - |
| **Total** | | **~$204.30** | |

*Cost per user is ~$0.20/month, making it highly sustainable for government adoption.*

---

## 7. Conclusion
Project Sahayak bridges the gap between the high-level policy of NEP 2020 and the ground-level reality of the classroom. By combining the **empathy of human mentorship** (Elevate) with the **precision of AI** (RAG) and the **accessibility of Voice** (Bhashini/Vosk), it operationalizes the Societal Platform vision: empowering the first-mile actor to solve their own problems, at scale, with speed, and sustainably.

---

## 8. References
*   **Bhashini API**: `bhashini.gov.in`
*   **ShikshaLokam**: `shikshalokam.org` (Elevate, Sunbird)
*   **Nali Kali**: Azim Premji University / Karnataka State Dept Studies
*   **TaRL**: Pratham / J-PAL Evidence
*   **Tech Stack**: React Native, RxDB, Vosk, TensorFlow Lite Micro
