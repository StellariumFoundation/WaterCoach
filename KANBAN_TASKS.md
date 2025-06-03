# Project: Water Coach Kanban Board

**Epics (High-Level Features from README Modules):**

1.  **Epic: User Authentication**
2.  **Epic: Quest Management (Session Management)**
3.  **Epic: AI Coaching Interaction**
4.  **Epic: Device Activity Monitoring** (High Risk/Complexity)
5.  **Epic: Hovering Icon/Overlay**
6.  **Epic: External Tool Integration**
7.  **Epic: Settings Management**
8.  **Epic: Cross-Platform Synchronization**
9.  **Epic: Core Architecture & DX (Developer Experience)**
10. **Epic: Backend AI Service Integration (Client-Side)**
11. **Epic: UI/UX Development**
12. **Epic: Testing & Quality Assurance**
13. **Epic: Build & Deployment Setup**

---

**Stories / Tasks (Categorized by Epic):**

**1. Epic: User Authentication**
    *   **Story:** User can register for a new account.
        *   Task: Design Registration Screen UI (`RegistrationScreen.dart`).
        *   Task: Implement registration form with validation (name, email, password, confirm password).
        *   Task: Integrate with chosen auth backend (Firebase/Supabase/Custom) for registration.
        *   Task: Implement state management for registration flow.
    *   **Story:** User can log in with email and password.
        *   Task: Design Login Screen UI (`LoginScreen.dart`).
        *   Task: Implement login form with validation.
        *   Task: Integrate with auth backend for login.
        *   Task: Implement state management for login flow and global auth state.
    *   **Story:** User can log in using social providers (e.g., Google).
        *   Task: Add social login buttons to Login Screen.
        *   Task: Implement social login integration with auth backend.
    *   **Story:** User can request a password reset.
        *   Task: Design Forgot Password Screen UI (`ForgotPasswordScreen.dart`).
        *   Task: Implement "send password reset link" functionality.
    *   Task: Create reusable `CustomTextField.dart` for forms.
    *   Task: Implement secure token storage (e.g., `flutter_secure_storage`) and management.
    *   Task: Ensure app navigation reacts correctly to authentication state changes.

**2. Epic: Quest Management (Session Management)**
    *   **Story:** User can create a new quest.
        *   Task: Design Quest Creation Screen UI (`QuestCreationScreen.dart`).
        *   Task: Implement quest description input.
        *   Task: Implement "Start Quest" functionality.
        *   Task: (Optional) Add date/time pickers for scheduled quests.
    *   **Story:** User can view and manage an active quest.
        *   Task: Design Active Quest Screen / Coaching Dashboard UI (`ActiveQuestScreen.dart`).
        *   Task: Display current quest description, timer, and AI interaction elements.
    *   **Story:** User can view their quest history.
        *   Task: Design Quest History Screen UI (`QuestHistoryScreen.dart`).
        *   Task: Implement ListView to display past quests (use `QuestListItem.dart`).
        *   Task: Allow viewing summaries or logs of past quests.
    *   Task: Define `Quest` data model and `QuestStatus` enum.
    *   Task: Implement local storage for active quest data (`shared_preferences` or `sqflite`).
    *   Task: Implement logic for offline quest draft creation and saving.
    *   Task: (If `sqflite` chosen) Design and implement DB schema for quest history.

**3. Epic: AI Coaching Interaction**
    *   **Story:** User can interact with the AI coach via text.
        *   Task: Design chat interface within Active Quest Screen (or `AICoachChatWidget.dart`).
        *   Task: Implement `TextField` for text input.
        *   Task: Create `MessageBubble.dart` for displaying user/AI messages.
        *   Task: Display AI suggestions/insights in the UI.
    *   **Story:** User can interact with the AI coach via voice (STT).
        *   Task: Add voice input button (microphone icon) to UI.
        *   Task: Integrate `speech_to_text` package.
        *   Task: Handle microphone permissions using `permission_handler`.
        *   Task: Implement UI feedback for listening state (e.g., animations).
        *   Task: Manage STT state (listening, processing, result).
    *   **Story:** User can hear AI coach responses (TTS).
        *   Task: Integrate `flutter_tts` package.
        *   Task: Implement TTS for AI responses.
        *   Task: Manage TTS state (speaking, stopped) and message queueing.
        *   Task: (Optional) Allow voice/language selection for TTS in settings.
    *   Task: Implement client-side logic to capture input/context and send to AI Backend.

**4. Epic: Device Activity Monitoring** (High Risk/Complexity - Requires careful platform-specific work & privacy focus)
    *   **Story:** (Android) App can identify the current foreground application for context.
        *   Task: Implement platform channel for Android `UsageStatsManager` API.
        *   Task: Integrate `usage_stats` package or build custom solution.
        *   Task: Handle `PACKAGE_USAGE_STATS` permission.
    *   **Story:** (Desktop) App can identify the active window title for context.
        *   Task: Implement platform channel/FFI for desktop native APIs (Windows, macOS, Linux) to get active window title.
    *   **Story:** (Optional/High Risk) App can perform screen content analysis via OCR (user-consented).
        *   Task: Research and implement platform channels for screen capture (desktop) or accessibility services (Android).
        *   Task: Integrate an OCR library (e.g., `google_ml_kit_text_recognition`).
    *   Task: Implement robust user permission requests (`permission_handler`) for all monitoring features.
    *   Task: Design and implement clear UI explanations for *what* data is monitored and *why*.
    *   Task: Ensure data collected is minimized, formatted (JSON), and transmitted securely.
    *   Task: Add settings toggles for all monitoring features.
    *   **Spike:** Investigate feasibility and limitations of screen content analysis on iOS.
    *   **Spike:** Thoroughly evaluate privacy implications and ethical considerations of any input monitoring (keyboard/mouse generally discouraged).

**5. Epic: Hovering Icon/Overlay**
    *   **Story:** (Android/Desktop) User can see a hovering icon that provides quick access/status.
        *   Task: (Android) Implement system-wide overlay using native Service and `SYSTEM_ALERT_WINDOW` permission (e.g., via `flutter_overlay_window` or custom).
        *   Task: (Desktop) Implement always-on-top, transparent, click-through window for overlay.
        *   Task: Design animated icon states (idle, listening, suggesting) using Flutter animations or packages (`rive`/`lottie`).
        *   Task: Implement interactions for the icon (tap to open app/quick actions, long-press for voice).
    *   **Story:** (iOS) User can see an in-app overlay icon.
        *   Task: Implement in-app overlay using Flutter's `Overlay` and `OverlayEntry` widgets.
    *   Task: Create icon assets (SVG/PNG).

**6. Epic: External Tool Integration**
    *   **Story:** User can connect their account for [Selected Tool, e.g., Google Calendar].
        *   Task: Implement OAuth 2.0 flow for [Selected Tool] (using `flutter_appauth`, `uni_links`, `url_launcher`).
        *   Task: Securely store OAuth tokens (`flutter_secure_storage`).
        *   Task: Implement API client logic to interact with [Selected Tool]'s API (`http`/`dio`).
        *   Task: Define data models for [Selected Tool]'s API responses.
        *   Task: Create UI for connecting/disconnecting the integration in Settings.
    *   *(Repeat for other desired integrations like Todoist, Jira, etc.)*

**7. Epic: Settings Management**
    *   **Story:** User can configure application settings.
        *   Task: Design Settings Screen UI (`SettingsScreen.dart`).
        *   Task: Implement UI components for various settings (toggles for monitoring, TTS, interaction mode selection, integration management).
        *   Task: Use `SwitchListTile` for boolean settings.
        *   Task: Implement navigation to sub-screens (account details, privacy policy, integration management).
    *   Task: Implement local persistence of settings using `shared_preferences`.
    *   Task: Load settings on app startup and apply them.
    *   Task: Define `AppSettings` and `InteractionMode` data models.

**8. Epic: Cross-Platform Synchronization**
    *   **Story:** User's active quest data can sync across their devices.
        *   Task (Client-side): Implement logic to periodically (or on state change) sync active session data to the backend.
        *   Task (Client-side): Implement logic to fetch latest session state from backend on startup/resume.
        *   Task (Client-side): Define conflict resolution strategy (e.g., last write wins) if needed.
    *   Task (Backend Alignment): Align client-side sync logic with backend sync service endpoints and data models.

**9. Epic: Core Architecture & DX (Developer Experience)**
    *   Task: Set up Flutter project structure with feature modules (`auth/`, `quest_management/`, etc.) and a `core/` or `shared/` module.
    *   Task: **Decide and integrate** a state management solution (e.g., Riverpod, BLoC/Cubit) consistently.
    *   Task: **Decide and integrate** a navigation strategy (Navigator 2.0 or `go_router`) and define named routes.
    *   Task: Add core packages to `pubspec.yaml`: state management, networking, permissions, secure storage.
    *   Task: Configure Dart linting rules and ensure they are followed.
    *   Task: Document architectural decisions and justifications.
    *   Task: Set up Git repository with branching strategy and commit guidelines.

**10. Epic: Backend AI Service Integration (Client-Side)**
    *   Task: Implement client-side functions to call defined backend API endpoints (e.g., `/session/start`, `/session/updateContext`, `/session/end`).
    *   Task: Ensure client prepares and sends all required input data (Session Context, User Input, Monitored Device Data) in the correct format to the backend.
    *   Task: Implement logic to parse and utilize backend output (Coaching Advice, Suggestions, Structured Data) in the UI.
    *   Task: Implement chosen API communication client (e.g., `http`, `dio`, or `grpc` package).
    *   Task: Ensure secure API communication (HTTPS) and authentication token handling.

**11. Epic: UI/UX Development**
    *   Task: Develop a consistent UI theme (Material/Cupertino, adaptive theming).
    *   Task: Ensure all UI development adheres to responsiveness principles for various screen sizes/orientations.
    *   Task: Implement accessibility features (Semantics, color contrast, dynamic fonts, screen reader testing).
    *   Task: Design and implement clear visual/auditory feedback mechanisms throughout the app.
    *   Task: Profile and optimize UI performance for smooth 60fps animations and interactions.

**12. Epic: Testing & Quality Assurance**
    *   Task: Develop a comprehensive testing strategy (unit, widget, integration).
    *   Task: Write unit tests for all data models and business logic in each module.
    *   Task: Write widget tests for reusable UI components and screens.
    *   Task: Write integration tests for key user flows (e.g., registration > login > start quest > AI interaction).
    *   Task: Implement robust error handling and reporting mechanisms.
    *   Task: Perform manual testing on all target platforms and devices.

**13. Epic: Build & Deployment Setup**
    *   Task: Ensure all developers use the agreed-upon Flutter SDK version.
    *   Task: Set up developer accounts for Google Play Store and Apple App Store.
    *   Task: Prepare app store listing materials (descriptions, screenshots, privacy policy).
    *   Task: Configure app signing for Android (keystore) and provisioning for iOS.
    *   Task: (If pursuing Desktop) Plan and set up packaging for Windows (MSIX), macOS (.dmg), and Linux (Snap/Flatpak/AppImage).
    *   Task: **Decide and implement** a CI/CD solution (e.g., Codemagic, GitHub Actions).
    *   Task: Configure automated builds, tests, and deployments in the CI/CD pipeline.
