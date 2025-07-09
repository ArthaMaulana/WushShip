import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../auth/mock_auth_service.dart';
import 'register_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
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
            // Top blue section with illustration
            Container(
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Login_Screen2.png',
                          width: 500,
                          height: 467,
                          fit: BoxFit.cover,
                        ),
                      ],
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
                      'Masuk',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3B5FE8),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Subtitle
                    const Text(
                      'Sudah punya akun? ayo segera\nmasuk',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9E9E9E),
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Username field
                    _buildTextField(
                      controller: _usernameController,
                      hintText: 'Email',
                      icon: Icons.email_outlined,
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

                    // Forgot password link
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Handle forgot password
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Fitur lupa kata sandi belum tersedia'),
                            ),
                          );
                        },
                        child: const Text(
                          'Lupa Katasandi',
                          style: TextStyle(
                            color: Colors.red,
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
                          backgroundColor: const Color(0xFF3B5FE8),
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

                    // Register link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum punya akun? ',
                          style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _navigateToRegister();
                          },
                          child: const Text(
                            'Daftar',
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
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi email dan kata sandi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Basic email validation
    if (!_usernameController.text.contains('@')) {
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
      final success = await authService.signIn(
        email: _usernameController.text.trim(),
        password: _passwordController.text,
      );

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

        // Navigate to home screen
        _navigateToHome();
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

  void _navigateToHome() {
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        try {
          Navigator.pushReplacementNamed(context, '/user-home');
        } catch (e) {
          debugPrint('Navigation error: $e');
        }
      }
    });
  }

  void _navigateToRegister() {
    if (!mounted) return;

    try {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const RegisterScreen()),
      );
    } catch (e) {
      debugPrint('Navigation error: $e');
    }
  }
}
