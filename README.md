# ☕ Barcode Scanner & Shop Membership Management App

A production-ready Flutter mobile application for digital coffee & shop membership subscriptions, daily QR-based perk redemptions, and real-time customer management. Built with Flutter, Riverpod, GoRouter, and Mobile Scanner.

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Key Roles & Workflows](#-key-roles--work-flows)
  - [1. Customer Role](#1-customer-role)
  - [2. Shop Owner Role](#2-shop-owner-role)
- [Feature Breakdown](#-feature-breakdown)
  - [Authentication & Role Routing](#-authentication--role-routing)
  - [Customer Onboarding & Shop Discovery](#-customer-onboarding--shop-discovery)
  - [Shop Setup & Onboarding](#-shop-setup--onboarding)
  - [QR Code Generation & Redemption Flow](#-qr-code-generation--redemption-flow)
  - [Camera Scanner & Manual Code Entry](#-camera-scanner--manual-code-entry)
  - [Customer Management System](#-customer-management-system)
  - [Analytics, Dashboard & History](#-analytics-dashboard--history)
- [Trial & Demo Credentials](#-trial--demo-credentials)
- [API Endpoints Overview](#-api-endpoints-overview)
- [Project Architecture & Tech Stack](#-project-architecture--tech-stack)
- [Folder Structure](#-folder-structure)
- [Getting Started](#-getting-started)

---

## 🌟 Overview

The app connects local shop owners (such as cafes, coffee shops, and subscription services) with their loyal customers:
- **Customers** join shops, get daily drink/perk passes, and present dynamic 24-hour QR codes for instant redemption.
- **Shop Owners** manage customer membership approvals, scan customer QR codes (or enter manual codes), verify daily allowance status, process redemptions, and track real-time analytics.

---

## 👥 Key Roles & Workflows

### 1. Customer Role
1. **Registration & Verification**: Customers can sign up directly in the app with their full name, email, phone number, and password, then verify their account via 6-digit OTP.
2. **Shop Discovery & Joining**:
   - Browse nearby partner shops via the **Find Shop** directory.
   - Scan a physical or digital shop QR code (**Scan Shop QR**) to send a membership request.
   - Wait for shop owner approval or immediate activation based on shop policy.
3. **Daily Pass & QR Code Generation**:
   - Access **My Daily Code** for any active shop membership.
   - Dynamic QR codes are generated per shop with a 24-hour validity window.
   - Live status indicator tracks whether the daily beverage/perk has already been redeemed (`NOT YET REDEEMED` vs `ALREADY REDEEMED`).
4. **Redemption & History**:
   - Present the QR code at the shop counter for the owner/barista to scan.
   - View complete redemption history with shop information, timestamps, and pass statuses.

---

### 2. Shop Owner Role
1. **Account Creation**: Shop Owner accounts are provisioned/created from the central administrative dashboard.
2. **Shop Setup & Onboarding**:
   - When an owner logs in for the first time without an active shop, they are guided through the multi-step shop setup:
     - **Shop Details**: Shop name, logo upload (JPG/PNG), business address, contact number, and description.
     - **Opening Hours**: Daily operational hours configuration (Monday through Sunday opening/closing times and open/closed toggles).
     - **Subscription Plans**: Select and activate a shop subscription plan (Free Trial, Standard, Pro).
3. **Shop Dashboard**:
   - Real-time KPI cards: **Active Customers**, **Pending Requests**, and **Today's Redemptions**.
   - One-tap quick scan action hero card.
   - Recent redemptions activity feed.
4. **Customer Management**:
   - Review incoming **Customer Membership Requests**.
   - One-tap **Activate Customer** or **Decline Request**.
   - Filter customer database by tab: `Active`, `Pending`, `Paused`, `Rejected`.
   - Search customers in real-time by name, email, or phone number.
   - View individual customer profiles and pause/resume memberships.
5. **Scanner & Redemption Verification**:
   - Built-in camera scanner with torch toggle and camera-flip support.
   - **Manual Code Entry** fallback for manual alphanumeric code entry (`HH-COFFEE-XXXXXX`).
   - Customer verification sheet: Shows customer photo, name, contact info, membership plan, and redemption status.
   - Confirm redemption and mark daily pass as used.

---

## 🚀 Feature Breakdown

### 🔐 Authentication & Role Routing
- **Endpoints**: `/auth/login`, `/auth/register`, `/auth/verify-email`, `/auth/forgot-password`, `/auth/reset-password`
- **Smart Role-Based Redirection**:
  - JWT payload is decoded upon login to inspect the user's `role` (`customer` vs `owner`/`shop_owner`).
  - **Shop Owner**: Checks if shop profile exists via `/shop/my-shop`. If present, redirects to Owner Dashboard; otherwise redirects to Shop Setup.
  - **Customer**: Checks active memberships via `/membership/my-memberships`. If none exist, redirects to Find Shop; otherwise opens Customer Home.

---

### 🏪 Shop Setup & Onboarding
Shop owners configure their business profile prior to accepting customer requests:
- **Shop Profile & Media**: Upload brand logo, enter location, contact phone, and store description.
- **Operating Schedule**: Weekly opening and closing schedule builder.
- **Plan Selection & Payment**: Choose tier and finalize subscription payment.

---

### 🔍 Customer Onboarding & Shop Discovery
- **Find Shop Page**: Search shops by name or location, view shop gallery, address, and amenities.
- **Scan Shop QR**: Use camera to instantly identify and submit a membership request to a specific venue.
- **Activation Status**: Real-time status screens for Pending Approval and Activation Confirmation.

---

### 📲 QR Code Generation & Redemption Flow
- **QR Generation**: Generates shop-specific QR tokens via `/membership/generate-qr-code/:shopId`.
- **Dynamic Shop Switcher**: Customers with multiple club memberships can toggle between shops seamlessly.
- **24-Hour Expiration Engine**: Displays remaining countdown hours/minutes before daily reset.
- **Live Redemption Verification**: Verifies single redemption status via `/redemption/single-redemption/:qrCode`.

---

### 📷 Camera Scanner & Manual Code Entry
- **Camera Scanner**: High-performance barcode/QR scanning powered by `mobile_scanner` with viewfinder overlay, duplicate suppression, flashlight, and front/back camera toggles.
- **Manual Input**: Alphanumeric code entry (`manual_code_entry_page.dart`) with auto-validation for damaged or unreadable screens.
- **Verification Screen**: Displays verified customer name, profile avatar, email, phone, and checks if code is already redeemed.

---

### 👥 Customer Management System
- **Tabbed Management**: Categorized into `Active`, `Pending`, `Paused`, and `Rejected` tabs.
- **Debounced Search**: Search query debounced at 400ms for optimal API usage.
- **Approval Workflow**: Accept customer activation requests with immediate notification feedback.

---

### 📊 Analytics, Dashboard & History
- **Owner Dashboard**: Live metrics for today's volume, active member base, and pending requests.
- **Redemption History**: Paginated, filterable timeline of all historical redemptions for both customers and shop owners.

---

## 🔑 Trial & Demo Credentials

Use the following credentials to test and review the application:

### 🏪 Shop Owner Account (Trial / Review)
| Field | Value |
| :--- | :--- |
| **Role** | Shop Owner (`shop_owner`) |
| **Email** | `penaya2391@findize.com` |
| **Password** | `owner1235` |
| **Access** | Shop Dashboard, QR Scanner, Customer Management, Redemption Logs |

### 👤 Customer Account (Test)
| Field | Value |
| :--- | :--- |
| **Role** | Customer (`customer`) |
| **Email** | `gonidev715@gmail.com` |
| **Password** | `123abc` |
| **Access** | Find Shop, Join Shop, My Daily Code (QR), Redemption History |

*(Alternatively, register a new Customer account via the in-app Sign Up page and verify via OTP).*

---

## 📡 API Endpoints Overview

| Category | Method | Endpoint | Description |
| :--- | :--- | :--- | :--- |
| **Auth** | `POST` | `/auth/login` | Login user & return JWT tokens |
| **Auth** | `POST` | `/auth/register` | Register new customer account |
| **Auth** | `POST` | `/auth/verify-email` | Verify 6-digit email OTP |
| **Shop** | `GET` | `/shop/my-shop` | Fetch logged-in owner's shop details |
| **Shop** | `POST` | `/shop/create-shop` | Create new shop profile with image |
| **Shop** | `GET` | `/shop/all-shops` | Browse and search shop directory |
| **Membership** | `GET` | `/membership/my-memberships` | List customer's active memberships |
| **Membership** | `POST` | `/membership/join-shop/:shopId` | Send join request to a shop |
| **Membership** | `POST` | `/membership/generate-qr-code/:shopId` | Generate customer's daily QR code |
| **Membership** | `GET` | `/membership/shop-members` | Fetch shop members filtered by status |
| **Membership** | `PATCH`| `/membership/update-status/:id` | Update member status (`active`/`rejected`/`paused`) |
| **Redemption** | `POST` | `/redemption/verify-qr-code` | Verify scanned QR code payload |
| **Redemption** | `GET` | `/redemption/single-redemption/:qrCode`| Fetch redemption & customer details |
| **Redemption** | `GET` | `/redemption/shop-redemptions` | Fetch shop redemption history & logs |

---

## 🛠 Project Architecture & Tech Stack

```
lib/src/
├── core/                  # Core modules, themes, routes, networks, & common widgets
│   ├── constants/         # Asset constants, static strings
│   ├── routes/            # GoRouter configuration & route definitions
│   ├── services/          # Dio ApiService, LocalStorageService (SharedPreferences)
│   ├── theme/             # Color palette, Typography, ThemeData
│   ├── utils/             # Image pickers, helpers, validators
│   └── widgets/           # Reusable UI components (Buttons, Inputs, Loaders, Dialogs)
│
└── features/              # Feature-driven modular architecture
    ├── auth/              # Login, Registration, OTP, Password Reset
    ├── customer_setup/    # Find Shop, Shop Details, Scan Shop QR, Activation Status
    ├── shop_setup/        # Shop Details Setup, Opening Hours, Subscription Plans
    ├── home/              # Customer Home & Drink Status Card
    ├── dashboard/         # Owner Dashboard & KPI Stat Cards
    ├── redemption/        # QR Code Display, Expiry Timer, Success/Error Views
    ├── scanner/           # Camera QR Scanner, Manual Entry, Verification Card
    ├── customer_management/# Member list, Pending requests approval, Customer details
    ├── history/           # Redemption history feeds
    ├── notification/      # Activity & status notifications
    ├── profile/           # User/Shop Profile, Settings, Legal pages
    └── splash/            # Splash screen with auto token validation
```

### Key Libraries & Packages
- **Framework**: Flutter (Dart SDK `^3.10.7`)
- **State Management**: [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) `^3.3.2`, [riverpod_annotation](https://pub.dev/packages/riverpod_annotation)
- **Routing**: [go_router](https://pub.dev/packages/go_router) `^17.3.0`
- **Networking**: [dio](https://pub.dev/packages/dio) `^5.10.0`
- **QR & Barcode Scanning**: [mobile_scanner](https://pub.dev/packages/mobile_scanner) `^7.4.2`
- **QR Code Rendering**: [qr_flutter](https://pub.dev/packages/qr_flutter) `^4.1.0`
- **Local Cache & Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences) `^2.5.5`
- **Image Handling**: [cached_network_image](https://pub.dev/packages/cached_network_image) `^3.4.1`, [image_picker](https://pub.dev/packages/image_picker) `^1.1.2`
- **UI Components**: [flutter_svg](https://pub.dev/packages/flutter_svg) `^2.3.0`, [pinput](https://pub.dev/packages/pinput) `^6.0.2`

---

## 💻 Getting Started

### Prerequisites
- Flutter SDK (`>=3.10.7`)
- Dart SDK (`>=3.10.7`)
- Android Studio / Xcode for device simulation and physical device testing
- Camera permissions enabled for QR code scanning

### Installation Steps

1. **Clone the repository**:
   ```bash
   git clone <repository_url>
   cd barcode_scaner
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run code generation (if applicable)**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the application**:
   ```bash
   # Run on connected device or simulator
   flutter run
   ```

---

## 📱 Permissions
- **Camera (`NSCameraUsageDescription` / `android.permission.CAMERA`)**: Required for scanning customer QR codes at the counter and scanning shop QR codes to join.
- **Photo Library / Storage**: Required for uploading shop logos and profile pictures.
