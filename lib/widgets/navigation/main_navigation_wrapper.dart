import 'package:flutter/material.dart';
import '../../screens/user/home_screen.dart';
import '../../screens/user/my_order_screen.dart';
import '../../screens/user/premium_screen.dart';
import '../../screens/user/profile_screen.dart';
import '../user/user_bottom_nav_bar.dart';
import 'keep_alive_wrapper.dart';

class MainNavigationWrapper extends StatefulWidget {
  final int initialIndex;
  
  const MainNavigationWrapper({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  late int _currentIndex;
  late PageController _pageController;

  // List semua screens dengan KeepAlive untuk performa optimal
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(
      initialPage: _currentIndex,
      keepPage: true, // Keep page state for better performance
    );
    
    // Initialize screens dengan navigation callback untuk PremiumScreen
    _screens = [
      const KeepAliveWrapper(child: HomeScreen()),
      const KeepAliveWrapper(child: MyOrderScreen()),
      KeepAliveWrapper(
        child: PremiumScreen(
          onBack: () => _onNavTap(0), // Navigate back to HomeScreen
        ),
      ),
      const KeepAliveWrapper(child: ProfileScreen()),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    // Cegah navigation jika index sama atau widget unmounted
    if (index == _currentIndex || !mounted) return;
    
    // Update state immediately tanpa delay
    setState(() {
      _currentIndex = index;
    });
    
    // Jump to page langsung tanpa animasi untuk performa optimal
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe untuk kontrol penuh
        itemCount: _screens.length, // Batasi item count
        itemBuilder: (context, index) {
          // Hanya render screen yang valid
          if (index >= 0 && index < _screens.length) {
            return _screens[index];
          }
          return const SizedBox.shrink(); // Fallback untuk index invalid
        },
        onPageChanged: (index) {
          // Update state hanya jika mounted dan index berbeda
          if (mounted && index != _currentIndex) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
      // Hide navbar when on PremiumScreen (index 2)
      bottomNavigationBar: _currentIndex == 2 ? null : UserBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
