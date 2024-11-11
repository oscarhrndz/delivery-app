import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location View'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('This is the Location View'),
      ),
    );
  }
}
