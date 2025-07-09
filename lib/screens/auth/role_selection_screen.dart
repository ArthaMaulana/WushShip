import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import 'courier_login_screen.dart';
import 'user_login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void _navigateToUserLogin(BuildContext context) {
    if (context.mounted) {
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserLoginScreen(),
          ),
        );
      } catch (e) {
        // Handle navigation error silently
        debugPrint('Navigation error: $e');
      }
    }
  }

  void _navigateToCourierLogin(BuildContext context) {
    if (context.mounted) {
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CourierLoginScreen(),
          ),
        );
      } catch (e) {
        // Handle navigation error silently
        debugPrint('Navigation error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // App Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.local_shipping,
                  color: Colors.white,
                  size: 50,
                ),
              ),

              const SizedBox(height: 32),

              // Title
              const Text(
                'Selamat Datang di WushShip',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              Text(
                'Pilih peran Anda untuk melanjutkan',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 60),

              // User Role Card
              _buildRoleCard(
                context: context,
                icon: Icons.person,
                title: 'Pengguna',
                subtitle: 'Kirim paket dengan mudah dan cepat',
                color: AppColors.primary,
                onTap: () => _navigateToUserLogin(context),
              ),

              const SizedBox(height: 20),

              // Courier Role Card
              _buildRoleCard(
                context: context,
                icon: Icons.delivery_dining,
                title: 'Kurir',
                subtitle: 'Bekerja dan dapatkan penghasilan',
                color: Colors.orange,
                onTap: () => _navigateToCourierLogin(context),
              ),

              const Spacer(),

              // Footer
              Text(
                'Dengan melanjutkan, Anda menyetujui syarat dan ketentuan kami',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
