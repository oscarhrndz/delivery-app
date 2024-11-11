import 'package:flutter/material.dart';

class FilterSelectionView extends StatelessWidget {
  const FilterSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Filters"),
        backgroundColor: const Color(0xFF6AC092),
      ),
      body: Center(
        child: const Text(
          "This is the filter selection view.",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
