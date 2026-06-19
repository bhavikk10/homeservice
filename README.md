# HomeService

A Flutter-based home maintenance and service booking mobile application built as a **real freelance client project**.

The public repository version uses demo screens, placeholder content, and public-safe service data where required, while preserving the core app structure, UI flow, navigation system, and mobile user experience.

---

## Overview

HomeService is a mobile-first home services app designed to let users request household maintenance services such as electrical work, plumbing, carpentry, cleaning, dry cleaning, and pest control.

The app focuses on a clean iOS-style user experience using Flutter's Cupertino design language. It includes phone-based onboarding, service browsing, category-based service selection, problem reporting, request tracking, asset inventory, profile management, and subscription plan screens.

The project was developed as a freelance mobile app prototype/client build for a home maintenance service workflow.

---

## Project Context

This app was built as a freelance project for an early-stage home services startup.

At the time of development, the startup had not finalized its public brand name, so the repository uses the working name **HomeService** to represent the core product concept.

For client privacy and public portfolio safety, this repository may contain:

* Placeholder service data
* Demo request details
* Stock/demo imagery
* Public-safe screen content
* Non-production contact/profile information

The implementation still demonstrates the actual mobile app architecture, screen flow, UI patterns, and service-booking experience built for the project.

---

## Key Features

### Authentication Flow

* Phone number login screen
* OTP navigation flow
* Location access flow
* Clean onboarding experience
* Cupertino-style mobile UI

### Home Dashboard

* Current location display
* Service search bar
* Promotional service banner
* Service category grid
* Home service categories including:

  * Electrician
  * Plumber
  * Carpenter
  * Dry Cleaning
  * Pest Control
  * Cleaning

### Service Discovery

* Service detail screens
* Category-based service browsing
* Subcategory navigation
* Direct item selection for simpler services
* Service-specific item grids
* Expandable FAQ-style sections

### Problem Reporting Flow

* User can select a service/item
* Problem capture/review screen
* Video preview placeholder
* Problem description input
* Character counter
* Submit request flow

### Request Tracking

* Active request screen
* Request summary card
* Timeline-based service status
* Professional assignment card
* Call/chat action buttons
* Animated request status progression

### Asset Inventory

* Add household items/assets
* Camera capture placeholder
* Searchable item category selection
* Category grid for assets such as:

  * Sofa
  * Bed
  * TV
  * Refrigerator
  * AC
  * Washing Machine
  * Dining Table
  * Chair
  * Cabinet
  * Microwave
  * Oven
  * Other

### Profile and Subscription Flow

* Profile dashboard screens
* User details flow
* Subscription plan comparison
* Silver, Gold, and Diamond maintenance tiers
* Plan benefit comparison table
* Upgrade/active plan UI states

### Mobile Navigation

* Custom bottom navigation
* Service tab
* Account tab
* Large center add-item action button
* Animated glowing add button
* IndexedStack-based tab handling

---

## Tech Stack

### Mobile

* Flutter
* Dart
* Cupertino UI

### State Management and Navigation

* Flutter Riverpod
* Riverpod
* Custom Navigator-based routing
* go_router dependency included

### UI / Media

* Google Fonts
* Flutter SVG
* Dotted Border
* Image Picker
* Video Player

### Tooling

* Flutter SDK
* Dart SDK
* flutter_lints

---

## Project Structure

```txt id="7853dy"
homeservice/
├── lib/
│   ├── core/
│   │   ├── navigation/
│   │   │   ├── app_navigator.dart
│   │   │   └── main_tab_scaffold.dart
│   │   ├── providers/
│   │   └── theme/
│   │
│   ├── features/
│   │   ├── auth/
│   │   │   └── presentation/screens/
│   │   ├── home/
│   │   │   └── presentation/screens/
│   │   ├── service/
│   │   │   └── presentation/screens/
│   │   ├── asset_inventory/
│   │   │   └── presentation/screens/
│   │   └── profile/
│   │       └── presentation/screens/
│   │
│   ├── shared/
│   │   └── widgets/
│   │
│   └── main.dart
│
├── assets/
├── assets/categories/
├── pubspec.yaml
└── README.md
```

---

## Main App Flows

### 1. Onboarding Flow

```txt id="s20mo2"
Login Screen
    ↓
OTP Screen
    ↓
Location Access
    ↓
Main App
```

### 2. Service Booking Flow

```txt id="scujld"
Home Dashboard
    ↓
Select Service
    ↓
Service Detail / Subcategory
    ↓
Select Service Item
    ↓
Capture / Review Problem
    ↓
Submit Request
    ↓
Tracking Timeline
```

### 3. Asset Inventory Flow

```txt id="b6h23x"
Main Bottom Navigation
    ↓
Center Add Button
    ↓
Add Item Screen
    ↓
Capture / Search Category
    ↓
Enter Item Details
```

### 4. Subscription Flow

```txt id="m4gg72"
Profile
    ↓
Subscription Plans
    ↓
Plan Comparison
    ↓
Plan Detail / Benefits
```

---

## Screens

| Screen / Module     | Description                                                 |
| ------------------- | ----------------------------------------------------------- |
| Login               | Phone number based login entry point                        |
| OTP                 | Verification flow after mobile number entry                 |
| Location Access     | Permission/location onboarding flow                         |
| Home                | Main dashboard with services, search, location, and banner  |
| Service Detail      | Shows service options, categories, FAQs, and item selection |
| Service Subcategory | Displays nested service items for category-based services   |
| Capture Problem     | Allows users to review media and describe the issue         |
| Tracking Timeline   | Tracks request status and assigned professional             |
| Active Requests     | Shows ongoing user service requests                         |
| Add Item            | Lets users add household assets/items                       |
| Profile Dashboard   | Account and profile section                                 |
| Subscription Plans  | Maintenance tier comparison                                 |
| Plan Detail         | Detailed subscription plan screen                           |
| Plan Benefits       | Plan benefits explanation screen                            |

---

## Getting Started

### Prerequisites

Make sure you have the following installed:

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* Android emulator or physical device

---

### Installation

Clone the repository:

```bash id="6wm0vo"
git clone https://github.com/bhavikk10/homeservice.git
cd homeservice
```

Install dependencies:

```bash id="9wspx6"
flutter pub get
```

Run the app:

```bash id="y6mhl2"
flutter run
```

---

## Flutter Commands

| Command             | Description                                 |
| ------------------- | ------------------------------------------- |
| `flutter pub get`   | Installs dependencies                       |
| `flutter run`       | Runs the app on a connected device/emulator |
| `flutter analyze`   | Runs static analysis                        |
| `flutter test`      | Runs Flutter tests                          |
| `flutter build apk` | Builds an Android APK                       |
| `flutter build ios` | Builds an iOS release build on macOS        |

---

## Assets

The app uses local assets from:

```txt id="ntqh9x"
assets/
assets/categories/
```

These are registered in `pubspec.yaml`.

Some demo screens may also use public placeholder network images for service categories in the portfolio-safe version.

---

## Design Direction

The app follows a clean, premium, iOS-inspired design system.

Key UI choices include:

* Cupertino-style screens and navigation
* White and light-gray background system
* Blue primary action color
* Rounded cards
* Soft shadows
* Clean service grids
* Large touch-friendly buttons
* Bottom navigation with a prominent center action
* Minimal and practical mobile-first layout

The goal was to make booking home maintenance services feel simple, trustworthy, and fast.

---

## What I Worked On

* Flutter app structure
* Feature-based folder organization
* Cupertino mobile UI implementation
* Login and onboarding screens
* Service discovery flow
* Service category and subcategory screens
* Problem reporting flow
* Request tracking timeline
* Asset inventory add-item flow
* Profile and subscription plan screens
* Shared UI components
* Custom bottom navigation
* Mobile-first interaction design

---

## Future Improvements

* Connect authentication to a real backend
* Add actual OTP verification
* Add user location services
* Add service provider assignment backend
* Add booking database
* Add real media upload support
* Add push notifications
* Add payment/subscription integration
* Add chat with assigned professional
* Add order/request history
* Add admin/provider-side app
* Add persistent asset inventory
* Add form validation and error states
* Add automated tests
* Add app icon and splash screen
* Add production build/release documentation

---

## Screenshots

Add screenshots here after capturing emulator/device screens:

```md id="v2w9g3"
![Login Screen](./screenshots/login.png)
![Home Screen](./screenshots/home.png)
![Service Detail](./screenshots/service-detail.png)
![Problem Capture](./screenshots/problem-capture.png)
![Tracking Timeline](./screenshots/tracking.png)
![Add Item](./screenshots/add-item.png)
```

---

## Deployment / Build

This is a mobile application, so there is no Vercel/web demo link for the current version.

For Android APK build:

```bash id="nbkz5y"
flutter build apk --release
```

For Android App Bundle:

```bash id="pallxq"
flutter build appbundle --release
```

For iOS:

```bash id="fb40s5"
flutter build ios --release
```

iOS builds require macOS and Xcode.

---

## Author

**Bhavik Malik**

* GitHub: [@bhavikk10](https://github.com/bhavikk10)
* Email: [bhavikmalik100706@gmail.com](mailto:bhavikmalik100706@gmail.com)

---

## Note

This repository is a public portfolio-safe version of a real freelance mobile app project. Demo data, stock images, placeholder request details, and non-production flows may differ from the private/client version.
