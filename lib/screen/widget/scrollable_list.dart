import 'package:flutter/material.dart';

class ScrollableList extends StatelessWidget {
  const ScrollableList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 200,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("List Item $index"),
        );
      },
    );
  }
}