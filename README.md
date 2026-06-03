# 🛒 Advanced E-Commerce App with Flutter

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Provider-State%20Management-6A0DAD" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey" />
  <img src="https://img.shields.io/badge/Version-1.0.0-green" />
  <img src="https://img.shields.io/badge/License-MIT-blue" />
</p>

A fully-featured, cross-platform e-commerce mobile application built with Flutter. The app delivers a smooth and modern shopping experience with local data persistence, network integration, and multi-platform support (Android, iOS, Web, Desktop).


---

## ✨ Features

- 🏠 **Home Screen** – Product listings with banner carousel and category filters
- 📄 **Product Detail Page** – Rich product view with image gallery
- 🛒 **Shopping Cart** – Add, update, and remove items with real-time totals
- 💾 **Local Persistence** – Cart and user preferences saved locally via SQLite & SharedPreferences
- 🌐 **REST API Integration** – Fetch live product data using Dio with pretty logging
- 📐 **Responsive UI** – Adapts to any screen size using `flutter_screenutil`
- 🎬 **Video Support** – Embedded product videos via `video_player`
- 🖼️ **Optimized Image Loading** – Smooth image caching with `cached_network_image`
- 🔧 **Environment Config** – Secrets managed via `.env` using `flutter_dotenv`
- 🧩 **SVG Assets** – Scalable icons and graphics with `flutter_svg`
- 💉 **Dependency Injection** – Clean service locator pattern using `get_it`

---

## 🏗️ Architecture

The project follows a clean, modular architecture with a clear separation of concerns:

```
lib/
├── core/
│   ├── di/                  # Dependency injection setup (get_it)
│   ├── network/             # Dio client & API configuration
│   └── utils/               # Helpers and extensions
├── data/
│   ├── local/               # SQLite database (sqflite) & SharedPreferences
│   ├── remote/              # API service classes (Dio)
│   └── models/              # Data models (Equatable)
├── domain/
│   └── repositories/        # Abstract repository interfaces
├── presentation/
│   ├── screens/             # App screens / pages
│   ├── widgets/             # Reusable UI components
│   └── providers/           # State management (Provider)
└── main.dart                # App entry point
```

> **State Management:** Provider  
> **Networking:** Dio + PrettyDioLogger  
> **Local Storage:** SQLite (sqflite) + SharedPreferences  
> **DI:** GetIt service locator  
> **Responsiveness:** flutter_screenutil  

---

## 🛠️ Tech Stack

| Category | Package | Version |
|---|---|---|
| State Management | `provider` | ^6.1.5 |
| HTTP Client | `dio` | ^5.9.2 |
| API Logger | `pretty_dio_logger` | ^1.4.0 |
| Local DB | `sqflite` | ^2.4.2 |
| Preferences | `shared_preferences` | ^2.5.5 |
| Image Cache | `cached_network_image` | ^3.4.1 |
| SVG Support | `flutter_svg` | ^2.2.4 |
| Video Player | `video_player` | ^2.11.1 |
| Screen Adapter | `flutter_screenutil` | ^5.9.3 |
| DI Container | `get_it` | ^9.2.1 |
| Equality | `equatable` | ^2.0.8 |
| Env Config | `flutter_dotenv` | ^6.0.1 |
| Dot Indicators | `dots_indicator` | ^4.0.1 |
| Visibility Events | `visibility_detector` | ^0.4.0 |

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.10.7`
- Dart SDK `>=3.0.0`
- Android Studio / VS Code with Flutter & Dart plugins
- An Android emulator, iOS simulator, or physical device

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/abdelrahmansaed1/Advanced-E-commerce-App-with-Flutter.git
   cd Advanced-E-commerce-App-with-Flutter
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Set up environment variables**

   Create a `.env` file in the root directory and add your configuration:

   ```env
   BASE_URL=https://your-api-base-url.com
   API_KEY=your_api_key_here
   ```

4. **Run the app**

   ```bash
   flutter run
   ```

---

## 🌍 Platform Support

| Platform | Supported |
|----------|-----------|
| Android  | ✅        |
| iOS      | ✅        |
| Web      | ✅        |
| Windows  | ✅        |
| macOS    | ✅        |
| Linux    | ✅        |

---

## 📂 Project Structure

```
Advanced-E-commerce-App-with-Flutter/
├── android/                 # Android native project
├── ios/                     # iOS native project
├── web/                     # Web platform entry
├── windows/                 # Windows platform entry
├── macos/                   # macOS platform entry
├── linux/                   # Linux platform entry
├── assets/
│   └── images/              # Local image assets
├── lib/                     # Dart source code (main app logic)
├── test/                    # Unit and widget tests
├── .env                     # Environment variables (not committed)
├── pubspec.yaml             # Dependencies and asset declarations
└── README.md
```

---

## 🔧 Configuration

This project uses [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv) for environment variable management. The `.env` file is declared as an asset in `pubspec.yaml` and loaded at app startup.

> ⚠️ **Important:** Never commit your `.env` file to version control. Add `.env` to your `.gitignore`.

---

## 🧪 Running Tests

```bash
flutter test
```

For widget tests or integration tests:

```bash
flutter test test/widget_test.dart
```

---

## 📦 Build

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle (recommended for Play Store):**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```


---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**Abdelrahman Saed**

- GitHub: [@abdelrahmansaed1](https://github.com/abdelrahmansaed1)

---

## 🙏 Acknowledgments

- [Flutter Documentation](https://docs.flutter.dev/)
- [pub.dev](https://pub.dev/) — Dart & Flutter packages
- [Flutter Community](https://flutter.dev/community)
