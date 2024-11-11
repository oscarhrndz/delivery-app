import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _obscureText2 = true;
  bool _acceptTermsAndConditions = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController(); // Added password controller

  void _togglePasswordVisibility2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  void _toggleAcceptTermsAndConditions(bool? val) {
    setState(() {
      _acceptTermsAndConditions = val ?? false;
    });
  }

  Future<void> _registerUser() async {
  if (_formKey.currentState!.validate()) {
    try {
      // Create a new user with Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text, // Use entered password
      );

      // Add user details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'name': _nameController.text,
        'dob': _dobController.text,
        'email': _emailController.text,
        'phone': _phoneNumberController.text,
        'createdAt': Timestamp.now(),
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Account created successfully!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green, // Green color for success
        ),
      );

      // Navigate to the login screen
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login'); // Update with your login screen route
    } catch (e) {
      String errorMessage = 'Registration failed. Please try again.';
      if (e is FirebaseAuthException) {
        if (e.code == 'weak-password') {
          errorMessage = 'The password is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email.';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
    }
  }
}


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF292726),
      appBar: AppBar(
        backgroundColor: const Color(0xFF292726),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: Container(
            width: 43.99,
            height: 43.99,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.keyboard_arrow_left),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenWidth * 0.9),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Sign Up Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Sign Up With",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Row for social media icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(
                        context,
                        assetPath: 'assets/images/google.png',
                        onTap: () => debugPrint("Google icon tapped"),
                      ),
                      const SizedBox(width: 20),
                      _buildSocialIcon(
                        context,
                        assetPath: 'assets/images/facebook.png',
                        onTap: () => debugPrint("Facebook icon tapped"),
                      ),
                      const SizedBox(width: 20),
                      _buildSocialIcon(
                        context,
                        assetPath: 'assets/images/apple.png',
                        onTap: () => debugPrint("Apple icon tapped"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Form fields and update button, with same width
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ProfileTextField(
                          controller: _nameController,
                          label: 'Name',
                          icon: Icons.person_2_outlined,
                          width: 337.67,
                          height: 58.72,
                          borderWidth: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        ProfileTextField(
                          controller: _dobController,
                          label: 'dd/mm/yyyy',
                          icon: Icons.calendar_today_outlined,
                          width: 337.67,
                          height: 58.72,
                          borderWidth: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your date of birth';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        PhoneNumberField(controller: _phoneNumberController),
                        const SizedBox(height: 10),
                        ProfileTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email_outlined,
                          width: 337.67,
                          height: 58.72,
                          borderWidth: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        ProfileTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          width: 337.67,
                          height: 58.72,
                          borderWidth: 1,
                          obscureText: _obscureText2,
                          togglePasswordVisibility: _togglePasswordVisibility2,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        _CreateAccountButton(onPressed: _registerUser),
                        const SizedBox(height: 16),
                        const HoverableText(), // Add HoverableText here
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build social media icon buttons
  Widget _buildSocialIcon(BuildContext context,
      {required String assetPath, required VoidCallback onTap}) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(
            Colors.white, // Apply white color
            BlendMode.srcIn, // Blend mode
          ),
          child: Image.asset(
            assetPath,
            height: screenWidth * 0.08,
            width: screenWidth * 0.08,
          ),
        ),
      ),
    );
  }
}

// Create Account Button
class _CreateAccountButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _CreateAccountButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6AC092),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          'Create New Account',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}

// Custom reusable text field widget
class ProfileTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final double width;
  final double height;
  final double borderWidth;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final VoidCallback? togglePasswordVisibility;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.width,
    required this.height,
    required this.borderWidth,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.togglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF3E3D3B),
        hintText: label,
        hintStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Color(0xFFFCFCFC),
          fontSize: 16,
        ),
        suffixIcon: obscureText
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: togglePasswordVisibility,
              )
            : Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  const PhoneNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF3E3D3B),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Dropdown Button
          DropdownButton<String>(
            value: '+39',
            dropdownColor:
                const Color(0xFF3E3D3B), // Dropdown menu background color
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white, // Text color inside the dropdown
              fontSize: 16,
            ),
            iconEnabledColor: Colors.white, // Dropdown arrow color
            underline: const SizedBox(), // Remove the underline
            items: <String>['+39', '+1', '+44', '+91']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {},
          ),
          const SizedBox(width: 8),
          // Phone Number Input Field
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
                hintStyle: const TextStyle(color: Colors.white), // Change hint text color to white
                border: InputBorder.none, // Remove border
                suffixIcon: const Icon(
                  Icons.phone_outlined,
                  color: Colors.white, // Change phone icon color to white
                ),
              ),
              style: const TextStyle(
                  color: Colors.white, fontSize: 16), // Text color
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }
}

// Hoverable Text Widget
class HoverableText extends StatefulWidget {
  const HoverableText({super.key});

  @override
  _HoverableTextState createState() => _HoverableTextState();
}

class _HoverableTextState extends State<HoverableText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Text(
        'By signing up, you agree to our Terms & Conditions',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: _isHovered ? Colors.blue : Colors.white,
          fontWeight: FontWeight.w500,
          decoration: _isHovered ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}
