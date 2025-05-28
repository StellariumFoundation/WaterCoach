
## **Water Coach: Software Engineering Specifications (Flutter)**

**Version:** 1.0
**Date:** May 28, 2025
**Project Lead:** John Victor
**Target Platform:** Cross-Platform (iOS, Android, Windows, macOS, Linux) using Flutter

**Table of Contents:**

1.  **Introduction**
    1.1. Purpose of this Document
    1.2. Project Overview (Brief recap from Product Specs)
    1.3. Target Platforms & Flutter Rationale
2.  **Overall Architecture**
    2.1. High-Level Architecture Diagram (Client-AI Backend interaction)
    2.2. Client-Side Architecture (Flutter App)
        2.2.1. Modular Design (Feature Modules)
        2.2.2. State Management Strategy (e.g., Provider, BLoC/Cubit, Riverpod)
        2.2.3. Navigation
    2.3. Backend Integration (AI Coaching Service)
        2.3.1. API Communication (RESTful, gRPC, or WebSockets)
3.  **Core Modules & Features (Flutter Implementation Details)**
    3.1. **User Authentication Module**
        3.1.1. UI Components (Login Screen, Registration Screen, Social Login Buttons)
        3.1.2. Logic (Integration with Firebase Auth, Supabase Auth, or custom backend)
        3.1.3. State Management for Auth Status
    3.2. **Quest Management Module ("Session Management")**
        3.2.1. UI Components (Quest Creation Screen, Active Quest Display, Quest History)
        3.2.2. Data Models (Quest/Session object: description, start/end time, status, logs)
        3.2.3. Local Storage (for active quest data, offline drafts using `shared_preferences` or `sqflite`)
    3.3. **AI Coaching Interaction Module**
        3.3.1. UI Components (Chat-like interface for AI suggestions, voice input button, text input field, coaching dashboard elements)
        3.3.2. Voice Input/Output
            3.3.2.1. Speech-to-Text (STT) Integration (e.g., `speech_to_text` package, platform-native APIs via method channels)
            3.3.2.2. Text-to-Speech (TTS) Integration (e.g., `flutter_tts` package, platform-native APIs)
        3.3.3. Natural Language Processing (NLP) Client Logic (Sending user input/context to backend)
    3.4. **Device Activity Monitoring Module (Platform-Specific Considerations)**
        3.4.1. Screen Content Analysis (Accessibility Services, OCR - *significant privacy and technical hurdles*)
            3.4.1.1. Android: AccessibilityService API.
            3.4.1.2. iOS: Limited, potential for screenshot analysis (user-initiated or with strong permissions).
            3.4.1.3. Desktop (Windows, macOS, Linux): Screen capture APIs, window title detection.
        3.4.2. Application Usage Tracking (e.g., `usage_stats` on Android, limited on iOS, platform APIs on Desktop)
        3.4.3. Input Monitoring (Keystrokes, mouse - *highly sensitive, requires explicit permissions and ethical considerations*)
        3.4.4. Data Formatting & Transmission to AI Backend
        3.4.5. User Permissions & Privacy Handling (Crucial)
    3.5. **Hovering Icon/Overlay Module**
        3.5.1. Implementation (e.g., Flutter's `Overlay` widget, platform-specific overlay permissions like `SYSTEM_ALERT_WINDOW` on Android)
        3.5.2. Animated Icon States (Idle, Listening, Suggesting)
        3.5.3. Interaction (Tap to open main app, quick actions)
    3.6. **External Tool Integration Module**
        3.6.1. API Client Logic for selected productivity apps (e.g., Calendar, To-Do lists)
        3.6.2. OAuth 2.0 Handling for secure authorization
    3.7. **Settings Module**
        3.7.1. UI Components (Toggles for monitoring, interaction mode selection, integration management)
        3.7.2. Local Persistence of Settings (`shared_preferences`)
    3.8. **Cross-Platform Synchronization Module**
        3.8.1. Backend service for syncing session data/state across user's devices.
        3.8.2. Conflict Resolution Strategy (if needed).
4.  **AI Backend Service (Conceptual - for Flutter client interaction)**
    4.1. API Endpoints (e.g., `/startSession`, `/processInput`, `/getSuggestion`)
    4.2. Input Requirements (Session context, user input, monitored device data)
    4.3. Output Format (Coaching advice, suggestions, structured data)
    4.4. System Prompt Engineering (How the coaching instructions are fed to the core AI model)
5.  **Data Models & Persistence**
    5.1. User Profile
    5.2. Quest/Session Data
    5.3. AI Interaction Logs (Local/Optional Cloud Sync for history)
    5.4. Local Database Schema (if using `sqflite`) or Key-Value structure (`shared_preferences`)
6.  **User Interface (UI) / User Experience (UX) Design Principles (Flutter Specific)**
    6.1. Material Design / Cupertino Theming (Adaptive UI)
    6.2. Responsiveness (Adapting to different screen sizes and orientations)
    6.3. Accessibility (Semantic widgets, screen reader support)
    6.4. Performance (Smooth animations, minimal jank)
7.  **Non-Functional Requirements (Technical Implementation)**
    7.1. **Performance:** Aim for <2 second AI response perceived by user (network + processing). Flutter app should maintain 60fps.
    7.2. **Scalability (Backend):** Backend AI service designed for concurrent users.
    7.3. **Security:** Secure API communication (HTTPS), encryption of sensitive local data, careful handling of monitored data.
    7.4. **Reliability:** Robust error handling, graceful degradation if backend is unavailable.
    7.5. **Maintainability:** Clean code, modular design, good documentation, automated tests.
    7.6. **Testability:** Unit, widget, and integration tests for Flutter components.
8.  **Development Environment & Tools (Flutter)**
    8.1. Flutter SDK Version
    8.2. Dart Version
    8.3. Key Flutter Packages (e.g., `http`, `provider`/`flutter_bloc`/`riverpod`, `speech_to_text`, `flutter_tts`, `shared_preferences`, `sqflite`, platform-specific integration packages)
    8.4. IDE (VS Code, Android Studio)
    8.5. Version Control (Git)
9.  **Deployment**
    9.1. App Store (Google Play Store, Apple App Store)
    9.2. Desktop Stores (Microsoft Store, Mac App Store, Snapcraft/Flatpak for Linux)
    9.3. CI/CD Pipeline (e.g., Codemagic, GitHub Actions for Flutter)
10. **Future Considerations / Scalability (from an engineering perspective)**
    10.1. More sophisticated on-device AI processing (e.g., TensorFlow Lite for Flutter).
    10.2. Advanced context-aware background monitoring.
    10.3. Deeper OS-level integrations.

---

This is the structural outline. I will now begin to populate these sections with specific details relevant to a Flutter implementation. This will be a substantial piece of work.

I'll start with **Sections 1 and 2 (Introduction, Overall Architecture)**.

---

## **Water Coach: Software Engineering Specifications (Flutter)**

**Version:** 1.0
**Date:** October 26, 2023
**Project Lead:** John Victor
**Target Platform:** Cross-Platform (iOS, Android, Windows, macOS, Linux) using Flutter

**1. Introduction**

**1.1. Purpose of this Document**
This document outlines the software engineering specifications for the Water Coach application. It details the technical architecture, module breakdowns, feature implementation guidelines, data models, and non-functional requirements necessary for the development team to build a robust, scalable, and high-performing cross-platform application using the Flutter framework. It translates the Product Specifications Document into actionable technical plans.

**1.2. Project Overview (Brief recap from Product Specs)**
Water Coach is an innovative AI-powered application designed to act as a personal coach, guiding users through work, study, or any on-device "quest" with actionable, real-time advice. By monitoring device activity and user input (primarily voice-driven), Water Coach aims to enhance productivity, maintain focus, and empower users to achieve their goals effectively. Key features include personalized AI coaching, real-time support, flexible interaction modes, universal platform access, and external tool integration.

**1.3. Target Platforms & Flutter Rationale**
*   **Target Platforms:** iOS, Android, Windows, macOS, Linux.
*   **Flutter Rationale:** Flutter has been chosen as the primary development framework due to its ability to deliver high-quality, natively compiled applications for multiple platforms from a single codebase. This significantly accelerates development, reduces maintenance overhead, and ensures a consistent user experience across all targeted devices. Flutter's rich widget library, excellent performance, and strong community support make it ideal for an application like Water Coach that requires a sophisticated UI and potential low-level device interactions.

**2. Overall Architecture**

**2.1. High-Level Architecture Diagram (Client-AI Backend interaction)**

```mermaid
graph TD
    subgraph FlutterClient [Water Coach Flutter Client (iOS, Android, Desktop)]
        direction LR
        UI[UI Layer (Widgets, Screens)]
        SM[State Management (e.g., Riverpod/BLoC)]
        NAV[Navigation]
        Logic[Business Logic Modules]
        NativeBridge[Platform Channels/FFI (for specific native features)]
        LocalDB[Local Storage (SQLite/SharedPreferences)]
    end

    subgraph AI_Backend [AI Coaching Backend Service]
        direction LR
        API_GW[API Gateway]
        AuthService[Authentication Service - Optional, if backend handles user accounts beyond client]
        NLP_Core[NLP & Prompt Processing Engine]
        AI_Model[Core Coaching AI Model(s)]
        ContextDB[Session Context DB - temporary]
    end

    UI --> SM
    SM --> Logic
    Logic --> NativeBridge
    Logic --> LocalDB
    Logic -->|HTTPS/gRPC/WebSockets API Calls| API_GW

    API_GW --> AuthService
    API_GW --> NLP_Core
    NLP_Core --> AI_Model
    NLP_Core --> ContextDB
    AI_Model --> NLP_Core
```
*   **Flutter Client:** Handles all user interactions, local data persistence for active sessions/settings, and manages communication with the AI Backend Service.
*   **AI Coaching Backend Service:** Responsible for the core AI logic, processing user inputs and device context to generate coaching advice. This service will house the main AI model(s).

**2.2. Client-Side Architecture (Flutter App)**

    **2.2.1. Modular Design (Feature Modules):**
        The Flutter application will be structured into distinct feature modules to promote separation of concerns, testability, and maintainability. Example modules:
        *   `auth/`: User authentication and profile management.
        *   `quest_management/`: Creating, tracking, and managing user quests/sessions.
        *   `ai_interaction/`: UI and logic for voice/text communication with the AI.
        *   `device_monitoring/`: Platform-specific code for activity tracking.
        *   `overlay_ui/`: Logic for the hovering icon.
        *   `integrations/`: Connecting with external tools.
        *   `settings/`: User preferences.
        *   `core/` or `shared/`: Common utilities, widgets, models, and services.

    **2.2.2. State Management Strategy:**
        *   **Recommendation:** **Riverpod** or **BLoC/Cubit**.
            *   **Riverpod:** Offers compile-safe dependency injection and state management, flexible and scalable. Good for managing complex app states and dependencies between modules.
            *   **BLoC/Cubit:** Provides a clear separation of business logic from UI, promoting testability. Cubit is a simpler subset of BLoC suitable for many cases.
        *   The chosen strategy will be applied consistently across all modules to manage UI state, application data, and interactions with backend services.

    **2.2.3. Navigation:**
        *   **Recommendation:** Flutter's **Navigator 2.0** (Router widget) for more complex navigation scenarios, deep linking, and better state management of navigation stacks.
        *   Alternatively, a simpler package like `go_router` can be used if Navigator 2.0 proves overly complex for initial needs.
        *   Named routes will be used for clarity and maintainability.

**2.3. Backend Integration (AI Coaching Service)**

    **2.3.1. API Communication:**
        *   **Primary Recommendation:** **gRPC** for performance-critical, low-latency communication, especially for real-time coaching interactions if streaming voice/data. gRPC uses Protocol Buffers for efficient serialization.
        *   **Alternative/Fallback:** **RESTful APIs (HTTPS)** using JSON for less frequent or non-real-time data exchange (e.g., session synchronization, fetching user settings if cloud-stored).
        *   **WebSockets:** Could be considered for persistent bidirectional communication if the coaching model benefits significantly from a continuous stream of context and provides continuous feedback.
        *   The `http` or `dio` package in Flutter for REST, and `grpc` package for gRPC.
        *   Secure communication using TLS/SSL is mandatory.
        *   Authentication tokens (e.g., JWT) will be used to secure API requests after user login.
Understood, John. Let's proceed with detailing **Section 3: Core Modules & Features (Flutter Implementation Details)** for the Water Coach Software Engineering Specifications.

**3. Core Modules & Features (Flutter Implementation Details)**

**3.1. User Authentication Module (`auth/`)**

    **3.1.1. UI Components (Flutter Widgets):**
        *   `LoginScreen.dart`: `Scaffold`, `Form` (with `TextFormField` for email/password), `ElevatedButton` for login, `TextButton` for "Forgot Password," social login buttons (e.g., custom `SignInButton` widgets or pre-built package widgets).
        *   `RegistrationScreen.dart`: Similar to `LoginScreen` with additional fields for registration (e.g., name, confirm password).
        *   `ForgotPasswordScreen.dart`: `TextFormField` for email, `ElevatedButton` to send reset link.
        *   Reusable input field widgets (`CustomTextField.dart`) for consistent styling and validation.

    **3.1.2. Logic & Backend Integration:**
        *   **Recommendation:** **Firebase Authentication** or **Supabase Authentication**.
            *   **Firebase Auth:** Robust, scalable, supports email/password, phone, and various OAuth providers (Google, Apple, Facebook, etc.). Good Flutter integration with `firebase_auth` package.
            *   **Supabase Auth:** Open-source alternative to Firebase, also offers good Flutter support (`supabase_flutter` package) and similar features.
        *   If a custom backend is preferred, standard token-based authentication (JWT) will be implemented. The Flutter client will handle token storage securely (e.g., using `flutter_secure_storage`).
        *   Form validation using `Form` widget's `validator` properties or packages like `form_field_validator`.
        *   API calls for login, registration, password reset, social sign-in using `http` or `dio`.

    **3.1.3. State Management for Auth Status:**
        *   The chosen state management solution (Riverpod/BLoC) will manage the user's authentication state globally (e.g., `AuthState` indicating `authenticated`, `unauthenticated`, `loading`).
        *   App navigation will react to changes in `AuthState` (e.g., redirecting to home screen on successful login or to login screen on logout).

**3.2. Quest Management Module (`quest_management/`) ("Session Management")**

    **3.2.1. UI Components (Flutter Widgets):**
        *   `QuestCreationScreen.dart`: `Scaffold`, `TextFormField` (multiline) for quest description, `ElevatedButton` ("Start Quest"), potentially date/time pickers if quests can be scheduled.
        *   `ActiveQuestScreen.dart` / `CoachingDashboard.dart`: Displays current quest description, timer, AI suggestions, interaction controls (see 3.3).
        *   `QuestHistoryScreen.dart`: `ListView.builder` to display past quests, perhaps with summaries or access to logs. Each item could be a `Card` or `ListTile`.
        *   `QuestListItem.dart`: A reusable widget for displaying a single quest in a list.

    **3.2.2. Data Models (`quest_model.dart`):**
        *   `Quest` class:
            ```dart
            class Quest {
              String id; // Unique ID
              String description;
              DateTime startTime;
              DateTime? endTime;
              QuestStatus status; // e.g., active, completed, paused
              List<String>? aiInteractionLogs; // Optional: for history
              // Potentially other metadata like duration, associated tasks
            }

            enum QuestStatus { pending, active, paused, completed, cancelled }
            ```

    **3.2.3. Local Storage:**
        *   **Active Quest Data:** For an ongoing quest, its state (description, start time, current AI interaction log) should be persisted locally to survive app restarts.
            *   **`shared_preferences`:** Suitable for simple key-value data of the active quest.
            *   **`sqflite`:** For more structured storage if quest data becomes complex or if a richer history needs to be stored locally.
        *   **Offline Drafts:** Allow users to draft a quest description even if offline, saving it locally until they can start it with an internet connection.

**3.3. AI Coaching Interaction Module (`ai_interaction/`)**

    **3.3.1. UI Components (Flutter Widgets):**
        *   Within `ActiveQuestScreen.dart` or a dedicated `AICoachChatWidget.dart`:
            *   `ListView.builder` or `ChatList` (from packages like `dash_chat_2`) to display the conversation history with the AI coach.
            *   `MessageBubble.dart` custom widgets for user inputs and AI responses.
            *   `TextField` for text input.
            *   `IconButton` for voice input (microphone icon).
            *   UI elements to display AI-generated suggestions or insights (e.g., in dismissible cards, integrated into the chat, or a separate panel).

    **3.3.2. Voice Input/Output:**
        *   **3.3.2.1. Speech-to-Text (STT) Integration:**
            *   Use the `speech_to_text` package.
            *   Handle microphone permissions (`permission_handler` package).
            *   Provide UI feedback during listening (e.g., animated microphone icon, sound waves).
            *   Manage STT state (listening, processing, result).
        *   **3.3.2.2. Text-to-Speech (TTS) Integration:**
            *   Use the `flutter_tts` package.
            *   Allow users to select voice/language if supported by the package/OS.
            *   Manage TTS state (speaking, stopped) and queueing of messages.
            *   Provide option in settings to enable/disable TTS for AI responses.

    **3.3.3. Natural Language Processing (NLP) Client Logic:**
        *   This module primarily focuses on capturing user input (text or transcribed voice) and relevant context from the device (see 3.4).
        *   This data is then packaged and sent to the AI Backend Service via API calls.
        *   The actual NLP for understanding intent and generating coaching prompts happens on the backend.

**3.4. Device Activity Monitoring Module (`device_monitoring/`) (Platform-Specific Considerations)**
This is the most technically complex and privacy-sensitive module. Implementation will heavily rely on platform channels to access native APIs. **Explicit user consent and transparent privacy policies are paramount.**

    **3.4.1. Screen Content Analysis (Highly Complex & Permission-Intensive):**
        *   **Goal:** To understand what the user is currently working on (e.g., application name, window title, potentially on-screen text via OCR if feasible and permitted).
        *   **Flutter Implementation:** Requires platform channels to native code.
            *   **Android:** Utilize `AccessibilityService` API. This requires special user permission and has strict guidelines. The service can read window content and events.
            *   **iOS:** Extremely limited due to privacy restrictions. Reading arbitrary screen content from other apps is generally not possible. Potential workarounds (with significant limitations and UX challenges):
                *   User-initiated screenshots that the app then processes with OCR.
                *   Focus on app usage data if available (see 3.4.2).
            *   **Desktop (Windows, macOS, Linux):**
                *   Platform-specific APIs to get active window title and application name (e.g., using `Process` class in Dart for some info, or native calls via FFI/platform channels for more detail – e.g., Win32 API, Cocoa, X11).
                *   Screen capture APIs for OCR (requires user permission for screen recording/capture). Libraries like `screen_capturer` might be a starting point, coupled with an OCR engine.
        *   **OCR:** If screen text is captured, an on-device or cloud OCR service would be needed. On-device (e.g., `google_ml_kit_text_recognition`) is preferred for privacy.

    **3.4.2. Application Usage Tracking:**
        *   **Goal:** Identify currently active application or foreground app.
        *   **Flutter Implementation (Platform Channels):**
            *   **Android:** `UsageStatsManager` API (requires `PACKAGE_USAGE_STATS` permission). The `usage_stats` package might provide this.
            *   **iOS:** Very limited. Cannot get a list of running apps or detailed usage of other apps. Focus might be on Water Coach's own active time.
            *   **Desktop:** Native APIs to get foreground window/application process information.

    **3.4.3. Input Monitoring (Keyboard/Mouse - Extremely Sensitive):**
        *   **Goal:** Potentially understand user engagement or type of activity (e.g., typing vs. idle).
        *   **Implementation:** This is **highly invasive and generally discouraged** due to extreme privacy concerns and OS restrictions. If considered *at all*, it would require:
            *   Very explicit, granular user consent for specific, limited purposes.
            *   Platform-specific native code (e.g., global key listeners on desktop, which are often flagged by security software).
            *   **Recommendation:** Avoid direct keylogging. Focus on less invasive metrics like active window or application type.

    **3.4.4. Data Formatting & Transmission to AI Backend:**
        *   Collected context (active app, window title, summarized screen content if available and permitted) is structured (e.g., JSON).
        *   Sent securely to the AI backend service along with user's direct input to inform coaching advice.
        *   Minimize data sent; send only what is necessary for contextual coaching.

    **3.4.5. User Permissions & Privacy Handling (Crucial):**
        *   Use `permission_handler` package to request all necessary permissions (microphone, accessibility, usage stats, screen capture if applicable).
        *   Clear, upfront explanation to the user about *what* data is being monitored, *why*, and *how* it's used.
        *   Easy-to-access settings for users to toggle monitoring features on/off.
        *   Adherence to a strict privacy policy.

**3.5. Hovering Icon/Overlay Module (`overlay_ui/`)**

    **3.5.1. Implementation:**
        *   **Flutter's `Overlay` and `OverlayEntry` widgets:** Can be used to display a floating widget on top of the app's UI.
        *   **For system-wide overlay (drawing over other apps - primarily for Android and Desktop):**
            *   **Android:** Requires `SYSTEM_ALERT_WINDOW` permission. Implement via platform channel to a native Android Service that manages the overlay window (e.g., using `WindowManager`). Packages like `flutter_overlay_window` exist.
            *   **Desktop (Windows, macOS, Linux):** Flutter's desktop embedding allows creating always-on-top, transparent, click-through windows. The main app window could be minimized while a small overlay window remains.
            *   **iOS:** System-wide overlays are not permitted for third-party apps. The hovering icon would be limited to within the Water Coach app itself or potentially via features like Picture-in-Picture if applicable to the interaction model.

    **3.5.2. Animated Icon States:**
        *   Use Flutter's animation framework (`AnimationController`, `AnimatedWidget`, packages like `rive` or `lottie`) for icon states (e.g., pulsing when idle, spinning when listening, glowing when a new suggestion is available).
        *   Icon assets (SVG or high-res PNGs).

    **3.5.3. Interaction:**
        *   `GestureDetector` on the overlay icon.
        *   Single tap: Opens/maximizes the main Water Coach app interface or shows a quick actions menu.
        *   Long press (optional): Could trigger voice input directly.

**3.6. External Tool Integration Module (`integrations/`)**

    **3.6.1. API Client Logic:**
        *   For each targeted external tool (e.g., Google Calendar, Todoist, Jira), implement API client services within Flutter.
        *   Use `http` or `dio` for making REST API calls.
        *   Define data models for the responses from these APIs.

    **3.6.2. OAuth 2.0 Handling for Secure Authorization:**
        *   Use packages like `flutter_appauth` or `uni_links` (for handling redirect URIs) in conjunction with `url_launcher` to initiate OAuth 2.0 flows.
        *   Securely store access tokens and refresh tokens (e.g., using `flutter_secure_storage`).
        *   Handle token refresh logic.
        *   Provide UI for users to connect/disconnect integrations.

**3.7. Settings Module (`settings/`)**

    **3.7.1. UI Components (Flutter Widgets):**
        *   `SettingsScreen.dart`: `ListView` with `ListTile`s or custom setting row widgets.
        *   `SwitchListTile` for boolean settings (e.g., enable/disable monitoring, TTS).
        *   Navigation to sub-screens for managing integrations, account details, privacy policy, etc.

    **3.7.2. Local Persistence of Settings:**
        *   Use `shared_preferences` to store user settings locally on the device.
        *   Load settings on app startup and apply them.

**3.8. Cross-Platform Synchronization Module (`sync/`)**
This module ensures session continuity if a user switches devices. Requires backend support.

    **3.8.1. Backend Service for Syncing:**
        *   The AI Backend Service (or a dedicated sync service) needs endpoints to store and retrieve session state (active quest description, progress, AI interaction highlights).
        *   Data should be associated with the authenticated user.

    **3.8.2. Client Logic:**
        *   Periodically (or on significant state changes) sync active session data to the backend.
        *   On app startup or when resuming a session on a new device, fetch the latest session state from the backend.

    **3.8.3. Conflict Resolution Strategy (if needed):**
        *   If simultaneous edits could occur (less likely for a single-active-session coach), a simple "last write wins" or timestamp-based strategy might suffice. For Water Coach, typically one device is active at a time for a given session.



**4. AI Backend Service (Conceptual - for Flutter client interaction)**

The AI Backend Service is the intelligent core that processes information from the Flutter client and generates coaching guidance.

    **4.1. API Endpoints (Illustrative):**
        *   `/session/start`: Initializes a new coaching quest. Input: `QuestDescription`, `UserSettings`.
        *   `/session/updateContext`: Receives ongoing user input (text/voice transcript) and monitored device context. Input: `SessionID`, `UserInput`, `DeviceContext`. Output: `CoachingAdvice`, `Suggestions`.
        *   `/session/end`: Finalizes a quest. Input: `SessionID`.
        *   *(Potentially endpoints for session history sync if not handled by a separate service).*

    **4.2. Input Requirements from Client:**
        *   **Session Context:** Unique session ID, initial quest description, user-defined goals.
        *   **User Input:** Transcribed voice commands/queries, typed text.
        *   **Monitored Device Data (Permissioned & Minimized):** Active application/window title, summarized on-screen content (if feasible & permitted), interaction type (e.g., typing, browsing).

    **4.3. Output Format to Client:**
        *   **Coaching Advice:** Actionable, concise guidance (text, convertible to speech).
        *   **Suggestions:** Proactive tips, relevant information snippets, potential next steps.
        *   **Structured Data (Optional):** For richer UI display (e.g., links, task breakdowns).

    **4.4. System Prompt Engineering:**
        *   The core AI model(s) on the backend will be guided by a sophisticated system prompt.
        *   This prompt will incorporate:
            *   The overall coaching philosophy of Water Coach.
            *   Instructions on how to interpret user input and device context.
            *   Guidelines for generating helpful, encouraging, and focused advice.
            *   Strategies for maintaining user engagement and productivity.
            *   Logic to handle different types of quests (work, study, personal).

**5. Data Models & Persistence (Flutter Client)**

Focus on lean, efficient data structures, primarily managed locally.

    **5.1. User Profile (`user_profile.dart` - Minimal Local Storage):**
        *   `userId` (if authenticated with backend)
        *   `displayName` (optional)
        *   `settings` (reference to `AppSettings` model)

    **5.2. Quest/Session Data (`quest_model.dart`):**
        *   `id`: String (UUID)
        *   `description`: String
        *   `startTime`: DateTime
        *   `endTime`: DateTime?
        *   `status`: Enum (`QuestStatus { active, paused, completed }`)
        *   `log`: List<`InteractionLogEntry`> (brief log of key interactions/advice for local history or sync)

    **5.3. AI Interaction Log Entry (`interaction_log_entry.dart`):**
        *   `timestamp`: DateTime
        *   `speaker`: Enum (`Speaker { user, ai }`)
        *   `content`: String

    **5.4. App Settings (`app_settings.dart`):**
        *   `enableMonitoring`: bool
        *   `interactionMode`: Enum (`InteractionMode { voice, text }`)
        *   `enableTTS`: bool
        *   `connectedIntegrations`: List<String> (identifiers for connected tools)

    **5.5. Local Persistence Strategy:**
        *   **`shared_preferences`:** For `AppSettings` and simple state of the *current* active `Quest`.
        *   **`sqflite` (Optional but Recommended for History):** For storing a list of completed `Quest` objects and their `InteractionLogEntry` items if robust local history is desired. Provides better querying and structure than flat files for larger datasets.

**6. User Interface (UI) / User Experience (UX) Design Principles (Flutter Specific)**

*   **Simplicity & Clarity:** Intuitive, uncluttered interface. Minimal cognitive load.
*   **Adaptive UI:** Utilize Material Design (Android) and Cupertino (iOS) widgets or adaptive theming for a native look and feel where appropriate (`ThemeData.adaptive`).
*   **Responsiveness:** Ensure layouts adapt gracefully to various screen sizes (mobile, tablet, desktop) and orientations using Flutter's layout widgets (e.g., `LayoutBuilder`, `MediaQuery`).
*   **Performance:** Prioritize smooth 60fps animations and transitions. Optimize widget builds.
*   **Accessibility:** Implement ARIA-like semantics using `Semantics` widget, ensure good color contrast, support dynamic font sizes, and test with screen readers (TalkBack, VoiceOver).
*   **Feedback & Engagement:** Clear visual/auditory feedback for voice input, AI processing, and suggestions. Subtle animations for the hovering icon to indicate state.

**7. Non-Functional Requirements (Technical Implementation Summary)**

*   **Performance:** Client app startup < 3s. Perceived AI response < 2s. UI interactions @ 60fps.
*   **Scalability (Backend):** AI backend must handle concurrent user requests efficiently.
*   **Security:** HTTPS for all API calls. Secure storage for any sensitive local data (e.g., API tokens for integrations via `flutter_secure_storage`). Strict permission handling for device monitoring.
*   **Reliability:** Graceful error handling in the app (e.g., network issues, API errors). Data persistence to prevent loss of active session. Aim for high backend uptime.
*   **Maintainability:** Modular Flutter code, clear state management patterns, comprehensive comments, adherence to Dart linting rules.
*   **Testability:** High unit and widget test coverage. Integration tests for key user flows.

**8. Development Environment & Tools (Flutter)**

*   **Flutter SDK:** Latest stable version.
*   **Dart SDK:** Version compatible with Flutter SDK.
*   **Key Flutter Packages (Illustrative):**
    *   State Management: `flutter_riverpod` / `flutter_bloc`
    *   Networking: `http` / `dio`
    *   Local Storage: `shared_preferences`, `sqflite`
    *   Secure Storage: `flutter_secure_storage`
    *   Permissions: `permission_handler`
    *   STT/TTS: `speech_to_text`, `flutter_tts`
    *   Navigation: `go_router` or Navigator 2.0
    *   Authentication (if using Firebase/Supabase): `firebase_auth`, `supabase_flutter`
    *   Device Info: `device_info_plus`
    *   Platform-Specific Overlay: `flutter_overlay_window` (Android)
*   **IDE:** Android Studio or VS Code with Flutter/Dart extensions.
*   **Version Control:** Git (e.g., GitHub, GitLab).

**9. Deployment**

*   **Mobile:** Google Play Store (Android), Apple App Store (iOS). Adhere to all store guidelines, especially regarding permissions and background activity.
*   **Desktop:**
    *   Windows: Microsoft Store, MSIX packaging.
    *   macOS: Mac App Store, .dmg distribution.
    *   Linux: Snapcraft, Flatpak, AppImage.
*   **CI/CD:** Implement a Continuous Integration/Continuous Deployment pipeline (e.g., Codemagic, GitHub Actions for Flutter, Fastlane) for automated builds, tests, and deployments.

**10. Future Considerations / Scalability (from an engineering perspective)**

*   **On-Device AI:** Explore TensorFlow Lite for Flutter (`tflite_flutter` package) or Core ML/NNAPI integrations for simple, privacy-preserving on-device ML tasks (e.g., basic intent recognition before hitting the backend).
*   **Advanced Background Monitoring:** For more sophisticated context awareness, investigate platform-specific background execution capabilities (requires careful battery optimization and adherence to OS limits).
*   **Deeper OS-Level Integrations:** E.g., Share extensions, App Intents, system-wide services where permitted by the OS, to make Water Coach more seamlessly integrated.
*   **Real-time Collaboration Features (if product direction evolves):** Consider WebRTC or Firebase Realtime Database/Firestore for multi-user scenarios (not in current scope).
*   **Modular AI Backend:** Design the AI backend to easily swap or add new core AI models as technology improves.
