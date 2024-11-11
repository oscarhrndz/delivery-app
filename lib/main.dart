import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv
import 'package:deliverit/Views/settings_view.dart';
import 'package:deliverit/Views/home_view.dart';
import 'package:deliverit/Views/search_view.dart';
import 'package:deliverit/Views/like_view.dart';
import 'package:deliverit/Views/login_view.dart';
import 'package:deliverit/Views/registration_view.dart';
import 'package:deliverit/Widgets/bottom_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load();

  // Initialize Firebase
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  bool _isLoggedIn = false;

  final List<Widget> _pages = [
    HomeView(),
    SearchView(),
    LikeView(),
    SettingsView(),
  ];

  @override
  void initState() {
    super.initState();
    _isLoggedIn = false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _login() {
    setState(() {
      _isLoggedIn = true;
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.pink),
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(
              body: WillPopScope(
                onWillPop: () async {
                  if (_selectedIndex != 0) {
                    _onItemTapped(0);
                    return false;
                  }
                  return true;
                },
                child: _isLoggedIn
                    ? _pages[_selectedIndex]
                    : LoginScreen(onLogin: _login),
              ),
              bottomNavigationBar: _isLoggedIn
                  ? BottomNavBar(
                      selectedIndex: _selectedIndex,
                      onItemSelected: _onItemTapped,
                    )
                  : null,
            ),
        '/login': (context) => LoginScreen(onLogin: _login),
        '/register': (context) => RegistrationScreen(),
      },
    );
  }
}
