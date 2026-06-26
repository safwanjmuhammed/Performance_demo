import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:performance_demo/screen/rebuild_optimized.dart';
import 'package:performance_demo/screen/rebuild_unoptimized.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return  MaterialApp(
  debugShowCheckedModeBanner: false,
  showPerformanceOverlay: false,
  theme: ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.grey,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
      ),
    ),
  ),
  //home: const PerformanceDemo(),
 // home: const RebuildUnoptimized(),
  home: const PerformanceDemo()
);

  }
}

class PerformanceDemo extends StatefulWidget {
  const PerformanceDemo({super.key});

  @override
  State<PerformanceDemo> createState() => _PerformanceDemoState();
}

class _PerformanceDemoState extends State<PerformanceDemo> {
  int counter = 0;
  int liveTicker = 0;
  String randomNumber = "";
  bool toggleColor = false;
  bool isLoading = false;
  String result = "";

  late Timer timer;

  @override
  void initState() {
    super.initState();

    /// Rapid UI updates every 100ms
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        liveTicker++;
        randomNumber = Random().nextInt(100000).toString();
        toggleColor = !toggleColor;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  void freezeUI() {
    setState(() {
      isLoading = true;
      result = "Running heavy computation on main thread...";
    });

    final value = heavyComputation(800000000);

    setState(() {
      isLoading = false;
      result = "Main Thread Result: $value";
    });
  }


  Future<void> runInIsolate() async {
    setState(() {
      isLoading = true;
      result = "Running heavy computation in ISOLATE...";
    });

    final value = await compute(heavyComputation, 800000000);

    setState(() {
      isLoading = false;
      result = "Isolate Result: $value";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UI Freeze Demo (No Animation)"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          /// Live Updating Section
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Live Ticker: $liveTicker"),
                  const SizedBox(height: 8),
                  Text("Random Number: $randomNumber"),
                  const SizedBox(height: 8),
                  Container(
                    height: 30,
                    width: 100,
                    color: toggleColor ? Colors.green : Colors.red,
                  ),
                ],
              ),
            ),
          ),

          CommonButton(
            onPressed: () => setState(() => counter++),
            color: Colors.blue,
            child: Text("Counter: $counter"),
          ),

          const SizedBox(height: 8),

          CommonButton(
            onPressed: freezeUI,
            color: Colors.red,
            child: const Text("Freeze UI (Main Thread)"),
          ),

          const SizedBox(height: 8),

          CommonButton(
            onPressed: runInIsolate,
            color: Colors.green,
            child: const Text("Run in Isolate"),
          ),

          const SizedBox(height: 16),

          if (isLoading) const CircularProgressIndicator(),

          const SizedBox(height: 10),

          Text(result),

          const SizedBox(height: 10),

          /// Scrollable list
          Expanded(
            child: ListView.builder(
              itemCount: 200,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("List Item $index"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Heavy CPU Task
int heavyComputation(int count) {
  int sum = 0;
  for (int i = 0; i < count; i++) {
    sum += sqrt(i).toInt();
  }
  return sum;
}

class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;

  const CommonButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      child: child,
    );
  }
}
