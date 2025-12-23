# Copilot Instructions for mylob_app

## Project Overview
- **mylob_app** is a cross-platform Flutter application using Firebase (Firestore, Auth, Storage) for backend services.
- The app is structured for modularity: business logic, UI, and data models are separated for maintainability and scalability.

## Key Architecture & Patterns
- **lib/pages/**: Page-level widgets (route entry points, navigation targets).
- **lib/screens/**: Major UI sections, often composed into pages.
- **lib/widgets/**: Reusable UI components (cards, buttons, etc.).
- **lib/models/**: Data models for cities, hotels, deals, etc. Use strong typing and fromMap/toMap for serialization.
- **lib/services/**: Data access, Firestore integration, and business logic. Example: `seed_writer.dart` for seeding Firestore from local data.
- **lib/utils/**: Utility functions (e.g., responsive design, image path helpers).
- **assets/images/**: Images are organized by type (hotels, cities). Use `utils/image_path.dart` for asset path resolution.

## Data & Firestore
- Firestore collections: `cities`, `hotels`, `deals`.
- Seeding: Use `lib/services/seed/seed_writer.dart` and `seed/seed.json` to populate Firestore for development/testing.
- Data models are mapped to Firestore documents using explicit field names and conversion helpers.

## UI Conventions
- Responsive layouts: Use `utils/responsive.dart` and check for `isDesktop`, `isTablet`, etc.
- Prefer `GridView` for responsive grids (see `homeScreen/why_section.dart`).
- Use `safeAssetImage` for robust image loading.

## Build, Run, and Test
- **Build/Run:**
  - Standard Flutter commands: `flutter run`, `flutter build <platform>`.
  - For web: see `.idx/dev.nix` for web preview command.
- **Testing:**
  - Place widget and unit tests in `test/`.
  - Run with `flutter test`.
- **Seeding Firestore:**
  - Run the seeding logic in `lib/services/seed/seed_writer.dart` (see function `seedAll`).

## External Integrations
- Firebase: Configured via `firebase.json`, `firestore.rules`, and `lib/firebase_options.dart`.
- Localization: `lib/l10n/` contains ARB files and generated localization code.

## Project-Specific Practices
- Use explicit imports and avoid relative paths outside `lib/`.
- Keep business logic out of UI widgets; use services for data access.
- Follow the directory structure for new features (models, services, screens, widgets).

## References
- See `README.md` for Flutter basics.
- Review `lib/services/seed/seed_writer.dart` and `lib/utils/image_path.dart` for data and asset patterns.
- Use `lib/l10n/` for localization.

---

For questions or unclear conventions, check for similar patterns in the codebase before introducing new ones. Ask for feedback if unsure about architectural decisions.