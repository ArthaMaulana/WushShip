import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'Gabung jadi kurir kami, mudah dan menguntungkan',
      image: 'assets/images/Group.png',
    ),
    OnboardingItem(
      title: 'Mulai karirmu sebagai kurir, lebih cepat, lebih mudah',
      image: 'assets/images/group2.png', // Use the same image for now
    ),
    OnboardingItem(
      title: 'Masuk sekarang dan mulai kirim dengan mudah',
      image: 'assets/images/group3.png', // Use the same image for now
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar to light (dark icons)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button at top right with reduced padding
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, right: 20.0),
                child: TextButton(
                  onPressed: () {
                    _navigateToLogin();
                  },
                  child: const Text(
                    'Lewati',
                    style: TextStyle(color: Color(0xFF666666), fontSize: 16),
                  ),
                ),
              ),
            ),

            // PageView for onboarding slides
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _buildPage(_items[index]);
                },
              ),
            ),

            // Button (Next or Login depending on the page)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 150,
                left: 50.0,
                right: 50.0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _items.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _navigateToLogin();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B5FE8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    _currentPage == _items.length - 1 ? 'Login' : 'Next',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          // Image with no container background
          SizedBox(
            child: Center(
              child: Image.asset(
                item.image,
                width: 550,
                height: 350,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Page indicator dots moved before the text
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index) => _buildDot(index),
              ),
            ),
          ),

          // Title text
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: _currentPage == index ? 18 : 45,
      height: 10,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? const Color(0xFF3B5FE8)
            : const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String image;

  OnboardingItem({required this.title, required this.image});
}
