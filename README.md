# SweetBite

Welcome to SweetBite, a comprehensive application designed to enhance your cake shopping experience. This repository contains both the frontend and backend components of the SweetBite application.

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Structure](#structure)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

SweetBite is a full-stack application that allows users to browse, select, and order a variety of cakes. The application is divided into two main parts:

- **Frontend**: The user interface that customers interact with.
- **Backend**: The server-side application that handles data processing and storage.

## Features

- **User Authentication**: Secure login and registration for customers.
- **Product Catalog**: Browse a variety of cakes with detailed descriptions and images.
- **Shopping Cart**: Add cakes to the cart and proceed to checkout.
- **Order Management**: Track order history and current orders.
- **Admin Panel**: Manage products, orders, and user accounts.

## Technologies Used

- **Frontend**:
  - Dart
  - Swift
  - JavaScript

- **Backend**:
  - Node.js
  - Express.js

## Installation

To set up the SweetBite application locally, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/DilipKhunti/Cakeshop-API.git
   cd Cakeshop-API
   ```

2. **Frontend Setup**:
   - Navigate to the `SweetBite-App` directory:
     ```bash
     cd SweetBite-App
     ```
   - Follow the instructions in the `README.md` file within the `SweetBite-App` directory to set up the frontend.

3. **Backend Setup**:
   - Navigate to the `server` directory:
     ```bash
     cd ../server
     ```
   - Install the required dependencies:
     ```bash
     npm install
     ```
   - Configure environment variables:
     - Create a `.env` file in the `server` directory.
     - Add the necessary environment variables (e.g., database connection string, JWT secret).
   - Start the backend server:
     ```bash
     npm start
     ```
## Usage

After completing the installation steps:

1. **Start the Backend Server**:
   - Ensure you are in the `server` directory and have configured the environment variables.
   - Start the server:
     ```bash
     npm start
     ```

2. **Start the Frontend Application**:
   - Navigate to the `SweetBite-App` directory and launch the application as per the provided instructions.

3. **Access the Application**:
   - Open your web browser and navigate to the specified local address to interact with the SweetBite application.

## Structure
```
Directory structure:
└── dilipkhunti-cakeshop-api/
    ├── README.md
    ├── SweetBite-App/
    │   ├── README.md
    │   ├── LICENSE
    │   ├── analysis_options.yaml
    │   ├── pubspec.lock
    │   ├── pubspec.yaml
    │   ├── .gitignore
    │   ├── .metadata
    │   ├── android/
    │   │   ├── gradle.properties
    │   │   ├── .gitignore
    │   │   ├── app/
    │   │   │   └── src/
    │   │   │       ├── debug/
    │   │   │       │   └── AndroidManifest.xml
    │   │   │       ├── main/
    │   │   │       │   ├── AndroidManifest.xml
    │   │   │       │   ├── kotlin/
    │   │   │       │   │   └── com/
    │   │   │       │   │       └── example/
    │   │   │       │   │           └── untitled/
    │   │   │       │   │               └── MainActivity.kt
    │   │   │       │   └── res/
    │   │   │       │       ├── drawable/
    │   │   │       │       │   └── launch_background.xml
    │   │   │       │       ├── drawable-v21/
    │   │   │       │       │   └── launch_background.xml
    │   │   │       │       ├── mipmap-hdpi/
    │   │   │       │       ├── mipmap-mdpi/
    │   │   │       │       ├── mipmap-xhdpi/
    │   │   │       │       ├── mipmap-xxhdpi/
    │   │   │       │       ├── mipmap-xxxhdpi/
    │   │   │       │       ├── values/
    │   │   │       │       │   └── styles.xml
    │   │   │       │       └── values-night/
    │   │   │       │           └── styles.xml
    │   │   │       └── profile/
    │   │   │           └── AndroidManifest.xml
    │   │   └── gradle/
    │   │       └── wrapper/
    │   │           └── gradle-wrapper.properties
    │   ├── assets/
    │   │   └── images/
    │   │       ├── ice-cream1.avif
    │   │       ├── ice-cream2
    │   │       ├── ice-cream3.avif
    │   │       └── ice-cream5.avif
    │   ├── ios/
    │   │   ├── .gitignore
    │   │   ├── Flutter/
    │   │   │   ├── AppFrameworkInfo.plist
    │   │   │   ├── Debug.xcconfig
    │   │   │   └── Release.xcconfig
    │   │   ├── Runner/
    │   │   │   ├── AppDelegate.swift
    │   │   │   ├── Info.plist
    │   │   │   ├── Runner-Bridging-Header.h
    │   │   │   ├── Assets.xcassets/
    │   │   │   │   ├── AppIcon.appiconset/
    │   │   │   │   │   └── Contents.json
    │   │   │   │   └── LaunchImage.imageset/
    │   │   │   │       ├── README.md
    │   │   │   │       └── Contents.json
    │   │   │   └── Base.lproj/
    │   │   │       ├── LaunchScreen.storyboard
    │   │   │       └── Main.storyboard
    │   │   ├── Runner.xcodeproj/
    │   │   │   ├── project.pbxproj
    │   │   │   ├── project.xcworkspace/
    │   │   │   │   ├── contents.xcworkspacedata
    │   │   │   │   └── xcshareddata/
    │   │   │   │       ├── IDEWorkspaceChecks.plist
    │   │   │   │       └── WorkspaceSettings.xcsettings
    │   │   │   └── xcshareddata/
    │   │   │       └── xcschemes/
    │   │   │           └── Runner.xcscheme
    │   │   ├── Runner.xcworkspace/
    │   │   │   ├── contents.xcworkspacedata
    │   │   │   └── xcshareddata/
    │   │   │       ├── IDEWorkspaceChecks.plist
    │   │   │       └── WorkspaceSettings.xcsettings
    │   │   └── RunnerTests/
    │   │       └── RunnerTests.swift
    │   ├── lib/
    │   │   ├── main.dart
    │   │   ├── screens/
    │   │   │   ├── AddDessert.dart
    │   │   │   ├── Category-Selection.dart
    │   │   │   ├── IceCreamDetailPage.dart
    │   │   │   ├── home_page.dart
    │   │   │   ├── ice_cream_list.dart
    │   │   │   ├── profile.dart
    │   │   │   ├── sign_in_page.dart
    │   │   │   ├── sign_up_page.dart
    │   │   │   └── uplode_by_user.dart
    │   │   └── services/
    │   │       └── auth_service.dart
    │   ├── linux/
    │   │   ├── CMakeLists.txt
    │   │   ├── .gitignore
    │   │   ├── flutter/
    │   │   │   ├── CMakeLists.txt
    │   │   │   ├── generated_plugin_registrant.cc
    │   │   │   ├── generated_plugin_registrant.h
    │   │   │   └── generated_plugins.cmake
    │   │   └── runner/
    │   │       ├── CMakeLists.txt
    │   │       ├── main.cc
    │   │       ├── my_application.cc
    │   │       └── my_application.h
    │   ├── macos/
    │   │   ├── .gitignore
    │   │   ├── Flutter/
    │   │   │   ├── Flutter-Debug.xcconfig
    │   │   │   ├── Flutter-Release.xcconfig
    │   │   │   └── GeneratedPluginRegistrant.swift
    │   │   ├── Runner/
    │   │   │   ├── AppDelegate.swift
    │   │   │   ├── DebugProfile.entitlements
    │   │   │   ├── Info.plist
    │   │   │   ├── MainFlutterWindow.swift
    │   │   │   ├── Release.entitlements
    │   │   │   ├── Assets.xcassets/
    │   │   │   │   └── AppIcon.appiconset/
    │   │   │   │       └── Contents.json
    │   │   │   ├── Base.lproj/
    │   │   │   │   └── MainMenu.xib
    │   │   │   └── Configs/
    │   │   │       ├── AppInfo.xcconfig
    │   │   │       ├── Debug.xcconfig
    │   │   │       ├── Release.xcconfig
    │   │   │       └── Warnings.xcconfig
    │   │   ├── Runner.xcodeproj/
    │   │   │   ├── project.pbxproj
    │   │   │   ├── project.xcworkspace/
    │   │   │   │   └── xcshareddata/
    │   │   │   │       └── IDEWorkspaceChecks.plist
    │   │   │   └── xcshareddata/
    │   │   │       └── xcschemes/
    │   │   │           └── Runner.xcscheme
    │   │   ├── Runner.xcworkspace/
    │   │   │   ├── contents.xcworkspacedata
    │   │   │   └── xcshareddata/
    │   │   │       └── IDEWorkspaceChecks.plist
    │   │   └── RunnerTests/
    │   │       └── RunnerTests.swift
    │   ├── test/
    │   │   └── widget_test.dart
    │   ├── web/
    │   │   ├── index.html
    │   │   ├── manifest.json
    │   │   └── icons/
    │   └── windows/
    │       ├── CMakeLists.txt
    │       ├── .gitignore
    │       ├── flutter/
    │       │   ├── CMakeLists.txt
    │       │   ├── generated_plugin_registrant.cc
    │       │   ├── generated_plugin_registrant.h
    │       │   └── generated_plugins.cmake
    │       └── runner/
    │           ├── CMakeLists.txt
    │           ├── Runner.rc
    │           ├── flutter_window.cpp
    │           ├── flutter_window.h
    │           ├── main.cpp
    │           ├── resource.h
    │           ├── runner.exe.manifest
    │           ├── utils.cpp
    │           ├── utils.h
    │           ├── win32_window.cpp
    │           ├── win32_window.h
    │           └── resources/
    └── server/
        ├── app.js
        ├── package-lock.json
        ├── package.json
        ├── vercel.json
        ├── .env.example
        ├── conn/
        │   └── conn.js
        ├── models/
        │   ├── category.js
        │   ├── dessert.js
        │   ├── order.js
        │   └── user.js
        ├── routes/
        │   ├── cart.js
        │   ├── category.js
        │   ├── dessert.js
        │   ├── favourites.js
        │   ├── order.js
        │   ├── user.js
        │   └── userAuth.js
        └── tests/
            └── postman/
                └── Cakeshop.postman_collection.json

```

## Contributing

We welcome contributions to enhance the SweetBite project. To contribute:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Commit your changes with clear and descriptive messages.
4. Push your changes to your forked repository.
5. Open a pull request to the main branch of this repository.

Please ensure that your contributions align with the project's coding standards and conventions.

## License

This project is licensed under the [Apache-2.0 License](LICENSE).

---
