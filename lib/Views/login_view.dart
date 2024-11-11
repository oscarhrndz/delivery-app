import 'package:flutter/material.dart';
import 'package:deliverit/Views/registration_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;

  const LoginScreen({super.key, required this.onLogin});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _rememberMe = true;
  bool _isHoveringPrivacyPolicy = false;
  bool _isHoveringCreateAccount = false;
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleRememberMe(bool? value) {
    setState(() {
      _rememberMe = value ?? false;
    });
  }

  void _onPrivacyPolicyTapped() {
    debugPrint('Privacy Policy tapped');
  }

  void _onCreateAccountTapped() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegistrationScreen(),
      ),
    );
  }

  void _handleLogin() async {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        setState(() {
          _errorMessage = 'Please fill in all fields';
          _isLoading = false;
        });
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      widget.onLogin();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF6AC092),
      body: Center(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    Text(
                      'GetIT',
                      style: TextStyle(
                        fontFamily: 'RampartOne',
                        fontSize: screenWidth * 0.1,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextFieldLabel('Email'),
                          _buildTextField(hintText: 'Enter your email', controller: _emailController),
                          SizedBox(height: screenHeight * 0.02),
                          _buildTextFieldLabel('Password'),
                          _buildTextField(
                            hintText: 'Enter your password',
                            isPassword: true,
                            controller: _passwordController,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          if (_errorMessage != null) ...[
                            Text(
                              _errorMessage!,
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(height: 8.0),
                          ],
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: _toggleRememberMe,
                                activeColor: const Color(0xFF292726),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                side: const BorderSide(
                                  color: Color(0xFF292726),
                                  width: 1.5,
                                ),
                              ),
                              const Text(
                                "Remember me",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 0.0),
                          _buildPrivacyPolicyText(),
                          SizedBox(height: screenHeight * 0.02),
                          _buildLoginButton(),
                          SizedBox(height: screenHeight * 0.02),
                          _buildSocialMediaIcons(screenWidth),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    _buildCreateAccountText(),
                    SizedBox(height: screenHeight * 0.04),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey, width: 0.4),
        ),
      ),
    );
  }

  Widget _buildPrivacyPolicyText() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHoveringPrivacyPolicy = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHoveringPrivacyPolicy = false;
        });
      },
      child: GestureDetector(
        onTap: _onPrivacyPolicyTapped,
        child: Padding(
          padding: const EdgeInsets.only(left: 33.0, top: 2.0),
          child: Text(
            "Read Privacy Policy",
            style: TextStyle(
              color: _isHoveringPrivacyPolicy ? Colors.blue : const Color(0xFF999A9A),
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF292726),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: _isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : const Text('LOGIN'),
      ),
    );
  }

  Widget _buildSocialMediaIcons(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialMediaIcon('assets/images/facebook.png', screenWidth),
        const SizedBox(width: 20.0),
        _buildSocialMediaIcon('assets/images/google.png', screenWidth),
        const SizedBox(width: 20.0),
        _buildSocialMediaIcon('assets/images/apple.png', screenWidth),
      ],
    );
  }

  Widget _buildSocialMediaIcon(String assetPath, double screenWidth) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          debugPrint('${assetPath.split('/').last.split('.').first} icon tapped');
        },
        child: Image.asset(
          assetPath,
          height: screenWidth * 0.08,
          width: screenWidth * 0.08,
        ),
      ),
    );
  }

  Widget _buildCreateAccountText() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHoveringCreateAccount = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHoveringCreateAccount = false;
        });
      },
      child: GestureDetector(
        onTap: _onCreateAccountTapped,
        child: Text(
          'Create a new account',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: _isHoveringCreateAccount ? Colors.blue : Colors.black,
          ),
        ),
      ),
    );
  }
}
