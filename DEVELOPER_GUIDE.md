# Water Coach Developer Guide

## Table of Contents

- [1. Project Overview and Technical Introduction](#1-project-overview-and-technical-introduction)
  - [1.1. Purpose of this Document](#11-purpose-of-this-document)
  - [1.2. Project Summary (from Product Specs)](#12-project-summary-from-product-specs)
  - [1.3. Target Platforms & Flutter Rationale](#13-target-platforms--flutter-rationale)
- [2. Build and Setup Instructions](#2-build-and-setup-instructions)
  - [2.1. Prerequisites](#21-prerequisites)
  - [2.2. Cloning the Project and Installing Dependencies](#22-cloning-the-project-and-installing-dependencies)
  - [2.3. Platform-Specific Setup](#23-platform-specific-setup)
    - [2.3.1. iOS (for macOS users)](#231-ios-for-macos-users)
    - [2.3.2. Android](#232-android)
    - [2.3.3. Windows](#233-windows)
    - [2.3.4. macOS (Desktop)](#234-macos-desktop)
    - [2.3.5. Linux](#235-linux)
  - [2.4. Running the Application](#24-running-the-application)
  - [2.5. Basic Troubleshooting Tips](#25-basic-troubleshooting-tips)
- [3. Coding Standards and Conventions](#3-coding-standards-and-conventions)
  - [3.1. Dart Language](#31-dart-language)
  - [3.2. Flutter Specifics](#32-flutter-specifics)
  - [3.3. Naming Conventions](#33-naming-conventions)
  - [3.4. Comments and Documentation](#34-comments-and-documentation)
  - [3.5. Error Handling](#35-error-handling)
  - [3.6. Linting](#36-linting)
- [4. System Architecture](#4-system-architecture)
  - [4.1. High-Level Architecture Diagram](#41-high-level-architecture-diagram)
  - [4.2. Client-Side Architecture (Flutter App)](#42-client-side-architecture-flutter-app)
    - [4.2.1. Modular Design (Feature Modules)](#421-modular-design-feature-modules)
    - [4.2.2. State Management Strategy](#422-state-management-strategy)
    - [4.2.3. Navigation](#423-navigation)
    - [4.2.4. Core/Shared Utilities and Services (Internal API Documentation)](#424-coreshared-utilities-and-services-internal-api-documentation)
  - [4.3. Backend Integration (AI Coaching Service)](#43-backend-integration-ai-coaching-service)
    - [4.3.1. API Communication](#431-api-communication)
    - [4.3.2. Rationale for Architectural Choices](#432-rationale-for-architectural-choices)
    - [4.3.3. Component Interaction & Data Flow](#433-component-interaction--data-flow)
    - [4.3.4. Common Design Patterns](#434-common-design-patterns)
- [5. Testing Guide](#5-testing-guide)
  - [5.1. Overview](#51-overview)
  - [5.2. Running Tests](#52-running-tests)
  - [5.3. Unit Tests](#53-unit-tests)
  - [5.4. Widget Tests](#54-widget-tests)
  - [5.5. Integration Tests](#55-integration-tests)
  - [5.6. Test Coverage](#56-test-coverage)
- [6. Contribution Workflow](#6-contribution-workflow)
  - [6.1. Branching Strategy](#61-branching-strategy)
  - [6.2. Pull Request (PR) Process](#62-pull-request-pr-process)
  - [6.3. Code Review Expectations](#63-code-review-expectations)
  - [6.4. CI/CD Developer Touchpoints](#64-cicd-developer-touchpoints)
  - [6.5. Commit Message Guidelines](#65-commit-message-guidelines)
- [7. Project Structure Overview](#7-project-structure-overview)
  - [7.1. `lib/` Directory Structure](#71-lib-directory-structure)
  - [7.2. Other Key Directories](#72-other-key-directories)
- [8. Debugging Guide](#8-debugging-guide)
  - [8.1. Using Flutter DevTools](#81-using-flutter-devtools)
  - [8.2. Logging Strategies](#82-logging-strategies)
  - [8.3. Debugging Platform-Specific Code](#83-debugging-platform-specific-code)
  - [8.4. Common Issues and Troubleshooting](#84-common-issues-and-troubleshooting)
- [9. Dependencies Management](#9-dependencies-management)
  - [9.1. Adding New Dependencies](#91-adding-new-dependencies)
  - [9.2. Policy on Updating Dependencies](#92-policy-on-updating-dependencies)
  - [9.3. Notes on Critical or Complex Dependencies](#93-notes-on-critical-or-complex-dependencies)
- [10. Module Deep Dive: Features & Implementation](#10-module-deep-dive-features--implementation)
  - [10.1. User Authentication Module (`auth/`)](#101-user-authentication-module-auth)
    - [10.1.1. UI Components (Flutter Widgets)](#1011-ui-components-flutter-widgets)
    - [10.1.2. Logic & Backend Integration](#1012-logic--backend-integration)
    - [10.1.3. State Management for Auth Status](#1013-state-management-for-auth-status)
  - [10.2. Quest Management Module (`quest_management/`) ("Session Management")](#102-quest-management-module-quest_management-session-management)
    - [10.2.1. UI Components (Flutter Widgets)](#1021-ui-components-flutter-widgets)
    - [10.2.2. Data Models (`quest_model.dart`)](#1022-data-models-quest_modeldart)
    - [10.2.3. Local Storage](#1023-local-storage)
  - [10.3. AI Coaching Interaction Module (`ai_interaction/`)](#103-ai-coaching-interaction-module-ai_interaction)
    - [10.3.1. UI Components (Flutter Widgets)](#1031-ui-components-flutter-widgets)
    - [10.3.2. Voice Input/Output](#1032-voice-inputoutput)
    - [10.3.3. Natural Language Processing (NLP) Client Logic](#1033-natural-language-processing-nlp-client-logic)
  - [10.4. Device Activity Monitoring Module (`device_monitoring/`) (Platform-Specific Considerations)](#104-device-activity-monitoring-module-device_monitoring-platform-specific-considerations)
    - [10.4.1. Screen Content Analysis (Highly Complex & Permission-Intensive)](#1041-screen-content-analysis-highly-complex--permission-intensive)
    - [10.4.2. Application Usage Tracking](#1042-application-usage-tracking)
    - [10.4.3. Input Monitoring (Keyboard/Mouse - Extremely Sensitive)](#1043-input-monitoring-keyboardmouse---extremely-sensitive)
    - [10.4.4. Data Formatting & Transmission to AI Backend](#1044-data-formatting--transmission-to-ai-backend)
    - [10.4.5. User Permissions & Privacy Handling (Crucial)](#1045-user-permissions--privacy-handling-crucial)
    - [10.4.6. Developer Notes for Native Code (Device Activity Monitoring)](#1046-developer-notes-for-native-code-device-activity-monitoring)
  - [10.5. Hovering Icon/Overlay Module (`overlay_ui/`)](#105-hovering-iconoverlay-module-overlay_ui)
    - [10.5.1. Implementation](#1051-implementation)
    - [10.5.2. Animated Icon States](#1052-animated-icon-states)
    - [10.5.3. Interaction](#1053-interaction)
    - [10.5.4. Developer Notes for Native Code (Hovering Icon/Overlay)](#1054-developer-notes-for-native-code-hovering-iconoverlay)
  - [10.6. External Tool Integration Module (`integrations/`)](#106-external-tool-integration-module-integrations)
    - [10.6.1. API Client Logic](#1061-api-client-logic)
    - [10.6.2. OAuth 2.0 Handling for Secure Authorization](#1062-oauth-20-handling-for-secure-authorization)
  - [10.7. Settings Module (`settings/`)](#107-settings-module-settings)
    - [10.7.1. UI Components (Flutter Widgets)](#1071-ui-components-flutter-widgets)
    - [10.7.2. Local Persistence of Settings](#1072-local-persistence-of-settings)
  - [10.8. Cross-Platform Synchronization Module (`sync/`)](#108-cross-platform-synchronization-module-sync)
    - [10.8.1. Backend Service for Syncing](#1081-backend-service-for-syncing)
    - [10.8.2. Client Logic](#1082-client-logic)
    - [10.8.3. Conflict Resolution Strategy (if needed)](#1083-conflict-resolution-strategy-if-needed)
- [11. AI Backend Service Interaction (Conceptual)](#11-ai-backend-service-interaction-conceptual)
  - [11.1. API Endpoints (Illustrative)](#111-api-endpoints-illustrative)
  - [11.2. Input Requirements from Client](#112-input-requirements-from-client)
  - [11.3. Output Format to Client](#113-output-format-to-client)
  - [11.4. System Prompt Engineering](#114-system-prompt-engineering)
- [12. Client-Side Data Models & Persistence](#12-client-side-data-models--persistence)
  - [12.1. User Profile (`user_profile.dart`)](#121-user-profile-user_profiledart)
  - [12.2. Quest/Session Data (`quest_model.dart`)](#122-questsession-data-quest_modeldart)
  - [12.3. AI Interaction Log Entry (`interaction_log_entry.dart`)](#123-ai-interaction-log-entry-interaction_log_entrydart)
  - [12.4. App Settings (`app_settings.dart`)](#124-app-settings-app_settingsdart)
  - [12.5. Local Persistence Strategy](#125-local-persistence-strategy)
- [13. UI/UX Design Principles (Flutter Specific)](#13-uiux-design-principles-flutter-specific)
- [14. Non-Functional Requirements (Developer Perspective)](#14-non-functional-requirements-developer-perspective)
  - [14.1. Performance](#141-performance)
  - [14.2. Scalability (Backend Considerations for Client)](#142-scalability-backend-considerations-for-client)
  - [14.3. Security](#143-security)
  - [14.4. Reliability](#144-reliability)
  - [14.5. Maintainability](#145-maintainability)
  - [14.6. Testability](#146-testability)
- [15. Deployment Information](#15-deployment-information)
  - [15.1. Mobile Deployment](#151-mobile-deployment)
  - [15.2. Desktop Deployment](#152-desktop-deployment)
  - [15.3. CI/CD Pipeline Overview](#153-cicd-pipeline-overview)
- [16. Future Considerations (Engineering Perspective)](#16-future-considerations-engineering-perspective)

---

*(The original "Water Coach: Software Engineering Specifications" header, version, date, and old table of contents have been removed. The content below is renumbered and integrated into the new Developer Guide structure.)*

## 1. Project Overview and Technical Introduction

This document serves as the comprehensive technical guide for developers working on the Water Coach application. It outlines software engineering specifications, development guidelines, and operational procedures for the Water Coach application. It details the technical architecture, module breakdowns, feature implementation guidelines, data models, coding standards, testing strategies, and deployment processes necessary for the development team to build, maintain, and evolve a robust, scalable, and high-performing cross-platform application using the Flutter framework.

### 1.1. Purpose of this Document
This document serves as the primary technical reference for developers. Its purpose is to consolidate all essential information regarding the Water Coach application's architecture, development practices, setup, and ongoing operational procedures. It aims to facilitate onboarding for new developers and act as a continuous reference for the entire team.

### 1.2. Project Summary (from Product Specs)
Water Coach is an innovative AI-powered application designed to act as a personal coach, guiding users through work, study, or any on-device "quest" with actionable, real-time advice. By monitoring device activity and user input (primarily voice-driven), Water Coach aims to enhance productivity, maintain focus, and empower users to achieve their goals effectively. Key features include personalized AI coaching, real-time support, flexible interaction modes, universal platform access, and external tool integration.

### 1.3. Target Platforms & Flutter Rationale
*   **Target Platforms:** iOS, Android, Windows, macOS, Linux.
*   **Flutter Rationale:** Flutter has been chosen as the primary development framework due to its ability to deliver high-quality, natively compiled applications for multiple platforms from a single codebase. This significantly accelerates development, reduces maintenance overhead, and ensures a consistent user experience across all targeted devices. Flutter's rich widget library, excellent performance, and strong community support make it ideal for an application like Water Coach that requires a sophisticated UI and potential low-level device interactions.

## 2. Build and Setup Instructions

This section provides detailed instructions for setting up your development environment and running the Water Coach project.

### 2.1. Prerequisites

Before you begin, ensure you have the following installed:

*   **Flutter SDK:** Version X.Y.Z or higher. Refer to the [official Flutter installation guide](https://flutter.dev/docs/get-started/install) for your specific operating system.
*   **Dart SDK:** This is bundled with Flutter.
*   **IDE:**
    *   Android Studio (latest stable version recommended) with the Flutter plugin.
    *   Visual Studio Code (latest stable version recommended) with the Flutter and Dart extensions.
*   **Git:** For version control.
*   **Platform-Specific Tools:** (See subsections below).

### 2.2. Cloning the Project and Installing Dependencies

1.  **Clone the Repository:**
    ```bash
    git clone <repository_url>
    cd water_coach
    ```
    *(Replace `<repository_url>` with the actual URL of the Water Coach repository.)*
2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```
    This command fetches all the packages listed in `pubspec.yaml`.

### 2.3. Platform-Specific Setup

#### 2.3.1. iOS (for macOS users)

*   **Xcode:** Install the latest version from the Mac App Store.
*   **CocoaPods:** Install CocoaPods if not already present (`sudo gem install cocoapods`).
*   **Setup Steps:**
    1.  Detailed steps for iOS setup, including Xcode configuration (signing, bundle identifier), CocoaPods installation (`pod install` in the `ios` directory if needed), and troubleshooting common iOS build issues will be documented here.
    2.  Ensure you have a valid Apple Developer account if you plan to deploy to physical iOS devices.

#### 2.3.2. Android

*   **Android SDK:** Ensure you have the Android SDK installed and configured, typically via Android Studio's SDK Manager.
*   **Android NDK:** Required if the project uses native C/C++ code not managed by Flutter directly. (Details to be added if NDK is specifically needed for a dependency).
*   **Setup Steps:**
    1.  Detailed steps for Android setup, including configuring `local.properties` for SDK path (if needed), setting up an Android Virtual Device (AVD), and troubleshooting common Android build issues (e.g., Gradle issues, SDK version mismatches) will be documented here.

#### 2.3.3. Windows

*   **Visual Studio:** Install Visual Studio (e.g., 2022) with the "Desktop development with C++" workload. This is required for building the Windows application.
*   **Setup Steps:**
    1.  Ensure Flutter for Windows desktop support is enabled (`flutter config --enable-windows-desktop`).
    2.  Detailed steps for Windows-specific configurations and troubleshooting will be documented here.

#### 2.3.4. macOS (Desktop)

*   **Xcode:** Required for macOS desktop builds as well.
*   **Setup Steps:**
    1.  Ensure Flutter for macOS desktop support is enabled (`flutter config --enable-macos-desktop`).
    2.  Detailed steps for macOS-specific configurations, entitlements, and troubleshooting will be documented here.

#### 2.3.5. Linux

*   **Build Tools:** Install necessary build tools. This typically includes `clang`, `cmake`, `gtk3-devel` (or equivalent for your distribution like `libgtk-3-dev`), `pkg-config`, and `liblzma-dev`.
    ```bash
    # Example for Ubuntu/Debian
    sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
    ```
*   **Setup Steps:**
    1.  Ensure Flutter for Linux desktop support is enabled (`flutter config --enable-linux-desktop`).
    2.  Detailed steps for Linux-specific configurations and troubleshooting common build issues will be documented here.

### 2.4. Running the Application

*   **Check Connected Devices:**
    ```bash
    flutter devices
    ```
    This will list available emulators, simulators, or connected physical devices.
*   **Running on Emulator/Simulator:**
    1.  Launch your preferred Android Emulator or iOS Simulator.
    2.  Run the app: `flutter run`
*   **Running on Physical Device:**
    1.  Connect your physical device (ensure developer mode and USB debugging are enabled on Android; ensure trust for your development machine on iOS).
    2.  Select the device using `flutter run -d <device_id>` or follow IDE-specific instructions.
*   **Running on Desktop:**
    ```bash
    # Ensure the correct platform is enabled (e.g., windows, macos, linux)
    flutter run -d <windows/macos/linux>
    ```

### 2.5. Basic Troubleshooting Tips

*   **`flutter doctor -v`:** Run this command to diagnose any issues with your Flutter setup and connected devices.
*   **Clean Build:** If you encounter persistent build issues, try cleaning the project:
    ```bash
    flutter clean
    flutter pub get
    ```
*   **CocoaPods Issues (iOS/macOS):**
    *   `cd ios && pod deintegrate && pod install --repo-update && cd ..`
    *   Ensure your CocoaPods version is compatible.
*   **Gradle Issues (Android):**
    *   Check Android Studio for Gradle sync errors.
    *   Sometimes, invalidating caches and restarting Android Studio can help.
*   **(More specific troubleshooting tips will be added as common issues are identified.)**

## 3. Coding Standards and Conventions

This section outlines the coding standards and conventions to be followed for the Water Coach project to ensure code consistency, readability, and maintainability.

### 3.1. Dart Language

*   **Formatting:** All Dart code **must** be formatted using `dart format`. This is typically enforced by IDE settings (format on save) and CI checks.
*   **Effective Dart:** Adhere to the guidelines outlined in [Effective Dart](https://dart.dev/guides/language/effective-dart) for style, documentation, usage, and design. Pay close attention to:
    *   Naming conventions (covered further below).
    *   Usage of collections, async, error handling.
    *   Writing clear and concise code.
*   **Null Safety:** The project uses Dart's sound null safety. Code should be written to leverage null safety effectively, avoiding unnecessary null checks where types are non-nullable.

### 3.2. Flutter Specifics

*   **Widget Naming:**
    *   Public widgets: `PascalCase.dart` (e.g., `MyCustomButton.dart`).
    *   Private widgets (intended for use only within a single library/file): `_PascalCase.dart` (e.g., `_HelperWidget.dart`).
*   **Project Structure:**
    *   The project primarily follows a **feature-first** directory structure (e.g., `lib/src/features/authentication/`, `lib/src/features/quest_management/`).
    *   Within each feature, common layers like `data/` (models, repositories, data sources), `domain/` (entities, use cases - if applicable), `presentation/` or `ui/` (widgets, screens, controllers/providers) should be organized logically.
    *   Shared widgets, utilities, and core services are located in `lib/src/common/` or `lib/src/core/`.
    *   (This section will be expanded with a more detailed project structure map in Section 7).
*   **Widget Reusability:** [Placeholder: Guidelines on creating reusable widgets, when to extract them into the `common/widgets` directory, and principles for designing them with clear APIs.]
*   **State Management:**
    *   The project uses [Riverpod/BLoC - specify chosen solution] for state management.
    *   Follow established patterns for the chosen solution:
        *   (Placeholder: Detailed guidelines on defining providers/blocs, widget interaction, separation of UI and business logic, and specific project patterns for state management will be documented here. Examples will be provided. See also Section 4.2.2).
*   **Build Method Purity:** Widgets' `build` methods should be pure and free of side effects. Any work involving side effects should be done outside the `build` method (e.g., in event handlers, state management logic).
*   **Constants:** Use `const` for widgets and values where possible to improve performance.

### 3.3. Naming Conventions

*   **Files:** `snake_case_with_extensions.dart` (e.g., `user_profile_screen.dart`, `auth_repository.dart`).
*   **Classes & Enums:** `PascalCase` (e.g., `UserProfile`, `AuthStatus`).
*   **Variables, Methods, Parameters:** `camelCase` (e.g., `userName`, `fetchUserData()`).
*   **Constants:** `camelCase` or `UPPER_SNAKE_CASE` for top-level/static constants (e.g., `defaultTimeout`, `API_KEY`). Prefer `camelCase` for constants within classes.
*   **Boolean Variables:** Should generally be prefixed with `is`, `has`, `can`, etc. (e.g., `isLoading`, `hasConnection`).

### 3.4. Comments and Documentation

*   **Dartdoc:** Use Dartdoc for all public APIs (classes, methods, functions).
    *   Start doc comments with `///`.
    *   Provide a concise summary in the first sentence.
    *   Document parameters, return values, and any thrown exceptions.
*   **Inline Comments:** Use `//` for inline comments to explain complex logic, workarounds, or important decisions. Avoid redundant comments that merely restate the code.
*   **TODOs:** Use `// TODO: Your Name - Short description of what needs to be done` for trackable tasks. Include a reference to an issue tracker if possible.

### 3.5. Error Handling

*   **Approach:** (Placeholder: This section will detail the project's strategy for error handling. For example: Using a combination of try/catch, Result types (e.g., from `multiple_result`), and specific error/exception classes. Guidelines on when to catch exceptions locally versus letting them propagate. How user-facing errors are presented.)
*   **Reporting:** (Placeholder: Details on integrating with an error reporting service like Sentry or Firebase Crashlytics, if applicable.)

### 3.6. Linting

*   **Linter:** The project uses [e.g., `flutter_lints`, `effective_dart`, or a custom `analysis_options.yaml`].
*   **Compliance:** All code submitted must be free of linting warnings and errors. Linters are typically run by the IDE and should be part of the CI pipeline.
*   **Custom Rules:** (Placeholder: Any project-specific custom lint rules will be documented here.)

## 4. System Architecture

This section details the overall architecture of the Water Coach application.

### 4.1. High-Level Architecture Diagram
(Client-AI Backend interaction)

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

### 4.2. Client-Side Architecture (Flutter App)

#### 4.2.1. Modular Design (Feature Modules)
The Flutter application will be structured into distinct feature modules to promote separation of concerns, testability, and maintainability. Example modules:
*   `auth/`: User authentication and profile management.
*   `quest_management/`: Creating, tracking, and managing user quests/sessions.
*   `ai_interaction/`: UI and logic for voice/text communication with the AI.
*   `device_monitoring/`: Platform-specific code for activity tracking.
*   `overlay_ui/`: Logic for the hovering icon.
*   `integrations/`: Connecting with external tools.
*   `settings/`: User preferences.
*   `core/` or `shared/`: Common utilities, widgets, models, and services. (See Section 4.2.4 for more details on shared services).

#### 4.2.2. State Management Strategy
*   **Recommendation:** **Riverpod** or **BLoC/Cubit**.
    *   **Riverpod:** Offers compile-safe dependency injection and state management, flexible and scalable. Good for managing complex app states and dependencies between modules.
    *   **BLoC/Cubit:** Provides a clear separation of business logic from UI, promoting testability. Cubit is a simpler subset of BLoC suitable for many cases.
*   The chosen strategy will be applied consistently across all modules to manage UI state, application data, and interactions with backend services.
*   **Project-Specific Patterns for [Chosen_State_Management, e.g., Riverpod/BLoC]:**
    *   [Placeholder: Detailed guidelines on how the chosen state management solution (e.g., Riverpod providers, BLoC patterns) is specifically implemented in this project. This includes folder structure for state management files within feature modules.]
    *   [Placeholder: Rules or recommendations for when to use different types of providers/blocs (e.g., global vs. feature-specific, simple vs. complex state).]
*   **Examples of Common State Operations:**
    *   Reading State: [Placeholder: Code snippet illustrating how a widget reads state, e.g., using `ref.watch()` for Riverpod or `context.watch<MyBloc>()` for BLoC.]
    *   Updating State: [Placeholder: Code snippet showing how to trigger state updates from UI events or other logic, e.g., calling methods on a Notifier/Cubit or dispatching events to a BLoC.]
    *   Listening to State (for side effects like navigation or dialogs): [Placeholder: Code snippet for using `ref.listen()` or `BlocListener` for reactions to state changes that don't rebuild the widget tree directly.]
*   **Best Practices for Organizing Providers/Blocs:**
    *   [Placeholder: Guidelines on organizing state management logic, such as co-locating providers/blocs with the features they serve, or having a separate `application` layer for business logic.]
    *   [Placeholder: Code snippet illustrating a typical provider/consumer pattern for Riverpod to be added, or a BLoC/Cubit setup within a feature module.]

#### 4.2.3. Navigation
*   **Recommendation:** Flutter's **Navigator 2.0** (Router widget) for more complex navigation scenarios, deep linking, and better state management of navigation stacks.
*   Alternatively, a simpler package like `go_router` can be used if Navigator 2.0 proves overly complex for initial needs.
*   Named routes will be used for clarity and maintainability.

#### 4.2.4. Core/Shared Utilities and Services (Internal API Documentation)
*   The `core/` or `shared/` module contains common utilities, widgets, models, and services used across multiple features.
*   **Key Services Example (`LocalStorageService`):**
    *   **Purpose:** Provides an abstraction layer for reading and writing data to local storage (e.g., `shared_preferences`).
    *   **Key Public Methods:**
        *   `Future<void> saveData(String key, String value);`
        *   `Future<String?> readData(String key);`
    *   **Usage:** [Placeholder: Example of using the `LocalStorageService` to save user preferences to be added.]
    *   **Interaction:** This service is typically injected into repositories or state management controllers that require local data persistence.
*   [Placeholder: Other key shared services like a `NotificationService`, `AnalyticsService`, or `ErrorTrackingService` will be documented here with their purpose, key methods, and usage examples.]

### 4.3. Backend Integration (AI Coaching Service)

#### 4.3.1. API Communication
*   **Primary Recommendation:** **gRPC** for performance-critical, low-latency communication, especially for real-time coaching interactions if streaming voice/data. gRPC uses Protocol Buffers for efficient serialization.
*   **Alternative/Fallback:** **RESTful APIs (HTTPS)** using JSON for less frequent or non-real-time data exchange (e.g., session synchronization, fetching user settings if cloud-stored).
*   **WebSockets:** Could be considered for persistent bidirectional communication if the coaching model benefits significantly from a continuous stream of context and provides continuous feedback.
*   The `http` or `dio` package in Flutter for REST, and `grpc` package for gRPC.
*   Secure communication using TLS/SSL is mandatory.
*   Authentication tokens (e.g., JWT) will be used to secure API requests after user login.

#### 4.3.2. Rationale for Architectural Choices
*   **Modular Design:** Chosen to enhance code organization, parallel development, testability, and long-term maintainability. Each feature can evolve independently. [Further details on how modularity specifically benefits Water Coach's complexity to be added].
*   **State Management (e.g., Riverpod/BLoC):** [Explain *why* the specific solution (once finalized) was chosen over others, e.g., compile-time safety, testability, scalability for the project's needs, developer learning curve].
*   **Navigation (e.g., Navigator 2.0/GoRouter):** [Explain rationale for chosen navigation strategy, e.g., handling complex routing, deep linking needs, state preservation].
*   **API Communication (gRPC/REST):** [Explain reasons for primary choice and when alternatives are used, e.g., performance benefits of gRPC for streaming vs. simplicity of REST for other tasks].

#### 4.3.3. Component Interaction & Data Flow
*   This subsection will provide a more detailed textual and diagrammatic explanation of how major components and modules interact.
*   **Example Data Flow - User Login:**
    1.  User enters credentials on `LoginScreen`.
    2.  `LoginScreen` interacts with `AuthRepository` (via state management layer).
    3.  `AuthRepository` makes API call to backend.
    4.  [Detailed diagram and sequence of this flow to be added].
*   **Example Data Flow - Active Quest Coaching:**
    1.  `DeviceMonitoringService` collects context.
    2.  `AICoachingInteractionModule` captures user voice input.
    3.  Data is sent to `AIBackendService`.
    4.  AI Backend processes and returns suggestions.
    5.  `AICoachingInteractionModule` updates UI via state management.
    6.  [Detailed explanation of data flow between Quest Management, Device Monitoring, AI Interaction modules, and the AI Backend to be added. Sequence diagrams or data flow diagrams will be included here.]

#### 4.3.4. Common Design Patterns
*   **Repository Pattern:** Used for abstracting data sources (network, local database). Example: `QuestRepository` providing data to the `QuestManagement` module.
*   **Service Pattern:** For encapsulating business logic or utility functions not tied to a specific widget. Example: `DeviceMonitoringService`.
*   **Observer Pattern (Implicit in State Management):** Widgets observe state changes from providers/blocs and rebuild accordingly.
*   **Dependency Injection:** Leveraged by the chosen state management solution (e.g., Riverpod providers) to manage dependencies.
*   [Other project-specific patterns and their application contexts to be documented here.]

## 5. Testing Guide

This section outlines the testing strategies, types of tests, and guidelines for writing and running tests in the Water Coach project.

### 5.1. Overview

*   **Importance:** Comprehensive testing is crucial for ensuring code quality, application stability, and preventing regressions.
*   **Types of Tests:**
    *   **Unit Tests:** Verify the correctness of individual functions, methods, and classes (e.g., models, repositories, business logic).
    *   **Widget Tests:** Verify the UI and interaction of individual Flutter widgets.
    *   **Integration Tests:** (To be decided if used) Test complete app flows or interactions between multiple modules/services, potentially including interaction with backend services (mocked).

### 5.2. Running Tests

*   **Run All Tests:**
    ```bash
    flutter test
    ```
*   **Run Specific Unit/Widget Test File:**
    ```bash
    flutter test test/unit/user_repository_test.dart
    flutter test test/widget/login_screen_test.dart
    ```
*   **Run Integration Tests (if applicable):**
    ```bash
    # flutter test integration_test/app_test.dart (Example command)
    ```
    *   [Specific instructions for running integration tests, including any necessary setup (e.g., emulators), will be detailed here if this testing layer is implemented.]

### 5.3. Unit Tests

*   **Location:** Unit tests are located in the `test/` directory, typically mirroring the `lib/` directory structure. For example, tests for `lib/src/features/auth/data/auth_repository.dart` would be in `test/features/auth/data/auth_repository_test.dart`.
*   **Guidelines:**
    *   Focus on testing a single unit of logic.
    *   Use mock objects (e.g., using `mockito` package) to isolate dependencies.
    *   Aim for clear, descriptive test names.
    *   [Placeholder: Project-specific examples of unit tests for models, repositories, and utility classes will be added here.]
    *   [Placeholder: Guidelines on using `mockito` for generating mocks will be provided.]

### 5.4. Widget Tests

*   **Location:** Widget tests are also located in the `test/` directory, often in subdirectories like `test/widget/` or within feature-specific test folders.
*   **Guidelines:**
    *   Test widget rendering, UI interactions (tapping buttons, entering text), and state changes.
    *   Use `flutter_test` utilities like `WidgetTester`, `find`, `expect`.
    *   Pump widgets with necessary dependencies, often mocked.
    *   [Placeholder: Project-specific examples of widget tests for common UI components and screens will be added here.]

### 5.5. Integration Tests

*   **Status:** [To be determined if formal integration tests using `integration_test` package will be a primary focus. If so, this section will be expanded significantly.]
*   **Guidelines:**
    *   If implemented, these tests will cover end-to-end user flows.
    *   May require a running emulator/device.
    *   [Placeholder: Detailed instructions and examples for integration tests if adopted.]

### 5.6. Test Coverage

*   **Goal:** Aim for a high level of test coverage for critical application logic and UI components. [Specific coverage percentage goals might be defined later, e.g., >80% for core logic].
*   **Checking Coverage:**
    ```bash
    flutter test --coverage
    # This generates a coverage/lcov.info file.
    # To view HTML report:
    # 1. Ensure lcov is installed (e.g., sudo apt-get install lcov on Linux, or brew install lcov on macOS).
    # 2. genhtml coverage/lcov.info -o coverage/html
    # 3. open coverage/html/index.html
    ```
*   [Placeholder: Information on any tools or CI integration for tracking test coverage trends.]

## 6. Contribution Workflow

This section details the process for contributing code to the Water Coach project, ensuring consistency and quality. All contributions should ideally be linked to an issue in the project's issue tracker.

### 6.1. Branching Strategy

*   **Main Branches:**
    *   `main`: Represents the latest stable release. Direct commits to `main` are prohibited. Merges to `main` are typically done from `develop` during a release process.
    *   `develop`: The primary development branch. All feature branches are created from `develop` and merged back into `develop`. This branch should ideally always be in a state that could be released.
*   **Feature Branches:**
    *   Created from the latest `develop` branch.
    *   Naming convention: `feature/<issue-id>-short-description` (e.g., `feature/WC-123-login-ui`).
    *   If no issue ID exists, use a descriptive name: `feature/user-profile-enhancement`.
*   **Bugfix Branches:**
    *   Created from `develop` if the bug is found in development. Naming: `fix/<issue-id>-bug-description`.
    *   If fixing a bug in a release, branch from `main` (`hotfix/<issue-id>-bug-description`) and merge to both `main` and `develop`. [This hotfix strategy to be confirmed/detailed].
*   **Chore/Refactor Branches:**
    *   For non-feature, non-bugfix tasks (e.g., refactoring, build script updates). Naming: `chore/descriptive-name`.

### 6.2. Pull Request (PR) Process

1.  **Create Feature/Fix Branch:** As described above.
2.  **Commit Changes:** Make logical, atomic commits. Follow commit message guidelines (see below).
3.  **Push Branch:** Push your feature/fix branch to the remote repository.
4.  **Create Pull Request:**
    *   Open a PR against the `develop` branch.
    *   **Title:** Clear and concise, summarizing the change. Can include the issue ID (e.g., "feat(auth): WC-123 Add Google Sign-In button").
    *   **Description:**
        *   Link to the relevant issue(s) (e.g., "Closes #123", "Fixes #456").
        *   Provide a summary of changes and their purpose.
        *   Include screenshots or GIFs for UI changes.
        *   Mention any specific testing steps or areas for reviewers to focus on.
    *   Assign reviewers if applicable or follow team process.
5.  **Address Feedback:** Respond to comments, make necessary changes, and push updates to your branch. The PR will update automatically.
6.  **Merge:** Once approved and CI checks pass, the PR will be merged by a maintainer (or by the author if permissions allow and process dictates). Prefer "Squash and Merge" or "Rebase and Merge" to keep `develop` history clean. [Specific merge strategy to be defined].

### 6.3. Code Review Expectations

*   **Reviewers:** At least one (preferably two) approvals required before merging.
*   **Focus Areas:**
    *   **Correctness:** Does the code achieve its intended purpose and fix the issue?
    *   **Clarity & Readability:** Is the code easy to understand and maintain?
    *   **Adherence to Standards:** Does it follow coding conventions, naming, formatting?
    *   **Test Coverage:** Are there sufficient tests for new logic/features? Do existing tests pass?
    *   **Performance & Security:** Any obvious performance bottlenecks or security vulnerabilities?
    *   **Documentation:** Are public APIs documented? Are complex parts commented?
*   **Feedback:** Be constructive and respectful. Provide specific suggestions.
*   **Author Response:** Acknowledge and address all review comments.

### 6.4. CI/CD Developer Touchpoints

*   **Continuous Integration (CI):** A CI pipeline (e.g., GitHub Actions, Codemagic) is configured to run automatically on:
    *   All Pull Requests targeting `develop` or `main`.
    *   Merges to `develop` and `main`.
*   **CI Checks:**
    *   Code formatting (`dart format --set-exit-if-changed`).
    *   Linting (`flutter analyze`).
    *   Unit and Widget Tests (`flutter test`).
    *   [Build for different platforms (Android, iOS, etc.) - to be detailed].
*   **Status:** Developers must ensure all CI checks pass on their PR before it can be merged. Monitor PR status for CI results.
*   **Continuous Deployment (CD):** [Details on CD process, e.g., automatic deployment to staging/beta from `develop`, or manual/tagged releases from `main`, will be added here if applicable].

### 6.5. Commit Message Guidelines

*   **Format:** Follow the [Conventional Commits specification](https://www.conventionalcommits.org/).
    *   Example: `feat(auth): add password reset functionality`
    *   Example: `fix(profile): correct user avatar display issue`
    *   Example: `docs(readme): update setup instructions`
    *   Example: `chore(deps): upgrade http package to ^1.0.0`
*   **Structure:**
    ```
    <type>[optional scope]: <description>

    [optional body]

    [optional footer(s)]
    ```
*   **Types:** `feat`, `fix`, `build`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, `test`.
*   **Scope:** Optional, indicates the part of the codebase affected (e.g., `auth`, `quest`, `ui`).
*   **Description:** Concise, present tense, imperative mood (e.g., "add feature" not "added feature" or "adds feature").
*   **Body:** Use for more detailed explanations.
*   **Footer:** For breaking changes (`BREAKING CHANGE: ...`) or linking to issues (`Refs: #123`).
*   [Link to detailed Conventional Commits specification to be added here.]

## 7. Project Structure Overview

This section describes the overall organization of the Water Coach Flutter project.

### 7.1. `lib/` Directory Structure

The `lib/` directory is the heart of the Flutter application and primarily follows a **feature-first** organization strategy.

*   **`lib/main.dart`**: Entry point of the application. Initializes core services and launches the root widget.
*   **`lib/src/`**: Contains all the application's source code.
    *   **`lib/src/app.dart`**: The root widget of the application, setting up MaterialApp/CupertinoApp, themes, and initial routing.
    *   **`lib/src/features/`**: Each major feature of the application resides in its own subdirectory.
        *   `authentication/`
        *   `quest_management/`
        *   `ai_interaction/`
        *   `device_monitoring/`
        *   `settings/`
        *   `overlay_ui/`
        *   `integrations/`
        *   Within each feature (e.g., `authentication/`):
            *   `data/`: Contains data models, repositories, and data source implementations (local/remote).
            *   `domain/`: (Optional, if using Clean Architecture principles) Contains entities and use cases.
            *   `presentation/` or `ui/`: Contains Flutter widgets, screens, and their controllers/providers (state management).
                *   `screens/`: Page-level widgets.
                *   `widgets/`: Reusable widgets specific to this feature.
                *   `controllers/` or `providers/`: State management logic.
    *   **`lib/src/common/`**: Widgets, utilities, constants, and themes shared across multiple features.
        *   `widgets/`: Common reusable UI components (e.g., custom buttons, dialogs).
        *   `utils/`: Helper functions and utility classes.
        *   `constants/`: Application-wide constants (e.g., API keys, route names if not using generated routes).
        *   `theme/`: Application theming definitions.
    *   **`lib/src/core/`**: Core application services, base classes, or infrastructure concerns not tied to a specific feature.
        *   `services/`: Abstract or concrete implementations of core services (e.g., `LocalStorageService`, `ApiService`, `NotificationService`).
        *   `network/`: Networking client setup and interceptors.
        *   `router/`: Navigation setup, route definitions, and guards (if using GoRouter or similar).
    *   **`lib/src/models/`**: (Alternative to feature-based models) If data models are widely shared and not feature-specific, they might reside here.
*   [Placeholder: A more detailed diagram or tree view of the lib/ directory structure will be added to visually represent this organization.]

### 7.2. Other Key Directories

*   **`android/` & `ios/`**: Platform-specific project files for Android and iOS. Flutter code is compiled into these native projects. Native platform channel code resides here.
*   **`windows/`, `macos/`, `linux/`**: Platform-specific project files for desktop builds.
*   **`assets/`**: Static assets like images, fonts, configuration files (JSON).
    *   `assets/images/`
    *   `assets/fonts/`
    *   `assets/config/`
*   **`test/`**: Contains all automated tests (unit, widget, integration). The structure within `test/` often mirrors `lib/`.
*   **`web/`**: (If web support is enabled) Platform-specific files for the web build.
*   **`.vscode/` or `.idea/`**: IDE-specific settings.
*   **`README.md`**: Main project README (user-facing).
*   **`DEVELOPER_GUIDE.md`**: This document.
*   **`CONTRIBUTING.md`**: Guidelines for contributors.
*   **`pubspec.yaml`**: Project metadata, dependencies, and asset declarations.
*   **`analysis_options.yaml`**: Dart static analysis and linter configuration.

## 8. Debugging Guide

This section provides tips and strategies for debugging the Water Coach application.

### 8.1. Using Flutter DevTools

Flutter DevTools is a suite of performance tools for Flutter and Dart. It's invaluable for debugging UI, performance, and memory issues.

*   **Launching DevTools:** Can be launched from your IDE (VS Code, Android Studio) or via the command line (`dart devtools`).
*   **Key Features:**
    *   **Flutter Inspector:** Visualize widget tree, explore widget properties, identify layout issues.
    *   **Performance View:** Profile CPU usage, track frame rates, identify jank.
    *   **Network View:** Monitor HTTP/HTTPS traffic (useful for API debugging).
    *   **Memory View:** Profile memory allocation, detect memory leaks.
    *   **Logging View:** View application logs.
*   [Placeholder: Link to official Flutter DevTools documentation will be added here.]
*   [Placeholder: Project-specific tips for using DevTools to debug common Water Coach scenarios.]

### 8.2. Logging Strategies

*   **In-App Logging:**
    *   Use the standard `dart:developer log()` function for simple debug messages.
    *   Consider a dedicated logging package (e.g., `logger`, `logging`) for more structured logging with levels (debug, info, warning, error) and potential output to files or external services.
    *   [Placeholder: Decision on a specific logging package and project-wide logging conventions to be detailed.]
*   **Viewing Logs:**
    *   IDE console (VS Code, Android Studio).
    *   Flutter DevTools Logging View.
    *   Platform-specific tools (Logcat for Android, Console for iOS/macOS).

### 8.3. Debugging Platform-Specific Code

*   **Android (Kotlin/Java):**
    *   Open the `android/` folder as a separate project in Android Studio.
    *   Use Android Studio's debugger, set breakpoints in Kotlin/Java code.
    *   Logcat is essential for viewing native Android logs.
*   **iOS (Swift/Objective-C):**
    *   Open the `ios/Runner.xcworkspace` file in Xcode.
    *   Use Xcode's debugger, set breakpoints in Swift/Objective-C code.
    *   Xcode Console for logs.
*   **Desktop (C++/Other):**
    *   [Placeholder: Pointers to debugging native C++ code for Windows/Linux/macOS desktop builds using Visual Studio, GDB, LLDB, or Xcode's debugger.]
*   **Platform Channel Debugging:**
    *   Log messages on both the Dart side and the native side when a platform channel method is called and when its result is received.
    *   Verify method names, arguments, and codecs match exactly.

### 8.4. Common Issues and Troubleshooting

*   **Hot Reload vs. Hot Restart:** Understand the difference. Hot reload maintains state, hot restart resets it. Use hot restart if hot reload doesn't reflect changes or causes errors.
*   **Dependency Conflicts:** Check `flutter pub get` output for version conflicts. `flutter pub deps` can help visualize the dependency tree.
*   **Build Errors:** Read error messages carefully. Common issues include incorrect platform setup, missing SDKs, or native build tool problems.
*   **UI Overflows:** Use the Flutter Inspector in DevTools to debug layout issues.
*   [Placeholder: More specific common issues and their solutions related to Water Coach features will be added as they are identified.]

## 9. Dependencies Management

This section outlines how project dependencies (Flutter packages) are managed.

### 9.1. Adding New Dependencies

1.  **Identify Need:** Ensure a package is necessary and well-maintained. Check its popularity, ratings, and issue tracker on [pub.dev](https://pub.dev/).
2.  **Add to `pubspec.yaml`:**
    *   Run `flutter pub add <package_name>` for the latest version.
    *   Or, manually add `<package_name>: ^version_constraint` to `pubspec.yaml` under `dependencies` or `dev_dependencies`.
3.  **Get Packages:** Run `flutter pub get`.
4.  **Import and Use:** Import the package in your Dart files.

### 9.2. Policy on Updating Dependencies

*   **Regular Updates:** Dependencies should be reviewed and updated periodically (e.g., quarterly, or as part of sprint planning) to incorporate bug fixes, performance improvements, and new features.
*   **Check Changelogs:** Before updating a major version of a package, always review its changelog for breaking changes.
*   **Test After Updates:** After updating dependencies, thoroughly test the application, especially areas related to the updated packages.
*   **Avoid Overly Restrictive Constraints:** Use caret syntax (`^x.y.z`) where possible to allow compatible minor and patch updates automatically, unless a specific version is known to cause issues.
*   **Resolving Conflicts:** If version conflicts arise, use `flutter pub deps` to understand the tree and adjust constraints in `pubspec.yaml` or find compatible versions.

### 9.3. Notes on Critical or Complex Dependencies

*   **State Management ([Chosen Solution]):** [Placeholder: Notes on its version, any specific configuration, or common pitfalls.]
*   **Navigation ([Chosen Solution]):** [Placeholder: Notes on its version and configuration.]
*   **Platform Channel Packages (e.g., `speech_to_text`, `flutter_overlay_window`):** [Placeholder: Notes on their native setup requirements, version compatibility with target OS versions, or known issues.]
*   **Backend Communication (e.g., `http`, `dio`, `grpc`):** [Placeholder: Notes on configuration, interceptors, or specific usage patterns within the project.]
*   [Placeholder: A more comprehensive list of key project dependencies, their purpose, and any relevant version constraints or configuration notes will be maintained here or linked to a separate document/wiki page if it becomes too extensive.]

## 10. Module Deep Dive: Features & Implementation
(Formerly "3. Core Modules & Features (Flutter Implementation Details)")

### 10.1. User Authentication Module (`auth/`)
(Formerly "3.1. User Authentication Module")

#### 10.1.1. UI Components (Flutter Widgets)
(Formerly "3.1.1. UI Components")
*   `LoginScreen.dart`: `Scaffold`, `Form` (with `TextFormField` for email/password), `ElevatedButton` for login, `TextButton` for "Forgot Password," social login buttons (e.g., custom `SignInButton` widgets or pre-built package widgets).
*   `RegistrationScreen.dart`: Similar to `LoginScreen` with additional fields for registration (e.g., name, confirm password).
*   `ForgotPasswordScreen.dart`: `TextFormField` for email, `ElevatedButton` to send reset link.
*   Reusable input field widgets (`CustomTextField.dart`) for consistent styling and validation.

#### 10.1.2. Logic & Backend Integration
(Formerly "3.1.2. Logic & Backend Integration")
*   **Recommendation:** **Firebase Authentication** or **Supabase Authentication**.
    *   **Firebase Auth:** Robust, scalable, supports email/password, phone, and various OAuth providers (Google, Apple, Facebook, etc.). Good Flutter integration with `firebase_auth` package.
    *   **Supabase Auth:** Open-source alternative to Firebase, also offers good Flutter support (`supabase_flutter` package) and similar features.
*   If a custom backend is preferred, standard token-based authentication (JWT) will be implemented. The Flutter client will handle token storage securely (e.g., using `flutter_secure_storage`).
*   Form validation using `Form` widget's `validator` properties or packages like `form_field_validator`.
*   API calls for login, registration, password reset, social sign-in using `http` or `dio`.

#### 10.1.3. State Management for Auth Status
(Formerly "3.1.3. State Management for Auth Status")
*   The chosen state management solution (Riverpod/BLoC) will manage the user's authentication state globally (e.g., `AuthState` indicating `authenticated`, `unauthenticated`, `loading`).
*   App navigation will react to changes in `AuthState` (e.g., redirecting to home screen on successful login or to login screen on logout).

### 10.2. Quest Management Module (`quest_management/`) ("Session Management")
(Formerly "3.2. Quest Management Module")

#### 10.2.1. UI Components (Flutter Widgets)
(Formerly "3.2.1. UI Components")
*   `QuestCreationScreen.dart`: `Scaffold`, `TextFormField` (multiline) for quest description, `ElevatedButton` ("Start Quest"), potentially date/time pickers if quests can be scheduled.
*   `ActiveQuestScreen.dart` / `CoachingDashboard.dart`: Displays current quest description, timer, AI suggestions, interaction controls (see 10.3).
*   `QuestHistoryScreen.dart`: `ListView.builder` to display past quests, perhaps with summaries or access to logs. Each item could be a `Card` or `ListTile`.
*   `QuestListItem.dart`: A reusable widget for displaying a single quest in a list.

#### 10.2.2. Data Models (`quest_model.dart`)
(Formerly "3.2.2. Data Models")
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

#### 10.2.3. Local Storage
(Formerly "3.2.3. Local Storage")
*   **Active Quest Data:** For an ongoing quest, its state (description, start time, current AI interaction log) should be persisted locally to survive app restarts.
    *   **`shared_preferences`:** Suitable for simple key-value data of the active quest.
    *   **`sqflite`:** For more structured storage if quest data becomes complex or if a richer history needs to be stored locally.
*   **Offline Drafts:** Allow users to draft a quest description even if offline, saving it locally until they can start it with an internet connection.

### 10.3. AI Coaching Interaction Module (`ai_interaction/`)
(Formerly "3.3. AI Coaching Interaction Module")

#### 10.3.1. UI Components (Flutter Widgets)
(Formerly "3.3.1. UI Components")
*   Within `ActiveQuestScreen.dart` or a dedicated `AICoachChatWidget.dart`:
    *   `ListView.builder` or `ChatList` (from packages like `dash_chat_2`) to display the conversation history with the AI coach.
    *   `MessageBubble.dart` custom widgets for user inputs and AI responses.
    *   `TextField` for text input.
    *   `IconButton` for voice input (microphone icon).
    *   UI elements to display AI-generated suggestions or insights (e.g., in dismissible cards, integrated into the chat, or a separate panel).

#### 10.3.2. Voice Input/Output
(Formerly "3.3.2. Voice Input/Output")
*   **10.3.2.1. Speech-to-Text (STT) Integration:**
    *   Use the `speech_to_text` package.
    *   Handle microphone permissions (`permission_handler` package).
    *   Provide UI feedback during listening (e.g., animated microphone icon, sound waves).
    *   Manage STT state (listening, processing, result).
*   **10.3.2.2. Text-to-Speech (TTS) Integration:**
    *   Use the `flutter_tts` package.
    *   Allow users to select voice/language if supported by the package/OS.
    *   Manage TTS state (speaking, stopped) and queueing of messages.
    *   Provide option in settings to enable/disable TTS for AI responses.

#### 10.3.3. Natural Language Processing (NLP) Client Logic
(Formerly "3.3.3. Natural Language Processing (NLP) Client Logic")
*   This module primarily focuses on capturing user input (text or transcribed voice) and relevant context from the device (see 10.4).
*   This data is then packaged and sent to the AI Backend Service via API calls.
*   The actual NLP for understanding intent and generating coaching prompts happens on the backend.

### 10.4. Device Activity Monitoring Module (`device_monitoring/`) (Platform-Specific Considerations)
(Formerly "3.4. Device Activity Monitoring Module")
This is the most technically complex and privacy-sensitive module. Implementation will heavily rely on platform channels to access native APIs. **Explicit user consent and transparent privacy policies are paramount.**

#### 10.4.1. Screen Content Analysis (Highly Complex & Permission-Intensive)
(Formerly "3.4.1. Screen Content Analysis")
*   **Goal:** To understand what the user is currently working on (e.g., application name, window title, potentially on-screen text via OCR if feasible and permitted).
*   **Flutter Implementation:** Requires platform channels to native code.
    *   **Android:** Utilize `AccessibilityService` API. This requires special user permission and has strict guidelines. The service can read window content and events.
    *   **iOS:** Extremely limited due to privacy restrictions. Reading arbitrary screen content from other apps is generally not possible. Potential workarounds (with significant limitations and UX challenges):
        *   User-initiated screenshots that the app then processes with OCR.
        *   Focus on app usage data if available (see 10.4.2).
    *   **Desktop (Windows, macOS, Linux):**
        *   Platform-specific APIs to get active window title and application name (e.g., using `Process` class in Dart for some info, or native calls via FFI/platform channels for more detail – e.g., Win32 API, Cocoa, X11).
        *   Screen capture APIs for OCR (requires user permission for screen recording/capture). Libraries like `screen_capturer` might be a starting point, coupled with an OCR engine.
*   **OCR:** If screen text is captured, an on-device or cloud OCR service would be needed. On-device (e.g., `google_ml_kit_text_recognition`) is preferred for privacy.

#### 10.4.2. Application Usage Tracking
(Formerly "3.4.2. Application Usage Tracking")
*   **Goal:** Identify currently active application or foreground app.
*   **Flutter Implementation (Platform Channels):**
    *   **Android:** `UsageStatsManager` API (requires `PACKAGE_USAGE_STATS` permission). The `usage_stats` package might provide this.
    *   **iOS:** Very limited. Cannot get a list of running apps or detailed usage of other apps. Focus might be on Water Coach's own active time.
    *   **Desktop:** Native APIs to get foreground window/application process information.

#### 10.4.3. Input Monitoring (Keyboard/Mouse - Extremely Sensitive)
(Formerly "3.4.3. Input Monitoring")
*   **Goal:** Potentially understand user engagement or type of activity (e.g., typing vs. idle).
*   **Implementation:** This is **highly invasive and generally discouraged** due to extreme privacy concerns and OS restrictions. If considered *at all*, it would require:
    *   Very explicit, granular user consent for specific, limited purposes.
    *   Platform-specific native code (e.g., global key listeners on desktop, which are often flagged by security software).
*   **Recommendation:** Avoid direct keylogging. Focus on less invasive metrics like active window or application type.

#### 10.4.4. Data Formatting & Transmission to AI Backend
(Formerly "3.4.4. Data Formatting & Transmission to AI Backend")
*   Collected context (active app, window title, summarized screen content if available and permitted) is structured (e.g., JSON).
*   Sent securely to the AI backend service along with user's direct input to inform coaching advice.
*   Minimize data sent; send only what is necessary for contextual coaching.

#### 10.4.5. User Permissions & Privacy Handling (Crucial)
(Formerly "3.4.5. User Permissions & Privacy Handling")
*   Use `permission_handler` package to request all necessary permissions (microphone, accessibility, usage stats, screen capture if applicable).
*   Clear, upfront explanation to the user about *what* data is being monitored, *why*, and *how* it's used.
*   Easy-to-access settings for users to toggle monitoring features on/off.
*   Adherence to a strict privacy policy.

#### 10.4.6. Developer Notes for Native Code (Device Activity Monitoring)
*   **Locating Native Code:**
    *   Android: [Placeholder: Path to Android native code, e.g., `android/app/src/main/kotlin/.../DeviceActivityService.kt` - to be verified and detailed.]
    *   iOS: [Placeholder: Path to iOS native code, e.g., `ios/Runner/...` - to be verified and detailed, if any specific native components are added beyond standard Flutter.]
    *   Desktop: [Placeholder: Paths to Windows, macOS, Linux native code if custom implementations are used beyond Flutter desktop APIs - to be verified and detailed.]
*   **Building and Debugging Native Parts:**
    *   [Placeholder: Instructions on how to open the native Android/iOS/Desktop project in the respective IDEs (Android Studio, Xcode, Visual Studio) for debugging platform channel or FFI implementations.]
    *   [Placeholder: Tips for debugging platform channel communication, e.g., logging on both Dart and native sides.]
*   **Key Platform Channel Methods:**
    *   [Placeholder: List of key platform channel methods, their arguments, return types, and purpose, e.g., `startMonitoring`, `stopMonitoring`, `getCurrentAppContext`.]

### 10.5. Hovering Icon/Overlay Module (`overlay_ui/`)
(Formerly "3.5. Hovering Icon/Overlay Module")

#### 10.5.1. Implementation
(Formerly "3.5.1. Implementation")
*   **Flutter's `Overlay` and `OverlayEntry` widgets:** Can be used to display a floating widget on top of the app's UI.
*   **For system-wide overlay (drawing over other apps - primarily for Android and Desktop):**
    *   **Android:** Requires `SYSTEM_ALERT_WINDOW` permission. Implement via platform channel to a native Android Service that manages the overlay window (e.g., using `WindowManager`). Packages like `flutter_overlay_window` exist.
    *   **Desktop (Windows, macOS, Linux):** Flutter's desktop embedding allows creating always-on-top, transparent, click-through windows. The main app window could be minimized while a small overlay window remains.
    *   **iOS:** System-wide overlays are not permitted for third-party apps. The hovering icon would be limited to within the Water Coach app itself or potentially via features like Picture-in-Picture if applicable to the interaction model.

#### 10.5.2. Animated Icon States
(Formerly "3.5.2. Animated Icon States")
*   Use Flutter's animation framework (`AnimationController`, `AnimatedWidget`, packages like `rive` or `lottie`) for icon states (e.g., pulsing when idle, spinning when listening, glowing when a new suggestion is available).
*   Icon assets (SVG or high-res PNGs).

#### 10.5.3. Interaction
(Formerly "3.5.3. Interaction")
*   `GestureDetector` on the overlay icon.
*   Single tap: Opens/maximizes the main Water Coach app interface or shows a quick actions menu.
*   Long press (optional): Could trigger voice input directly.

#### 10.5.4. Developer Notes for Native Code (Hovering Icon/Overlay)
*   **Locating Native Code:**
    *   Android: [Placeholder: Path to Android native code for system overlay, e.g., `android/app/src/main/kotlin/.../OverlayService.kt` - to be verified and detailed.]
    *   Desktop: [Placeholder: Notes on how Flutter desktop's window management is used for the overlay, or paths if custom native code is involved - to be verified and detailed.]
    *   iOS: (System-wide overlay not applicable, this note may be adjusted or removed for iOS).
*   **Building and Debugging Native Parts:**
    *   [Placeholder: Similar to Device Activity Monitoring, instructions for opening and debugging native projects if custom native code is substantial.]
*   **Key Platform Channel Methods (if any):**
    *   [Placeholder: List platform channel methods if used for managing the native overlay, e.g., `showOverlay`, `hideOverlay`, `updateOverlayIcon`.]

### 10.6. External Tool Integration Module (`integrations/`)
(Formerly "3.6. External Tool Integration Module")

#### 10.6.1. API Client Logic
(Formerly "3.6.1. API Client Logic")
*   For each targeted external tool (e.g., Google Calendar, Todoist, Jira), implement API client services within Flutter.
*   Use `http` or `dio` for making REST API calls.
*   Define data models for the responses from these APIs.

#### 10.6.2. OAuth 2.0 Handling for Secure Authorization
(Formerly "3.6.2. OAuth 2.0 Handling")
*   Use packages like `flutter_appauth` or `uni_links` (for handling redirect URIs) in conjunction with `url_launcher` to initiate OAuth 2.0 flows.
*   Securely store access tokens and refresh tokens (e.g., using `flutter_secure_storage`).
*   Handle token refresh logic.
*   Provide UI for users to connect/disconnect integrations.

### 10.7. Settings Module (`settings/`)
(Formerly "3.7. Settings Module")

#### 10.7.1. UI Components (Flutter Widgets)
(Formerly "3.7.1. UI Components")
*   `SettingsScreen.dart`: `ListView` with `ListTile`s or custom setting row widgets.
*   `SwitchListTile` for boolean settings (e.g., enable/disable monitoring, TTS).
*   Navigation to sub-screens for managing integrations, account details, privacy policy, etc.

#### 10.7.2. Local Persistence of Settings
(Formerly "3.7.2. Local Persistence of Settings")
*   Use `shared_preferences` to store user settings locally on the device.
*   Load settings on app startup and apply them.

### 10.8. Cross-Platform Synchronization Module (`sync/`)
(Formerly "3.8. Cross-Platform Synchronization Module")
This module ensures session continuity if a user switches devices. Requires backend support.

#### 10.8.1. Backend Service for Syncing
(Formerly "3.8.1. Backend Service for Syncing")
*   The AI Backend Service (or a dedicated sync service) needs endpoints to store and retrieve session state (active quest description, progress, AI interaction highlights).
*   Data should be associated with the authenticated user.

#### 10.8.2. Client Logic
(Formerly "3.8.2. Client Logic")
*   Periodically (or on significant state changes) sync active session data to the backend.
*   On app startup or when resuming a session on a new device, fetch the latest session state from the backend.

#### 10.8.3. Conflict Resolution Strategy (if needed)
(Formerly "3.8.3. Conflict Resolution Strategy")
*   If simultaneous edits could occur (less likely for a single-active-session coach), a simple "last write wins" or timestamp-based strategy might suffice. For Water Coach, typically one device is active at a time for a given session.

## 11. AI Backend Service Interaction (Conceptual)
(Formerly "4. AI Backend Service (Conceptual - for Flutter client interaction)")

The AI Backend Service is the intelligent core that processes information from the Flutter client and generates coaching guidance.

### 11.1. API Endpoints (Illustrative)
(Formerly "4.1. API Endpoints")
*   `/session/start`: Initializes a new coaching quest. Input: `QuestDescription`, `UserSettings`.
*   `/session/updateContext`: Receives ongoing user input (text/voice transcript) and monitored device context. Input: `SessionID`, `UserInput`, `DeviceContext`. Output: `CoachingAdvice`, `Suggestions`.
*   `/session/end`: Finalizes a quest. Input: `SessionID`.
*   *(Potentially endpoints for session history sync if not handled by a separate service).*

### 11.2. Input Requirements from Client
(Formerly "4.2. Input Requirements")
*   **Session Context:** Unique session ID, initial quest description, user-defined goals.
*   **User Input:** Transcribed voice commands/queries, typed text.
*   **Monitored Device Data (Permissioned & Minimized):** Active application/window title, summarized on-screen content (if feasible & permitted), interaction type (e.g., typing, browsing).

### 11.3. Output Format to Client
(Formerly "4.3. Output Format")
*   **Coaching Advice:** Actionable, concise guidance (text, convertible to speech).
*   **Suggestions:** Proactive tips, relevant information snippets, potential next steps.
*   **Structured Data (Optional):** For richer UI display (e.g., links, task breakdowns).

### 11.4. System Prompt Engineering
(Formerly "4.4. System Prompt Engineering")
*   The core AI model(s) on the backend will be guided by a sophisticated system prompt.
*   This prompt will incorporate:
    *   The overall coaching philosophy of Water Coach.
    *   Instructions on how to interpret user input and device context.
    *   Guidelines for generating helpful, encouraging, and focused advice.
    *   Strategies for maintaining user engagement and productivity.
    *   Logic to handle different types of quests (work, study, personal).

## 12. Client-Side Data Models & Persistence
(Formerly "5. Data Models & Persistence (Flutter Client)")

Focus on lean, efficient data structures, primarily managed locally.

### 12.1. User Profile (`user_profile.dart`)
(Formerly "5.1. User Profile")
*   `userId` (if authenticated with backend)
*   `displayName` (optional)
*   `settings` (reference to `AppSettings` model)

### 12.2. Quest/Session Data (`quest_model.dart`)
(Formerly "5.2. Quest/Session Data")
*   `id`: String (UUID)
*   `description`: String
*   `startTime`: DateTime
*   `endTime`: DateTime?
*   `status`: Enum (`QuestStatus { active, paused, completed }`)
*   `log`: List<`InteractionLogEntry`> (brief log of key interactions/advice for local history or sync)

### 12.3. AI Interaction Log Entry (`interaction_log_entry.dart`)
(Formerly "5.3. AI Interaction Log Entry")
*   `timestamp`: DateTime
*   `speaker`: Enum (`Speaker { user, ai }`)
*   `content`: String

### 12.4. App Settings (`app_settings.dart`)
(Formerly "5.4. App Settings")
*   `enableMonitoring`: bool
*   `interactionMode`: Enum (`InteractionMode { voice, text }`)
*   `enableTTS`: bool
*   `connectedIntegrations`: List<String> (identifiers for connected tools)

### 12.5. Local Persistence Strategy
(Formerly "5.5. Local Persistence Strategy")
*   **`shared_preferences`:** For `AppSettings` and simple state of the *current* active `Quest`.
*   **`sqflite` (Optional but Recommended for History):** For storing a list of completed `Quest` objects and their `InteractionLogEntry` items if robust local history is desired. Provides better querying and structure than flat files for larger datasets.

## 13. UI/UX Design Principles (Flutter Specific)
(Formerly "6. User Interface (UI) / User Experience (UX) Design Principles")

*   **Simplicity & Clarity:** Intuitive, uncluttered interface. Minimal cognitive load.
*   **Adaptive UI:** Utilize Material Design (Android) and Cupertino (iOS) widgets or adaptive theming for a native look and feel where appropriate (`ThemeData.adaptive`).
*   **Responsiveness:** Ensure layouts adapt gracefully to various screen sizes (mobile, tablet, desktop) and orientations using Flutter's layout widgets (e.g., `LayoutBuilder`, `MediaQuery`).
*   **Performance:** Prioritize smooth 60fps animations and transitions. Optimize widget builds.
*   **Accessibility:** Implement ARIA-like semantics using `Semantics` widget, ensure good color contrast, support dynamic font sizes, and test with screen readers (TalkBack, VoiceOver).
*   **Feedback & Engagement:** Clear visual/auditory feedback for voice input, AI processing, and suggestions. Subtle animations for the hovering icon to indicate state.

## 14. Non-Functional Requirements (Developer Perspective)
(Formerly "7. Non-Functional Requirements (Technical Implementation Summary)")

### 14.1. Performance
(Formerly "7.1. Performance")
Client app startup < 3s. Perceived AI response < 2s. UI interactions @ 60fps.

### 14.2. Scalability (Backend Considerations for Client)
(Formerly "7.2. Scalability (Backend)")
AI backend must handle concurrent user requests efficiently. The client should handle responses gracefully.

### 14.3. Security
(Formerly "7.3. Security")
HTTPS for all API calls. Secure storage for any sensitive local data (e.g., API tokens for integrations via `flutter_secure_storage`). Strict permission handling for device monitoring.

### 14.4. Reliability
(Formerly "7.4. Reliability")
Graceful error handling in the app (e.g., network issues, API errors). Data persistence to prevent loss of active session. Aim for high backend uptime.

### 14.5. Maintainability
(Formerly "7.5. Maintainability")
Modular Flutter code, clear state management patterns, comprehensive comments, adherence to Dart linting rules (see Section 3).

### 14.6. Testability
(Formerly "7.6. Testability")
High unit and widget test coverage. Integration tests for key user flows (see Section 5).

## 15. Deployment Information
(Formerly "9. Deployment")

### 15.1. Mobile Deployment
(Formerly "9.1. App Store")
Google Play Store (Android), Apple App Store (iOS). Adhere to all store guidelines, especially regarding permissions and background activity.

### 15.2. Desktop Deployment
(Formerly "9.2. Desktop Stores")
*   Windows: Microsoft Store, MSIX packaging.
*   macOS: Mac App Store, .dmg distribution.
*   Linux: Snapcraft, Flatpak, AppImage.

### 15.3. CI/CD Pipeline Overview
(Formerly "9.3. CI/CD Pipeline")
Implement a Continuous Integration/Continuous Deployment pipeline (e.g., Codemagic, GitHub Actions for Flutter) for automated builds, tests, and deployments. (See Section 6.4 for developer touchpoints).

## 16. Future Considerations (Engineering Perspective)
(Formerly "10. Future Considerations / Scalability (from an engineering perspective)")

*   **On-Device AI:** Explore TensorFlow Lite for Flutter (`tflite_flutter` package) or Core ML/NNAPI integrations for simple, privacy-preserving on-device ML tasks (e.g., basic intent recognition before hitting the backend).
*   **Advanced Background Monitoring:** For more sophisticated context awareness, investigate platform-specific background execution capabilities (requires careful battery optimization and adherence to OS limits).
*   **Deeper OS-Level Integrations:** E.g., Share extensions, App Intents, system-wide services where permitted by the OS, to make Water Coach more seamlessly integrated.
*   **Real-time Collaboration Features (if product direction evolves):** Consider WebRTC or Firebase Realtime Database/Firestore for multi-user scenarios (not in current scope).
*   **Modular AI Backend:** Design the AI backend to easily swap or add new core AI models as technology improves.

*(Note: Original Section "8. Development Environment & Tools (Flutter)" from the spec has been largely integrated into Section 2 (Build Setup), Section 3 (Coding Standards), and Section 9 (Dependencies Management). Any remaining specific package versions or tool configurations should be detailed within those relevant sections.)*

[end of DEVELOPER_GUIDE.md]
