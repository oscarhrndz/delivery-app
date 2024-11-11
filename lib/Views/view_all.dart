import 'package:flutter/material.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Offers'),
      ),
      body: Center(
        child: const Text('Here are all promotional offers'),
      ),
    );
  }
}
