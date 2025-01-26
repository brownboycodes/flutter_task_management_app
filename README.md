# Task Management App

Flutter Task Management App

## Getting Started

clone the repository and run the following command to get the required packages

```bash
flutter pub get
```

to run the app use the following command

```bash
flutter run
```
---

## Features

### 1. Task Management

- Users will be able to:

  - Add, edit, delete, and view tasks.

  - Mark tasks as `Completed` or `Pending` by interacting with the toggle switch.

### 2. Data Storage

## Sqflite:

- Used `sqflite` to store task details.

- Persisted task data across app launches.

## Hive:

- Used `Hive` to store user preferences, such as:

  - App theme (light/dark).

  - Default sort order for tasks (by date, priority, etc.).

## 3. State Management

- Used `Riverpod` to manage the app's state:

  - Task management (CRUD operations).

  - User preferences.

## 4. Additional Features
- Search and filter functionality for tasks.
- Responsive UI for mobile and tablet devices.

---

## Screenshots

<div style="display: flex; gap: 10px; justify-content: center; align-items: center;">

  <img src="./screenshots/screenshot1.png" alt="Image 1" style="width: 190px; height: auto;">
  <img src="./screenshots/screenshot4.png" alt="Image 4" style="width: 190px; height: auto;">
  <img src="./screenshots/screenshot5.png" alt="Image 5" style="width: 190px; height: auto;">
  <img src="./screenshots/screenshot6.png" alt="Image 6" style="width: 190px; height: auto;">

</div>
<div style="display: flex; gap: 10px; justify-content: center; align-items: center;">
 <img src="./screenshots/screenshot3.png" alt="Image 3" style="width: 400px; height: auto;">
  <img src="./screenshots/screenshot2.png" alt="Image 2" style="width: 400px; height: auto;">
</div>



