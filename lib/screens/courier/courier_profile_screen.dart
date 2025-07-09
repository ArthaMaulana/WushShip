import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_models.dart';
import '../../auth/mock_auth_service.dart';
import '../../widgets/courier/courier_bottom_nav_bar.dart';
import 'courier_chat_screen.dart';
import 'courier_dashboard_screen.dart';

class CourierProfileScreen extends StatefulWidget {
  const CourierProfileScreen({super.key});

  @override
  State<CourierProfileScreen> createState() => _CourierProfileScreenState();
}

class _CourierProfileScreenState extends State<CourierProfileScreen> {
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
          'Profile Kurir',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture and Info
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF4B7BF5),
              child: Icon(Icons.delivery_dining, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),

            const Text(
              'Muhammad Rakha R',
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
                  'rakha.courier@wushship.com',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4B7BF5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Kurir Aktif',
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

            // Courier Stats Banner
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
                          'Status Kurir Aktif!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4B7BF5),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Anda sedang dalam status aktif\ndan siap menerima pesanan.',
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
                      Icons.delivery_dining,
                      color: Color(0xFF4B7BF5),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Statistik Kurir Section
            _buildSection(
              title: 'Statistik Kurir',
              children: [
                _buildMenuItem(
                  icon: Icons.local_shipping,
                  title: 'Total Pengiriman',
                  subtitle: '156 paket berhasil dikirim',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: Icons.star,
                  title: 'Rating Kurir',
                  subtitle: '4.8 ⭐ (128 ulasan)',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: Icons.timeline,
                  title: 'Performa Bulanan',
                  subtitle: 'Lihat statistik performa Anda',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Profile Kurir Section
            _buildSection(
              title: 'Profile Kurir',
              children: [
                _buildMenuItem(
                  icon: Icons.person_outline,
                  title: 'Informasi Pribadi',
                  subtitle: 'Ubah data pribadi dan kontak',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: Icons.directions_car,
                  title: 'Kendaraan',
                  subtitle: 'Kelola informasi kendaraan',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: Icons.schedule,
                  title: 'Jadwal Kerja',
                  subtitle: 'Atur jadwal ketersediaan',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Pengaturan Section
            _buildSection(
              title: 'Pengaturan',
              children: [
                _buildMenuItem(
                  icon: Icons.notifications,
                  title: 'Notifikasi',
                  subtitle: 'Atur preferensi notifikasi',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: Icons.language,
                  title: 'Bahasa',
                  subtitle: 'Indonesia',
                  onTap: () {},
                  hasToggle: true,
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: Icons.security,
                  title: 'Keamanan',
                  subtitle: 'Kata sandi dan keamanan akun',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Bantuan Section
            _buildSection(
              title: 'Bantuan',
              children: [
                _buildMenuItem(
                  icon: Icons.help_outline,
                  title: 'Pusat Bantuan',
                  subtitle: 'FAQ dan panduan kurir',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: Icons.phone,
                  title: 'Hubungi Support',
                  subtitle: 'Chat dengan tim support',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Akun Section
            _buildSection(
              title: 'Akun',
              children: [
                _buildLoginButton(
                  icon: Icons.swap_horiz,
                  title: 'Ganti Mode ke Pengguna',
                  color: const Color(0xFF4B7BF5),
                  onTap: () {
                    _showSwitchModeDialog();
                  },
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
      bottomNavigationBar: CourierBottomNavBar(
        currentIndex: 3, // Profile is at index 3
        onTap: (index) {
          // Navigate to different screens based on bottom nav selection
          if (index == 0) {
            // Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CourierDashboardScreen()),
            );
          } else if (index == 2) {
            // Chat
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CourierChatScreen()),
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
                  color: const Color(0xFF4B7BF5),
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

  void _showSwitchModeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ganti Mode'),
          content: const Text('Apakah Anda yakin ingin beralih ke mode pengguna?'),
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
                _switchToUserMode();
              },
              child: const Text('Ganti Mode', style: TextStyle(color: Color(0xFF4B7BF5))),
            ),
          ],
        );
      },
    );
  }

  void _switchToUserMode() async {
    try {
      // Get the AuthService instance
      final authService = Provider.of<AuthService>(context, listen: false);
      
      // Switch user role to user
      await authService.switchUserRole(UserRole.user);
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil beralih ke mode pengguna'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to user home screen and clear all previous routes
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/user-home',
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      // Show error message if switch fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal beralih mode: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content:
              const Text('Apakah Anda yakin ingin keluar dari akun kurir?'),
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
          content: Text('Berhasil keluar dari akun kurir'),
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
