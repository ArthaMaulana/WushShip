import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 1, color: Color(0xFFE0E0E0)),

            // Hari ini section
            _buildSectionHeader('Hari ini'),
            _buildNotificationItem(
              icon: Icons.local_offer_outlined,
              iconColor: const Color(0xFF4B7BF5),
              title: '30% Spesial Diskon!',
              subtitle: 'Spesial diskon untuk yang berlangganan nih!',
              time: '',
            ),

            // Kemarin section
            _buildSectionHeader('Kemarin'),
            _buildNotificationItem(
              icon: Icons.star_outline,
              iconColor: const Color(0xFF4B7BF5),
              title: 'Penilaian Kurir',
              subtitle: 'Barang sudah sampai, jangan lupa menilai kurir..',
              time: '',
            ),
            _buildNotificationItem(
              icon: Icons.location_on_outlined,
              iconColor: const Color(0xFF4B7BF5),
              title: 'Pastikan titik koordinat dengan benar',
              subtitle: 'Tetap Kan Titik koordinat nya dengan benar yaa',
              time: '',
            ),

            // June 7, 2023 section
            _buildSectionHeader('June 7, 2023'),
            _buildNotificationItem(
              icon: Icons.inventory_2_outlined,
              iconColor: const Color(0xFF4B7BF5),
              title: 'Barang Dikirimkan Ke Alamat',
              subtitle: 'Barang Akan segera dikirimkan jangan lupa di...',
              time: '',
            ),
            _buildNotificationItem(
              icon: Icons.account_circle_outlined,
              iconColor: const Color(0xFF4B7BF5),
              title: 'Akun telah selesai disiapkan',
              subtitle: 'Akun berhasil dibuat jangan lupa melengkapi...',
              time: '',
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2D3142),
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon container
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3142),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8F9BB3),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (time.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8F9BB3),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
