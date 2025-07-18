import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/courier/courier_bottom_nav_bar.dart';
import 'courier_chat_screen.dart';
import 'courier_my_order_screen.dart';
import 'courier_profile_screen.dart';

class CourierDashboardScreen extends StatefulWidget {
  const CourierDashboardScreen({super.key});

  @override
  State<CourierDashboardScreen> createState() => _CourierDashboardScreenState();
}

class _CourierDashboardScreenState extends State<CourierDashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          Column(
            children: [
              // Header Section with Blue Background
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4B7BF5),
                      Color(0xFF3B5FE8),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Top bar with greeting and icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'WushShip Courier',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                _buildHeaderIcon(Icons.notifications_outlined),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),

                        // Main tracking text
                        const Column(
                          children: [
                            Text(
                              'Lacak kirimanmu pantau setiap langkahnya',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'selalu tahu di mana barang berada',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      top: 40, left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Courier Statistics Banner
                      _buildCourierStatsBanner(),

                      const SizedBox(height: 12),

                      // Detailed Statistics
                      _buildDetailedStatistics(),

                      const SizedBox(height: 30),

                      // Action Buttons
                      _buildActionButtons(),

                      const SizedBox(height: 30),

                      // Courier List
                      _buildCourierList(),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Search Bar - Positioned to overlap
          Positioned(
            top: MediaQuery.of(context).padding.top +
                190, // Adjust position based on header
            left: 50,
            right: 50,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: Color(0xFF8F9BB3),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Masukkan Nomor Pelacakan ',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color(0xFF8F9BB3),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4B7BF5),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner_outlined,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CourierBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // Navigate to different screens based on bottom nav selection
          if (index == 1) {
            // My Order
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CourierMyOrderScreen(),
              ),
            );
          } else if (index == 2) {
            // Chat icon
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CourierChatScreen(),
              ),
            );
          } else if (index == 3) {
            // Profile icon
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CourierProfileScreen(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCourierStatsBanner() {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/Banner.png',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildDetailedStatistics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Statistik',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Paket Aktif',
                count: '12',
                countColor: const Color(0xFF4B7BF5),
                iconAsset: 'assets/images/Paket.png',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                title: 'Paket Pending',
                count: '22',
                countColor: Colors.orange,
                iconAsset: 'assets/images/paket_pending.png',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Selesai',
                count: '13',
                countColor: Colors.green,
                iconAsset: 'assets/images/Paket.png',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                title: 'Batal',
                count: '2',
                countColor: Colors.red,
                iconAsset: 'assets/images/paket_batal.png',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigate to Akan Datang screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Navigating to Akan Datang...'),
                    duration: Duration(seconds: 1),
                  ),
                );
                // TODO: Add navigation to Akan Datang screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AkanDatangScreen()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF4B7BF5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    'Akan Datang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigate to List Paket screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Navigating to List Paket...'),
                    duration: Duration(seconds: 1),
                  ),
                );
                // TODO: Add navigation to List Paket screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ListPaketScreen()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    'List Paket',
                    style: TextStyle(
                      color: Color(0xFF4B7BF5),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required Color countColor,
    required String iconAsset,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 80,
            height: 60,
            child: Image.asset(
              iconAsset,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              color: countColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Color(0xFF4B7BF5),
        size: 30,
      ),
    );
  }

  Widget _buildCourierList() {
    return Column(
      children: [
        _buildCourierItem(
          name: 'Muhammad Rakha R',
          address: 'JL.1 Kampung baru no.423',
          status: 'Cod',
          statusColor: const Color(0xFF4B7BF5),
          avatarColor: Colors.orange,
        ),
        const SizedBox(height: 12),
        _buildCourierItem(
          name: 'Artha Maulana',
          address: 'JL.1 Kampung baru no.1000',
          status: 'Non Cod',
          statusColor: Colors.red,
          avatarColor: const Color(0xFF4B7BF5),
        ),
        const SizedBox(height: 12),
        _buildCourierItem(
          name: 'Angga Ramadhan',
          address: 'JL.1 Kampung baru no.2',
          status: 'Cod',
          statusColor: const Color(0xFF4B7BF5),
          avatarColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildCourierItem({
    required String name,
    required String address,
    required String status,
    required Color statusColor,
    required Color avatarColor,
  }) {
    return GestureDetector(
      onTap: () {
        // Show courier details or navigate to courier detail screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected courier: $name'),
            duration: const Duration(seconds: 1),
          ),
        );
        // TODO: Add navigation to courier detail screen
        // Navigator.push(context, MaterialPageRoute(builder: (context) => CourierDetailScreen(courierName: name)));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: avatarColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              status,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
