import 'package:deliverit/Views/settings_view.dart';
import 'package:flutter/material.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the SettingsView
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsView()),  // Navigate to the SettingsView
            );
          },
          child: Text('Go to Settings'),
        ),
      ),
    );
  }
}
