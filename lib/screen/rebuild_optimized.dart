
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:performance_demo/screen/widget/live_updating_card.dart';
import 'package:performance_demo/screen/widget/scrollable_list.dart';

class RebuildOptimized extends StatefulWidget {
  const RebuildOptimized({super.key});

  @override
  State<RebuildOptimized> createState() => _RebuildOptimizedState();
}

class _RebuildOptimizedState extends State<RebuildOptimized> {
   
  ValueNotifier<int> liveTicker = ValueNotifier<int>(0);
  ValueNotifier<String> randomNumber = ValueNotifier<String>("");
  ValueNotifier<bool> toggleColor = ValueNotifier<bool>(false);

  late Timer timer;

  @override
  void initState() {
    super.initState();

    /// Rapid UI updates every 100ms
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
    
       liveTicker.value++;
        randomNumber.value = Random().nextInt(100000).toString();
        toggleColor.value = !toggleColor.value;
    
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
        title: const Text("Rebuild Optimized"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          /// Live Updating Section
          LiveUpdatingCard(
            liveTicker: liveTicker,
            randomNumber: randomNumber,
            toggleColor: toggleColor,
          ),
      Expanded(child: ScrollableList())
        ],
      ),
    );
  }
}

