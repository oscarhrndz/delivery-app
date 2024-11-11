import 'package:deliverit/Views/home_view.dart';
import 'package:flutter/material.dart'; // Adjust the import based on your project structure.
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp().then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),  // Navigate to MainPage after loading
      );
    });
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));  // Simulate some loading
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFABCB), 
      body: Center(
        child: Text(
          'GetIt',
          style: GoogleFonts.rampartOne(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 48,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}