import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignUpActive = false;
  void showSignIn() => setState(() => isSignUpActive = false);
  void showSignUp() => setState(() => isSignUpActive = true);

  bool _signInPasswordVisible = false;
  bool _signUpPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final containerWidth = screenW * 0.85;
    final containerHeight = screenH * 0.85;
    final panelW = containerWidth / 2;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, 10),
              )
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                width: panelW,
                height: containerHeight,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 450),
                  opacity: isSignUpActive ? 0.7 : 1.0,
                  child: Transform.scale(
                    scale: isSignUpActive ? 0.96 : 1.0,
                    child: _buildSignIn(panelW),
                  ),
                ),
              ),
              Positioned(
                left: panelW,
                top: 0,
                width: panelW,
                height: containerHeight,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 450),
                  opacity: isSignUpActive ? 1.0 : 0.75,
                  child: Transform.scale(
                    scale: isSignUpActive ? 1.0 : 0.98,
                    child: _buildSignUp(panelW),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                left: isSignUpActive ? 0 : panelW,
                top: 0,
                width: panelW,
                height: containerHeight,
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF82B1FF),
                        Color(0xFF032140),
                      ],
                    ),
                    borderRadius: isSignUpActive
                        ? const BorderRadius.only(
                      topRight: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    )
                        : const BorderRadius.only(
                      topLeft: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: _overlayContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _overlayContent() {
    final title = isSignUpActive ? 'Welcome Back!' : 'Welcome, Friend!';
    final subtitle = isSignUpActive
        ? 'To keep connected with us please login with your personal info'
        : 'Register with your personal details to use all features';
    final buttonLabel = isSignUpActive ? 'SIGN IN' : 'SIGN UP';
    final buttonAction = isSignUpActive ? showSignIn : showSignUp;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 28),
        ElevatedButton(
          onPressed: buttonAction,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 6,
          ),
          child: Text(buttonLabel, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildSignIn(double width) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Sign In',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.black )),
          const SizedBox(height: 8),
          const Text('Enter your personal details to use all features',
              textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
          const SizedBox(height: 20),
          _inputField('Email or phone'),
          const SizedBox(height: 14),
          _inputField('Password', obscure: true, isSignIn: true),
          const SizedBox(height: 8),
          // Forgot Password Button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage()));
              },
              child: const Text('Forgot Password?',
                  style: TextStyle(color: Colors.blueAccent)),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              minimumSize: Size(width, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text('SIGN IN', style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 18),
          const Text('continue with', style: TextStyle(color: Colors.black)),
          const SizedBox(height: 12),
          _socialRow(),
          const SizedBox(height: 18),
          TextButton(
            onPressed: showSignUp,
            child: const Text("Don't have an account? signup"),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp(double width) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Create Account',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color:Colors.black)),
          const SizedBox(height: 8),
          const Text('or use your email for registration',
              textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
          const SizedBox(height: 20),
          _inputField('Name'),
          const SizedBox(height: 12),
          _inputField('role'),
          const SizedBox(height: 10),
          _inputField('Email'),
          const SizedBox(height: 12),
          _inputField('Password', obscure: true, isSignIn: false),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              minimumSize: Size(width, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text('SIGN UP', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)),
          ),
          const SizedBox(height: 18),
          const SizedBox(height: 18),
          TextButton(
            onPressed: showSignIn,
            child: const Text('Already have an account? Sign In'),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String hint, {bool obscure = false, bool isSignIn = true}) {
    bool isPassword = obscure;
    return TextField(
      obscureText: isPassword
          ? (isSignIn ? !_signInPasswordVisible : !_signUpPasswordVisible)
          : false,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? InkWell(
          onTap: () {
            setState(() {
              if (isSignIn) {
                _signInPasswordVisible = !_signInPasswordVisible;
              } else {
                _signUpPasswordVisible = !_signUpPasswordVisible;
              }
            });
          },
          child: Icon(
            (isSignIn
                ? _signInPasswordVisible
                : _signUpPasswordVisible)
                ? Icons.visibility
                : Icons.visibility_off,
            color: Colors.grey,
          ),
        )
            : null,
      ),
    );
  }

  Widget _socialRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon(FontAwesomeIcons.google, Colors.red, () {}),
        const SizedBox(width: 16),
        _socialIcon(FontAwesomeIcons.facebook, Colors.blue, () {}),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _socialIcon(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: color.withOpacity(0.12),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}

// ------------------ Forgot Password Page ------------------
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
              ),
              child: const Text('Get OTP'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {},
              child: const Text('Resend OTP', style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        ),
      ),
    );
  }
}
