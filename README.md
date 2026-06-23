# fro3 — Rule of Three Calculator

A modern, fast, and cross-platform **Rule of Three** calculator built using Flutter. This application features a high-fidelity interface adhering to **Material 3** design principles, offering seamless responsive behavior, dynamic theming, and multi-language support.

## 🚀 Features

* **Direct & Inverse Proportions:** Switch between direct and inverse calculations effortlessly via a simple toggle switch.
* **Material 3 & Dynamic Color:** Adapts beautifully to system preferences with native support for Light/Dark modes and dynamic system-generated color palettes powered by `dynamic_color`.
* **Internationalization (i18n):** Full support for English and Portuguese localization. It automatically adapts to regional formatting, handling locale-specific decimal separators (`.` for English,  `,` for Portuguese).
* **Smart Input & Formatting:** Utilizes tailored text input formatters to enforce clean numeric values (including negative values) and automatically strips redundant trailing zeros from results.
* **Desktop Window Optimization:** Configured via `window_manager` to maintain an ideal aspect ratio on desktop environments, enforcing a safe minimum window size of `360x720` for a sleek mobile-like utility appearance.
* **Quick Share & Copy:** Copy the result instantly to your clipboard by tapping on it, or leverage native sharing sheets to send results to other apps.

## 📱 Screenshots

| Light Theme | Dark Theme |
|-------------|------------|
|<img src="https://gitlab.com/-/project/83504316/uploads/d5e8a0c4289a8e1ca446b7133987ee72/flutter_01.png" width=250>|<img src="https://gitlab.com/-/project/83504316/uploads/87cfce1c1b7b103125bc4d9c0f30c605/flutter_02.png" width=250>|
|<img src="https://gitlab.com/-/project/83504316/uploads/5d39e6a8ecf7ccb06a67168d1c9701d7/flutter_03.png" width=250>|<img src="https://gitlab.com/-/project/83504316/uploads/4ee88e8a4c8204e00238397067ba80d0/flutter_04.png" width=250>|
|<img src="https://gitlab.com/-/project/83504316/uploads/78435806cfc65605b98ae580de9e12f9/flutter_05.png" width=250>|<img src="https://gitlab.com/-/project/83504316/uploads/51526a003a0ec867b5900dd0805fdedb/flutter_06.png" width=250>|

---

## 🛠️ Tech Stack & Packages

The project leverages modern Flutter packages to ensure an adaptive and polished experience:

* **UI System:** Flutter Material Design 3
* **Dynamic Theming:** [`dynamic_color`](https://pub.dev/packages/dynamic_color) for Material You color matching.
* **Window Management:** [`window_manager`](https://pub.dev/packages/window_manager) for tailored desktop window configurations.
* **Sharing Capabilities:** [`share_plus`](https://pub.dev/packages/share_plus) for native sharing sheets.
* **Input Formatting:** [`number_text_input_formatter`](https://pub.dev/packages/number_text_input_formatter) for validating numeric inputs.
* **Localization:** `flutter_localizations` and `intl` for clean multi-language asset structures.

---

## 📦 Getting Started

### Prerequisites

Make sure you have the Flutter SDK installed on your machine.

```bash
   flutter --version
   flutter doctor
   ```

### Installation

1. **Clone the repository:** 
   

```bash
   git clone https://gitlab.com/bbatistadaniel/fro3.git
   cd fro3
   ```

2. **Fetch the dependencies:** 
   

```bash
   flutter pub get
   ```

3. **Debug the Application:** 
   

```bash
   flutter run -d (android device id)
   ```

   or
   

```bash
   flutter run -d windows
   ```

4. **Build the Application:** 
   

```bash
   flutter build apk
   ```

   or
   

```bash
   flutter build windows
   ```

5. **Run the Application:** 

   

```bash
   adb install build/app/outputs/flutter-apk/app-release.apk
   ```

   or
   

```bash
   build/windows/x64/runner/Release/fro3.exe
   ```

---

## 🎨 Configuration

### Launcher Icons

Launcher icons for Android and Windows are configured via `flutter_launcher_icons` . If you update the base assets ( `assets/icon.png` or `assets/iconBackground.png` ), regenerate the native icons using:

```bash
   dart run flutter_launcher_icons
   ```

### Supported Languages

The app automatically shifts content according to user device preference using `.arb` definition maps:
* **English (`en`)** : Uses standard point decimal systems (`.`).
* **Portuguese (`pt`)** : Uses comma decimal systems (`,`) and tailored translations matching localized formatting rules.

---

## 🗺️ Project Structure Highlights

* **`main.dart`** : Houses the main execution block, window constraints initialization, dynamic theme building, and the core responsive layout.
* **`ValueRow`** : A custom, reusable form component featuring isolated validation layout, dynamic colors, and text format styling.
* **`MainState`** : Controls calculation routines handling state logic for mathematical inversion:
  + **Direct Form** : (B * C) / A
  + **Inverse Form** : (A * C) / B

## 📃 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
