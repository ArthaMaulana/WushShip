import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
// Impor ini dikomentari karena implementasi widget ada di file ini
// import '../widgets/feature_item.dart';
// import '../widgets/search_box.dart';
import '../widgets/bottom_nav_bar.dart'; // Pastikan path ini benar

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
    final screenHeight = MediaQuery.of(
      context,
    ).size.height; // Perbaikan di sini: dihapus `.size` kedua
    // Increased header height to ensure SearchBox is fully visible within the blue area
    final headerHeight = screenHeight * 0.32; // Adjusted from 0.28

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // Use SingleChildScrollView for the entire body
        physics: const BouncingScrollPhysics(),
        child: Column(
          // Main Column to arrange elements vertically
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to the start
          children: [
            // Blue header container
            Container(
              height: headerHeight, // Define height for the header
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
                              // Icon Headset (instead of person_outline)
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.headset, // Changed icon
                                  color: AppColors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Icon Notifications (remains the same)
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
                      // SearchBox component is now correctly placed within the blue header
                      const SearchBox(),
                    ],
                  ),
                ),
              ),
            ),
            // The main content section.
            // Spacing is managed by SizedBox instead of negative translation.
            const SizedBox(
              height: 20,
            ), // Added spacing between blue header and promo card
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ), // Base horizontal padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Promo card
                  Container(
                    width: double.infinity,
                    height: 120, // Adjusted height for better visual balance
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        // Added shadow as seen in Figma
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Image.network(
                            // Placeholder image mimicking the courier in Figma
                            'https://placehold.co/120x120/ADD8E6/000000?text=Courier', // New placeholder
                            height: 120, // Adjusted height
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  height: 120, // Adjusted height
                                  width: 120, // Adjusted width
                                  color: Colors.blue.shade100,
                                  child: const Center(
                                    child: Icon(
                                      Icons.delivery_dining,
                                      color: AppColors.primaryBlue,
                                      size: 60,
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
                                  fontSize: 20, // Adjusted font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Antar Barang',
                                style: TextStyle(
                                  color: AppColors.primaryBlue,
                                  fontSize: 20, // Adjusted font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Berlangganan untuk layanan premium',
                                style: TextStyle(
                                  color: AppColors.primaryBlue.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // Space after promo card
                  // Features section
                  const Text(
                    'Fitur Layanan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  // Feature items
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Ensured FeatureItem has proper background and shadow if implemented within it
                      Expanded(
                        // Use Expanded to give equal space
                        child: FeatureItem(
                          icon: Icons.calculate,
                          title: 'Cek Harga',
                          subtitle: 'Cek Ongkir pengiriman',
                          color: Colors.purple.shade700,
                          iconBgColor: Colors.purple.shade100,
                        ),
                      ),
                      const SizedBox(width: 15), // Space between feature items
                      Expanded(
                        // Use Expanded to give equal space
                        child: FeatureItem(
                          icon: Icons.local_shipping_outlined,
                          title: 'Kirim',
                          subtitle: 'Layanan Reguler, tanpa ribet',
                          color: Colors.blue.shade700,
                          iconBgColor: Colors.blue.shade100,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Drop points section
                  const Text(
                    'Drop Point',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  // Map container
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        // Added shadow for the map container
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      // ClipRRect to apply border radius to the image
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        // Stack is still used here for the map pins
                        children: [
                          Image.network(
                            // Using a placeholder image for map
                            'https://placehold.co/400x150/E0E0E0/000000?text=Map+View',
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: Colors.grey.shade200,
                                  child: const Center(child: Text('Map View')),
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
                  ),
                  // Add bottom padding to ensure content doesn't get cut off by bottom nav bar
                  const SizedBox(
                    height: 80,
                  ), // Increased padding to prevent overflow
                ], // This closing bracket was misplaced
              ),
            ),
          ],
        ),
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

// --- Implementasi SearchBox ---
// Ini adalah definisi widget SearchBox yang digunakan di HomeScreen.
// Jika Anda memiliki file search_box.dart terpisah, Anda bisa menghapus ini
// dan memastikan impor di atas aktif.
class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.lightGrey),
          const SizedBox(width: 10),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Masukkan Nomor Pelacakan Anda',
                border: InputBorder.none,
                hintStyle: TextStyle(color: AppColors.lightGrey),
              ),
            ),
          ),
          // Ikon dari Figma (dengan asumsi ikon kustom atau font awesome)
          IconButton(
            icon: const Icon(
              Icons.swap_horiz,
              color: AppColors.primaryBlue,
            ), // Contoh ikon
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.access_time,
              color: AppColors.primaryBlue,
            ), // Contoh ikon
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// --- Implementasi FeatureItem ---
// Ini adalah definisi widget FeatureItem yang digunakan di HomeScreen.
// Jika Anda memiliki file feature_item.dart terpisah, Anda bisa menghapus ini
// dan memastikan impor di atas aktif.
class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color iconBgColor;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white, // Latar belakang putih
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          // Shadow seperti yang terlihat di Figma
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              // Perbaikan di sini: const
              color: AppColors.darkGrey, // Menggunakan AppColors.darkGrey
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(
              color: AppColors.darkGrey.withOpacity(
                0.7,
              ), // Menggunakan AppColors.darkGrey
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
