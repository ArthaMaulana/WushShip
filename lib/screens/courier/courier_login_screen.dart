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
                        // Use a delivery-themed illustration or icon
                        Container(
                          child: Image.asset(
                            'assets/images/Login_Screen2.png', // Reuse the same image
                            width: 500,
                            height: 467,
                            fit: BoxFit.cover,
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
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                    // Title with orange color for courier theme
                    const Text(
                      'Masuk Kurir',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3B5FE8), // Orange color for courier
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Subtitle
                    const Text(
                      'Mulai bekerja dan dapatkan\npenghasilan',
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
                          'Belum punya akun kurir?',
                          style: TextStyle(
                            color: Color(0xFF3B5FE8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Login button with orange theme
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF3B5FE8), // Orange for courier
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

                    // Info text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Butuh bantuan? ',
                          style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showHelpInfo();
                          },
                          child: const Text(
                            'Hubungi Admin',
                            style: TextStyle(
                              color: Color(0xFF3B5FE8),
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

      // For courier login, try to sign in first, if fails create new account
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
            'Untuk demo, gunakan email dan password apapun untuk login.\n\n'
            'Sistem akan otomatis membuat akun kurir untuk Anda.\n\n'
            'Contoh:\nEmail: kurir@test.com\nPassword: 123456',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showHelpInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bantuan'),
          content: const Text(
            'Jika Anda mengalami masalah dengan login kurir, silakan hubungi:\n\n'
            'Email: admin@wushship.com\n'
            'WhatsApp: +62 812-3456-7890\n\n'
            'Jam operasional: 08:00 - 17:00 WIB',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
