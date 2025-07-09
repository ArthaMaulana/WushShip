import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to onboarding screen after 3 seconds
    Timer(const Duration(seconds: 2), () {
      _navigateToOnboarding();
    });
  }

  void _navigateToOnboarding() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Set status bar to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF3B5FE8), // Exact blue background color
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Vector-2.png at top-left
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/Vector-2.png',
              width: screenWidth * 0.4,
              height: screenHeight * 0.3,
              fit: BoxFit.cover,
            ),
          ),

          // Vector.png at bottom-right
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/Vector.png',
              width: screenWidth * 0.8,
              height: screenHeight * 0.2,
              fit: BoxFit.cover,
            ),
          ),

          // Center logo and text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo - no white background container
                Image.asset(
                  'assets/images/Logo.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  color: Colors.white, // Make logo white
                ),
                const SizedBox(height: 15),
                // App name with enhanced shadow for better visibility
                const Text(
                  'WushShip',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 15.0,
                        color: Colors.black26,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Loading indicator at the bottom - positioned exactly like in the example
          Positioned(
            bottom: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the top wave
class TopWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4B6FF8) // Lighter blue for the wave
      ..style = PaintingStyle.fill;

    final path = Path();

    // Starting from top-left
    path.moveTo(0, 0);
    // Top-right corner
    path.lineTo(size.width, 0);
    // Bottom-right with curve
    path.lineTo(size.width, size.height * 0.7);
    // Curve to bottom-left
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 1.2,
      0,
      size.height * 0.6,
    );
    // Back to top-left
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for the bottom wave
class BottomWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4B6FF8) // Lighter blue for the wave
      ..style = PaintingStyle.fill;

    final path = Path();

    // Starting from bottom-left
    path.moveTo(0, size.height);
    // Bottom-right corner
    path.lineTo(size.width, size.height);
    // Top-right with curve
    path.lineTo(size.width, size.height * 0.3);
    // Curve to top-left
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * -0.2,
      0,
      size.height * 0.4,
    );
    // Back to bottom-left
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
