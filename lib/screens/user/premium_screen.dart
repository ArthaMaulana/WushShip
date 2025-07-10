import 'package:flutter/material.dart';
import 'package:wuship_project/screens/user/home_screen.dart';

class PremiumScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PremiumScreen({super.key, this.onBack});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen>
    with TickerProviderStateMixin {
  int selectedPlan = 1; // 0 = Monthly, 1 = Yearly

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;

  // Animations
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Initialize animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Start animations immediately when screen loads
    _startAnimations();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reset dan restart animasi setiap kali screen menjadi visible
    _resetAndStartAnimations();
  }

  void _resetAndStartAnimations() {
    // Reset semua animasi ke posisi awal
    _fadeController.reset();
    _slideController.reset();
    _scaleController.reset();

    // Start animasi dengan delay yang tepat
    _startAnimations();
  }

  void _startAnimations() async {
    // Pastikan widget masih mounted sebelum memulai animasi
    if (!mounted) return;

    // Start fade animation
    _fadeController.forward();

    // Start slide animation with delay
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) _slideController.forward();

    // Start scale animation with delay
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      extendBodyBehindAppBar: true, // Extend body behind app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // Handle restore functionality
                },
                child: const Text(
                  'Restore',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge(
            [_fadeController, _slideController, _scaleController]),
        builder: (context, child) {
          return Container(
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
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          const SizedBox(height: 24), // Space for app bar

                          // Title with scale animation
                          ScaleTransition(
                            key: const ValueKey('title_animation'),
                            scale: _scaleAnimation,
                            child: const Text(
                              'WushShip',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Pro badge with scale animation
                          ScaleTransition(
                            key: const ValueKey('pro_badge_animation'),
                            scale: _scaleAnimation,
                            child: Row(
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
                          ),

                          const SizedBox(height: 6),

                          // Subtitle with fade animation
                          FadeTransition(
                            key: const ValueKey('subtitle_animation'),
                            opacity: _fadeAnimation,
                            child: const Text(
                              'buka peluang besar untuk memudahkan\npendistribusian Anda!',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Features list with staggered animation
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                _buildAnimatedFeatureItem(
                                    'Membuka fitur sekejul', 0),
                                const SizedBox(height: 14),
                                _buildAnimatedFeatureItem(
                                    'Mempermudah pendistribusian anda', 1),
                                const SizedBox(height: 14),
                                _buildAnimatedFeatureItem(
                                    'Membuka fitur titik koordinat', 2),
                                const SizedBox(height: 14),
                                _buildAnimatedFeatureItem(
                                    'Barang anda bisa untuk dijemput oleh kurir',
                                    3),
                              ],
                            ),
                          ),

                          const SizedBox(height: 36),

                          // Subscription plans with scale animation
                          ScaleTransition(
                            key: const ValueKey('pricing_plans_animation'),
                            scale: _scaleAnimation,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                children: [
                                  // ...existing pricing cards...
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
                          ),

                          const SizedBox(height: 36),

                          // Subscribe button with enhanced animations
                          TweenAnimationBuilder<double>(
                            key: const ValueKey(
                                'subscribe_button'), // Key unik untuk restart animasi
                            duration: const Duration(milliseconds: 1400),
                            tween: Tween(begin: 0.0, end: 1.0),
                            builder: (context, animationValue, child) {
                              return Transform.translate(
                                offset: Offset(0, 50 * (1 - animationValue)),
                                child: Transform.scale(
                                  scale: 0.7 +
                                      (0.3 *
                                          animationValue), // Scale dari 0.7 ke 1.0
                                  child: Opacity(
                                    opacity: animationValue,
                                    child: ScaleTransition(
                                      scale: _scaleAnimation,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF4B7BF5)
                                                      .withOpacity(
                                                          0.4 * animationValue),
                                                  blurRadius:
                                                      20 * animationValue,
                                                  spreadRadius: 0,
                                                  offset: Offset(
                                                      0, 8 * animationValue),
                                                ),
                                              ],
                                            ),
                                            child: AnimatedBuilder(
                                              animation: _fadeController,
                                              builder: (context, child) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        const Color(0xFF4B7BF5),
                                                        Color.lerp(
                                                            const Color(
                                                                    0xFF4B7BF5)
                                                                .withOpacity(
                                                                    0.6),
                                                            const Color(
                                                                0xFF4B7BF5),
                                                            _fadeController
                                                                .value)!,
                                                        const Color(0xFF4B7BF5),
                                                      ],
                                                      stops: [
                                                        0.0,
                                                        _fadeController.value,
                                                        1.0
                                                      ],
                                                      begin: const Alignment(
                                                          -1.0, 0.0),
                                                      end: const Alignment(
                                                          1.0, 0.0),
                                                    ),
                                                  ),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      _handleSubscribe(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      foregroundColor:
                                                          Colors.white,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 18),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      elevation: 0,
                                                      shadowColor:
                                                          Colors.transparent,
                                                    ).copyWith(
                                                      overlayColor:
                                                          WidgetStateProperty
                                                              .resolveWith(
                                                                  (states) {
                                                        if (states.contains(
                                                            WidgetState
                                                                .pressed)) {
                                                          return Colors.white
                                                              .withOpacity(0.2);
                                                        }
                                                        if (states.contains(
                                                            WidgetState
                                                                .hovered)) {
                                                          return Colors.white
                                                              .withOpacity(0.1);
                                                        }
                                                        return null;
                                                      }),
                                                    ),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Subscribe',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedFeatureItem(String text, int index) {
    // Create staggered animation for each feature item yang selalu restart
    return TweenAnimationBuilder<double>(
      key: ValueKey('feature_$index'), // Key unik untuk memaksa rebuild
      duration: Duration(milliseconds: 1000 + (index * 150)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Row(
              children: [
                Transform.scale(
                  scale: 0.5 + (0.5 * value), // Scale dari 0.5 ke 1.0
                  child: Icon(
                    Icons.check_circle,
                    color: Color.lerp(const Color(0xFF4B7BF5).withOpacity(0.3),
                        const Color(0xFF4B7BF5), value),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Color.lerp(
                          Colors.white.withOpacity(0.3), Colors.white, value),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
        child: TweenAnimationBuilder<double>(
          key: ValueKey(
              'pricing_${title}_$isSelected'), // Key unik untuk restart animasi
          duration: const Duration(milliseconds: 800),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, animationValue, child) {
            return Transform.translate(
              offset: Offset(0, 40 * (1 - animationValue)),
              child: Transform.scale(
                scale: 0.8 + (0.2 * animationValue), // Scale dari 0.8 ke 1.0
                child: Opacity(
                  opacity: animationValue,
                  child: Container(
                    height: 130,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF4B7BF5)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF4B7BF5)
                                    .withOpacity(0.3 * animationValue),
                                blurRadius: 15 * animationValue,
                                spreadRadius: 0,
                                offset: Offset(0, 6 * animationValue),
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
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.9),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
