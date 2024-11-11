import 'package:flutter/material.dart';
import 'package:deliverit/Views/settings_view.dart';
import 'package:deliverit/Views/home_view.dart';
import 'package:deliverit/Views/search_view.dart';
import 'package:deliverit/Views/like_view.dart';
import 'package:deliverit/Widgets/bottom_nav_bar.dart';
import 'package:deliverit/Views/login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0; // Default index for Home
  bool _isLoggedIn = false; // Variable to track login status

  final List<Widget> _pages = [
    HomeView(),
    SearchView(),
    LikeView(),
    SettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
  }

  void _login() {
    setState(() {
      _isLoggedIn = true; // Update login status
      _selectedIndex = 0; // Set selected index to HomeView after login
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            if (_selectedIndex != 0) {
              // If not on HomeView, navigate back to HomeView
              _onItemTapped(0);
              return false; // Prevent default back action
            }
            return true; // Allow default back action
          },
          child: _isLoggedIn 
              ? _pages[_selectedIndex] // Display the selected page if logged in
              : LoginScreen(onLogin: _login), // Show LoginScreen if not logged in
        ),
        bottomNavigationBar: _isLoggedIn // Only show the BottomNavBar if logged in
            ? BottomNavBar(
                selectedIndex: _selectedIndex,
                onItemSelected: _onItemTapped,
              )
            : null, // Hide BottomNavBar if not logged in
      ),
    );
  }
}
