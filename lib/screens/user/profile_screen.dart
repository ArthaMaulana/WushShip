import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../auth/mock_auth_service.dart';
import '../../widgets/user/user_bottom_nav_bar.dart';
import '../courier/courier_login_screen.dart';
import 'home_screen.dart';
import 'my_order_screen.dart';
import 'premium_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture and Info
            const CircleAvatar(
              radius: 50,
              // backgroundImage: AssetImage(
              //     'assets/images/Logo.png'),
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),

            const Text(
              'Muhammad Gafri',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Muhammad@gmail.com',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Indonesia',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Profile Complete Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Profile anda telah lengkap!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4B7BF5),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Isi formulir dan nikmati\nsemua fitur yang tersedia.',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4B7BF5).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.assignment_turned_in,
                      color: Color(0xFF4B7BF5),
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Profile saya Section
            _buildSection(
              title: 'Profile saya',
              children: [
                _buildMenuItem(
                  icon: Icons.person_outline,
                  title: 'Pusat akun',
                  subtitle: 'Kata sandi, Keamanan, Detail Pribadi.',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: Icons.delivery_dining,
                  title: 'Kurir',
                  subtitle: 'Ayo Mendaftar Menjadi kurir',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CourierLoginScreen(),
                      ),
                    );
                  },
                  hasBackground: true,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Pengaturan Section
            _buildSection(
              title: 'Pengaturan',
              children: [
                _buildMenuItem(
                  icon: Icons.language,
                  title: 'Bahasa',
                  subtitle: '',
                  onTap: () {},
                  hasToggle: true,
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: Icons.key,
                  title: 'Ganti kata sandi',
                  subtitle: '',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Tentang Kami Section
            _buildSection(
              title: 'Tentang Kami',
              children: [
                _buildMenuItem(
                  icon: Icons.security,
                  title: 'Keamanan privasi',
                  subtitle: '',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: Icons.help_outline,
                  title: 'FAQ',
                  subtitle: '',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Login Section
            _buildSection(
              title: 'Login',
              children: [
                _buildLoginButton(
                  icon: Icons.swap_horiz,
                  title: 'Ganti Akun',
                  color: const Color(0xFF4B7BF5),
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                _buildLoginButton(
                  icon: Icons.logout,
                  title: 'Keluar',
                  color: Colors.red,
                  onTap: () {
                    _showLogoutDialog();
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: UserBottomNavBar(
        currentIndex: 3, // ProfileScreen is at index 3
        onTap: (index) {
          // Navigate to different screens based on bottom nav selection
          if (index == 0) {
            // Home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 1) {
            // My Orders
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyOrderScreen()),
            );
          } else if (index == 2) {
            // Premium
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PremiumScreen()),
            );
          }
          // index == 3 (Profile) - stay on current screen
        },
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        ...children,
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool hasBackground = false,
    bool hasToggle = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: hasBackground ? const Color(0xFFE3F2FD) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: hasBackground ? Colors.white : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: hasBackground
                    ? const Color(0xFF4B7BF5)
                    : Colors.grey.shade600,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ),
            if (hasToggle)
              Container(
                width: 40,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              )
            else
              const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout();
              },
              child: const Text('Keluar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _performLogout() async {
    try {
      // Get the AuthService instance
      final authService = Provider.of<AuthService>(context, listen: false);

      // Perform sign out
      await authService.signOut();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil keluar dari akun'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to login screen and clear all previous routes
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      // Show error message if logout fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal logout: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
