
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class RebuildUnoptimized extends StatefulWidget {
  const RebuildUnoptimized({super.key});

  @override
  State<RebuildUnoptimized> createState() => _RebuildUnoptimizedState();
}

class _RebuildUnoptimizedState extends State<RebuildUnoptimized> {
  int liveTicker = 0;
  String randomNumber = "";
  bool toggleColor = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rebuild Unoptimized"),
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


