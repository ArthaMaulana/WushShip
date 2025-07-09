import 'package:flutter/material.dart';

import '../../widgets/user/user_bottom_nav_bar.dart';
import 'home_screen.dart';
import 'my_order_screen.dart';
import 'profile_screen.dart';

class PremiumScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PremiumScreen({super.key, this.onBack});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  int selectedPlan = 1; // 0 = Monthly, 1 = Yearly

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/premium.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF1A1B2E).withOpacity(0.7),
                const Color(0xFF1A1B2E).withOpacity(0.9),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header with back button and restore
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (widget.onBack != null) {
                              widget.onBack!();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const Text(
                          'Restore',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Title and subtitle
                  const Text(
                    'WushShip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Pro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Pro',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'buka peluang besar untuk memudahkan\npendistribusian Anda!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // Features list
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _buildFeatureItem('Membuka fitur sekejul'),
                        const SizedBox(height: 14),
                        _buildFeatureItem('Mempermudah pendistribusian anda'),
                        const SizedBox(height: 14),
                        _buildFeatureItem('Membuka fitur titik koordinat'),
                        const SizedBox(height: 14),
                        _buildFeatureItem(
                            'Barang anda bisa untuk dijemput oleh kurir'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Subscription plans
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        // Monthly plan
                        Expanded(
                          child: _buildPricingCard(
                            isSelected: selectedPlan == 0,
                            title: 'Bulanan / 30 hari',
                            price: 'Rp.20.000',
                            subtitle: 'Pembayaran\nperbulanan',
                            onTap: () {
                              setState(() {
                                selectedPlan = 0;
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Yearly plan
                        Expanded(
                          child: _buildPricingCard(
                            isSelected: selectedPlan == 1,
                            title: 'Tahunan / 12 bln',
                            price: 'Rp.200.000',
                            subtitle: 'Pembayaran\npertahun',
                            onTap: () {
                              setState(() {
                                selectedPlan = 1;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Subscribe button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4B7BF5).withOpacity(0.4),
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _handleSubscribe(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4B7BF5),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ).copyWith(
                            overlayColor:
                                WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.pressed)) {
                                return Colors.white.withOpacity(0.2);
                              }
                              if (states.contains(WidgetState.hovered)) {
                                return Colors.white.withOpacity(0.1);
                              }
                              return null;
                            }),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Subscribe',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: UserBottomNavBar(
        currentIndex: 2, // PremiumScreen is at index 2
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
          } else if (index == 3) {
            // Profile
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
          // index == 2 (Premium) - stay on current screen
        },
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle,
          color: Color(0xFF4B7BF5),
          size: 24,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  void _handleSubscribe(BuildContext context) {
    // Handle subscription logic
    String planType = selectedPlan == 0 ? 'Bulanan' : 'Tahunan';
    String price = selectedPlan == 0 ? 'Rp.20.000' : 'Rp.200.000';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Subscribe to WushShip Pro'),
          content: Text(
              'Anda akan berlangganan paket $planType dengan harga $price'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle actual subscription
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Subscription successful!'),
                    backgroundColor: Color(0xFF4B7BF5),
                  ),
                );
              },
              child: const Text('Subscribe'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPricingCard({
    required bool isSelected,
    required String title,
    required String price,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(isSelected ? 1.02 : 1.0),
        child: Container(
          height: 130,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4B7BF5) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF4B7BF5).withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: TextStyle(
                  color:
                      isSelected ? Colors.white : Colors.white.withOpacity(0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white.withOpacity(0.85)
                      : Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
