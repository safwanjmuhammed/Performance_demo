import 'package:flutter/material.dart';

class LiveUpdatingCard extends StatelessWidget {
  final ValueNotifier<int> liveTicker;
  final ValueNotifier<String> randomNumber;
  final ValueNotifier<bool> toggleColor;

  const LiveUpdatingCard({
    super.key,
    required this.liveTicker,
    required this.randomNumber,
    required this.toggleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ValueListenableBuilder<int>(
              valueListenable: liveTicker,
              builder: (context, value, child) {
                return Text("Live Ticker: $value");
              },
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<String>(
              valueListenable: randomNumber,
              builder: (context, value, child) {
                return Text("Random Number: $value");
              },
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<bool>(
              valueListenable: toggleColor,
              builder: (context, value, child) {
                return Container(
                  height: 30,
                  width: 100,
                  color: value ? Colors.green : Colors.red,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}