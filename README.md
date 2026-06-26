# Performance Demo

A Flutter application showcasing performance optimization concepts, specifically demonstrating:
* **UI Thread Blocking vs. Background Isolates**: How intensive calculations can freeze the user interface when run on the main thread, and how Dart Isolates solve this by running tasks in the background.
* **Widget Rebuild Optimizations**: Comparing unoptimized rebuilds where entire widget trees update, against optimized rebuilds restricted to local leaf nodes.

---

## Demos & Features

### 1. UI Thread Blocking & Background Isolates
* **Freeze UI (Main Thread)**: Runs a heavy CPU-bound task (calculating the sum of square roots for 800,000,000 numbers) directly on the main thread. This demonstrates standard UI freezing, causing the live counter to stop updating and animations to hang.
* **Run in Isolate**: Runs the same computational task in a separate background thread (Dart Isolate). The main thread remains fully responsive, keeping animations, tickers, and scroll views running smoothly.

### 2. Rebuild Optimizations
* **Unoptimized Rebuilds**: Demos showing how global state updates trigger expensive redraws of unaffected widgets.
* **Optimized Rebuilds**: Demonstrates the use of targeted rebuilding techniques (such as using specialized stateful widgets or builder blocks) to scope updates only to the widgets that actually change.

---

## Getting Started

### Prerequisites
* Flutter SDK (3.7.2 or higher)
* Dart SDK

### Running the App
For accurate performance metrics and UI rendering behavior, always compile and run the application in **Release Mode** to avoid debug VM overhead:

```bash
flutter run --release
```

---

## Resources
* [Flutter Performance Profiling Documentation](https://docs.flutter.dev/perf/performance)
* [Concurrency and Isolates in Dart](https://dart.dev/language/concurrency)
