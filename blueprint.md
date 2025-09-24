
# Project Blueprint

## Overview

This document outlines the style, design, and features of the Flutter application. It serves as a single source of truth for the project's current state and future development plans.

## Current State

### Style and Design

*   **Theme:** The application currently uses the default Flutter theme.
*   **Fonts:** Default fonts are in use.
*   **Colors:** Default color scheme.

### Features

*   **Initial Screen:** The application starts with the default Flutter home page.

## Development Plan

### Current Task: Implement Animated Splash Screen and Login Page

**Objective:** Create an animated splash screen that displays the app logo for a few seconds before transitioning to a new login page.

**Steps:**

1.  **Asset Management:**
    *   Create an `assets/images` directory for image assets.
    *   Prompt the user to upload their logo (`logo.png`) to this directory.
    *   Update `pubspec.yaml` to include the new asset directory.

2.  **Create Splash Screen (`lib/splash_screen.dart`):**
    *   Implement a `StatefulWidget` to handle animation and navigation.
    *   The logo will have a fade-in and fade-out animation.
    *   After a 3-second delay, the app will navigate to the login screen.

3.  **Create Login Screen (`lib/login_screen.dart`):**
    *   Implement a `StatelessWidget` as a placeholder for the login page.
    *   It will display a simple "Login Page" message for now.

4.  **Update `lib/main.dart`:**
    *   Set the `SplashScreen` as the initial route (`home`) of the `MaterialApp`.
