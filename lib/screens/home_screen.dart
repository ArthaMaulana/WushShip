import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../providers/shipment_provider.dart';
import '../widgets/feature_item.dart';
import '../widgets/search_box.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final topContainerHeight = screenHeight * 0.28; // Increased from 0.25

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Blue background at the top
          Container(
            height: topContainerHeight,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: TextStyle(
                                color: AppColors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                            const Text(
                              'WushShip',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person_outline,
                                color: AppColors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.notifications_none,
                                color: AppColors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Melacak Kiriman Anda',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Silakan masukkan pelacakan Anda',
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const SearchBox(),
                  ],
                ),
              ),
            ),
          ),

          // Main content
          Positioned(
            top:
                topContainerHeight -
                20, // Adjusted to overlap slightly with the top container
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Promo card
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Image.network(
                              'https://i.imgur.com/JR0wMlD.png',
                              height: 90,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    'assets/images/delivery.png',
                                    height: 90,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const SizedBox(
                                              height: 90,
                                              width: 100,
                                              child: Icon(
                                                Icons.delivery_dining,
                                                color: AppColors.primaryBlue,
                                                size: 50,
                                              ),
                                            ),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Kurir Siap',
                                  style: TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'Antar Barang',
                                  style: TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Berlangganan untuk layanan premium',
                                  style: TextStyle(
                                    color: AppColors.primaryBlue.withOpacity(
                                      0.7,
                                    ),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Features section
                    const Text(
                      'Fitur Layanan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Feature items
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FeatureItem(
                          icon: Icons.calculate,
                          title: 'Cek Harga',
                          subtitle: 'Cek Ongkir pengiriman',
                          color: Colors.purple.shade700,
                          iconBgColor: Colors.purple.shade100,
                        ),
                        FeatureItem(
                          icon: Icons.local_shipping_outlined,
                          title: 'Kirim',
                          subtitle: 'Layanan Reguler, tanpa ribet',
                          color: Colors.blue.shade700,
                          iconBgColor: Colors.blue.shade100,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Drop points section
                    const Text(
                      'Drop Point',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Map container
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              'https://i.imgur.com/JmQ8Lx7.jpg',
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: double.infinity,
                                    height: 150,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: Text('Map View'),
                                    ),
                                  ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            bottom: 20,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 100,
                            bottom: 40,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 30,
                            top: 20,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Add bottom padding to ensure content doesn't get cut off by bottom nav bar
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
