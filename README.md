🛒 Advanced E-Commerce App with Flutter
<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Provider-State%20Management-6A0DAD" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey" />
  <img src="https://img.shields.io/badge/Version-1.0.0-green" />
  <img src="https://img.shields.io/badge/License-MIT-blue" />
</p>
A fully-featured, cross-platform e-commerce mobile application built with Flutter. The app delivers a smooth and modern shopping experience with local data persistence, network integration, and multi-platform support (Android, iOS, Web, Desktop).

📱 Screenshots

Add your screenshots here.

HomeProduct DetailCartProfileShow ImageShow ImageShow ImageShow Image

✨ Features

🏠 Home Screen – Product listings with banner carousel and category filters
🔍 Product Search & Categories – Browse and filter products easily
📄 Product Detail Page – Rich product view with image gallery and video support
🛒 Shopping Cart – Add, update, and remove items with real-time totals
💾 Local Persistence – Cart and user preferences saved locally via SQLite & SharedPreferences
🌐 REST API Integration – Fetch live product data using Dio with pretty logging
📐 Responsive UI – Adapts to any screen size using flutter_screenutil
🎬 Video Support – Embedded product videos via video_player
🖼️ Optimized Image Loading – Smooth image caching with cached_network_image
🔧 Environment Config – Secrets managed via .env using flutter_dotenv
🧩 SVG Assets – Scalable icons and graphics with flutter_svg
💉 Dependency Injection – Clean service locator pattern using get_it


🏗️ Architecture
The project follows a clean, modular architecture with a clear separation of concerns:
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

State Management: Provider
Networking: Dio + PrettyDioLogger
Local Storage: SQLite (sqflite) + SharedPreferences
DI: GetIt service locator
Responsiveness: flutter_screenutil


🛠️ Tech Stack
CategoryPackageVersionState Managementprovider^6.1.5HTTP Clientdio^5.9.2API Loggerpretty_dio_logger^1.4.0Local DBsqflite^2.4.2Preferencesshared_preferences^2.5.5Image Cachecached_network_image^3.4.1SVG Supportflutter_svg^2.2.4Video Playervideo_player^2.11.1Screen Adapterflutter_screenutil^5.9.3DI Containerget_it^9.2.1Equalityequatable^2.0.8Env Configflutter_dotenv^6.0.1Dot Indicatorsdots_indicator^4.0.1Visibility Eventsvisibility_detector^0.4.0

🚀 Getting Started
Prerequisites
Make sure you have the following installed:

Flutter SDK >=3.10.7
Dart SDK >=3.0.0
Android Studio / VS Code with Flutter & Dart plugins
An Android emulator, iOS simulator, or physical device

Installation

Clone the repository

bash   git clone https://github.com/abdelrahmansaed1/Advanced-E-commerce-App-with-Flutter.git
   cd Advanced-E-commerce-App-with-Flutter

Install dependencies

bash   flutter pub get

Set up environment variables
Create a .env file in the root directory and add your configuration:

env   BASE_URL=https://your-api-base-url.com
   API_KEY=your_api_key_here

Run the app

bash   flutter run

🌍 Platform Support
PlatformSupportedAndroid✅iOS✅Web✅Windows✅macOS✅Linux✅

📂 Project Structure
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

🔧 Configuration
This project uses flutter_dotenv for environment variable management. The .env file is declared as an asset in pubspec.yaml and loaded at app startup.

⚠️ Important: Never commit your .env file to version control. Add .env to your .gitignore.


🧪 Running Tests
bashflutter test
For widget tests or integration tests:
bashflutter test test/widget_test.dart

📦 Build
Android APK:
bashflutter build apk --release
Android App Bundle (recommended for Play Store):
bashflutter build appbundle --release
iOS:
bashflutter build ios --release
Web:
bashflutter build web --release

🤝 Contributing
Contributions are welcome! Please follow these steps:

Fork the repository
Create your feature branch (git checkout -b feature/AmazingFeature)
Commit your changes (git commit -m 'Add some AmazingFeature')
Push to the branch (git push origin feature/AmazingFeature)
Open a Pull Request


📄 License
This project is licensed under the MIT License. See the LICENSE file for details.

👤 Author
Abdelrahman Saed

GitHub: @abdelrahmansaed1


🙏 Acknowledgments

Flutter Documentation
pub.dev — Dart & Flutter packages
Flutter Community
