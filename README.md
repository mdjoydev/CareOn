# CareOn - Professional Healthcare at Your Doorstep

CareOn is a high-performance, responsive Flutter application designed to bring quality medical services directly to users' homes. The app provides a seamless booking experience for a wide range of pathological tests, nursing care, and emergency medical assistance.

## 🌟 Key Features

### 🚑 Emergency & SOS Services
- **Ambulance Support**: 24/7 access to ICU, NICU, Air, and Freezer van ambulances.
- **Emergency Nursing**: Fast-response professional nurses for critical care.
- **Doctor Visit at Home**: On-call doctors for emergency consultations and home visits.
- **Pulsing SOS Banner**: High-visibility emergency button on the home screen for instant access.

### 🧪 Medical Test at Home
- **Test Selection**: Search and select from various diagnostic tests (ADA, CBC, ESR, etc.).
- **Lab Comparison**: Compare prices across trusted partners like **AmarLab**, **Popular Diagnostic Center**, **Thyrocare**, **Dr Lal Pathlabs**, and **United Hospital**.
- **Home Sample Collection**: Schedule professional paramedics/nurses to collect samples from your address.

### 👩‍⚕️ Professional Nursing & Care
- **Elderly Care**: Specialized caregivers for the elderly and bedridden.
- **Baby Care**: Professional nanny and neonatal care services.
- **Physiotherapy**: Home-based therapy sessions with certified professionals.
- **Patient Attendant**: Personal attendants for hospital or home support.

### 🌍 Global Features
- **Bilingual Interface**: Seamlessly switch between **English** and **Bangla** across the entire app.
- **100% Responsive Design**: Adaptive UI that scales perfectly on any device size (Small phones to Tablets).
- **Secure Authentication**: Robust Sign-Up/Sign-In flow requiring Name, Phone, Email, and Password.
- **User Profile Management**: Edit personal details, change profile photos, and clear app cache for better performance.

## 📂 Project Structure

- `lib/core`:
  - `state/`: Global state management using **Provider** (`LanguageProvider`) and Singleton (`UserSession`).
  - `theme/`: Centralized `AppTheme`, custom `AppColors`, and dynamic `AppTextStyles` for auto-scaling fonts.
- `lib/screens/`:
  - `medical_test_at_home/`: Complete multi-step booking logic for pathological tests.
  - `emergency_nursing_service/`, `ambulance_support/`, `doctor_visit_at_home/`: Specialized booking flows for emergency services.
  - `home/`: Dynamic home screen with pulsing banners and service grids.
  - `login_screen.dart` & `otp_verification_screen.dart`: Authentication logic.
- `lib/widgets/`: Reusable components like the custom `BottomNavbar`.
- `assets/`: Organized by service type for medical care, special healthcare, and lab partners.

## 🛠️ How to Use

### 1. Installation
Ensure you have the Flutter SDK installed.
```bash
flutter pub get
```

### 2. Running the App
```bash
flutter run
```

### 3. Basic Navigation
- Use the **Bottom Navigation Bar** to switch between Home, Services, Tips, and Profile.
- Click the **SOS Button** (Floating/Banner) for immediate medical assistance.
- Go to **Profile > Change Language** to switch the app to Bangla.
- Use **Profile > Edit Profile** to update your contact information or clear the app cache.

## 🚀 Tech Stack & Libraries
- **Framework**: Flutter (Material 3)
- **State Management**: Provider
- **Fonts**: Google Fonts (Inter & Roboto)
- **Utilities**: `image_picker`, `flutter_local_notifications`, `intl`
- **Architecture**: Domain-driven directory structure with a focus on modularity and scalability.

---
**Developed by MD Joy**
- **Email**: info@careon.me
- **Office**: House 06, Road 02, Block L, Banani, Dhaka 1213, Bangladesh
