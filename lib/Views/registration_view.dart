// ignore_for_file: library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _obscureText2 = true;
  bool _acceptTermsAndConditions = false;

  void _togglePasswordVisibility2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  void _toggleAcceptTermsAndConditions(bool? val) {
    setState(() {
      _acceptTermsAndConditions = !_acceptTermsAndConditions;
    });
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
                  Column(
                    children: const [
                      ProfileTextField(
                        label: 'Mariia Bulavenko',
                        icon: Icons.person_2_outlined,
                        width: 337.67,
                        height: 58.72,
                        borderWidth: 1,
                      ),
                      SizedBox(height: 10),
                      ProfileTextField(
                        label: 'dd/mm/yyyy',
                        icon: Icons.calendar_today_outlined,
                        width: 337.67,
                        height: 58.72,
                        borderWidth: 1,
                      ),
                      SizedBox(height: 10),
                      PhoneNumberField(),
                      SizedBox(height: 10),
                      ProfileTextField(
                        label: 'mariiab@extramus.eu',
                        icon: Icons.email_outlined,
                        width: 337.67,
                        height: 58.72,
                        borderWidth: 1,
                      ),
                      SizedBox(height: 20),
                      _CreateAccountButton(),
                      SizedBox(height: 16),
                      HoverableText(),
                    ],
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
      )
    );
  }
}

// Create Account Button
class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton({super.key});

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
        onPressed: () {},
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

  const ProfileTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.width,
    required this.height,
    required this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF3E3D3B),
        hintText: label,
        hintStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Color(0xFFFCFCFC),
          fontSize: 16,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(icon, color: Colors.white),
        ),
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

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({super.key});

  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  String selectedCountryCode = '+39';
  final TextEditingController phoneNumberController = TextEditingController();

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
            value: selectedCountryCode,
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
            onChanged: (String? newValue) {
              setState(() {
                selectedCountryCode = newValue!;
              });
            },
          ),
          const SizedBox(width: 8),
          // Phone Number Input Field
          Expanded(
            child: TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
                hintStyle: const TextStyle(
                    color: Colors.white), // Change hint text color to white
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

class HoverableText extends StatefulWidget {
  const HoverableText({super.key});

  @override
  _HoverableTextState createState() => _HoverableTextState();
}

class _HoverableTextState extends State<HoverableText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        cursor: SystemMouseCursors.click,
        child: Text(
          "I have registration code",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: _isHovered
                ? Colors.greenAccent
                : const Color.fromARGB(255, 233, 233, 233),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _onHover(bool hover) {
    setState(() {
      _isHovered = hover;
    });
  }
}