import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_models.dart';
import '../../auth/mock_auth_service.dart';
import 'courier_dashboard_screen.dart';

class CourierLoginScreen extends StatefulWidget {
  const CourierLoginScreen({super.key});

  @override
  State<CourierLoginScreen> createState() => _CourierLoginScreenState();
}

class _CourierLoginScreenState extends State<CourierLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar to light (dark icons)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top section with illustration
            Container(
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Use a courier-related image or modify the existing one
                        Container(
                          width: 500,
                          height: 467,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(
                                    0xFFFF8C00), // Orange gradient for courier
                                Color(0xFFFF6B00),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.delivery_dining,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Kurir WushShip',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Mulai bekerja dan dapatkan penghasilan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Back button
                  Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom white section with form
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    const Text(
                      'Masuk Kurir',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF8C00),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Subtitle
                    const Text(
                      'Masuk sebagai kurir untuk mulai\nbekerja dan mendapatkan penghasilan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9E9E9E),
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Email field
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    // Password field
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Kata Sandi',
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),

                    const SizedBox(height: 10),

                    // Info text
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          _showRegisterInfo();
                        },
                        child: const Text(
                          'Belum punya akun?',
                          style: TextStyle(
                            color: Color(0xFFFF8C00),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8C00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27.5),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Masuk',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Register info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum punya akun kurir? ',
                          style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showRegisterInfo();
                          },
                          child: const Text(
                            'Hubungi Admin',
                            style: TextStyle(
                              color: Color(0xFFFF8C00),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27.5),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF333333),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 16,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF9E9E9E),
            size: 22,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xFF9E9E9E),
                    size: 22,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    // Validate input
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi email dan kata sandi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Basic email validation
    if (!_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Format email tidak valid'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      // For courier login, we need to either sign up or sign in
      // First try to sign in, if fails, create a new courier account
      bool success = await authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!success) {
        // If sign in fails, create a new courier account
        success = await authService.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          fullName: 'Kurir ${_emailController.text.split('@')[0]}',
          phone: '081234567890',
          role: UserRole.courier,
        );
      }

      if (success) {
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login berhasil!'),
              backgroundColor: Colors.green,
            ),
          );
        }

        // Navigate to courier dashboard
        _navigateToDashboard();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login gagal. Periksa email dan kata sandi Anda.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToDashboard() {
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        try {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CourierDashboardScreen()),
          );
        } catch (e) {
          debugPrint('Navigation error: $e');
        }
      }
    });
  }

  void _showRegisterInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Daftar sebagai Kurir'),
          content: const Text(
            'Untuk mendaftar sebagai kurir, silakan hubungi admin melalui:\n\n'
            'Email: admin@wushship.com\n'
            'WhatsApp: +62 812-3456-7890\n\n'
            'Atau gunakan email dan password apapun untuk demo.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFFFF8C00)),
              ),
            ),
          ],
        );
      },
    );
  }
}
