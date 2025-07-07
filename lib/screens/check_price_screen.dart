import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'shipping_screen.dart';

class CheckPriceScreen extends StatefulWidget {
  const CheckPriceScreen({super.key});

  @override
  State<CheckPriceScreen> createState() => _CheckPriceScreenState();
}

class _CheckPriceScreenState extends State<CheckPriceScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  bool _isDimensionEnabled = false;
  bool _showResult = false;

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    _weightController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Cek Harga',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Main White Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Select Destination Section
                  const Text(
                    'Select Destination',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Pick-up Destination
                  _buildDestinationField(
                    icon: Icons.radio_button_checked,
                    iconColor: const Color(0xFF4B7BF5),
                    controller: _pickupController,
                    hintText: 'Enter your pick-up Destination',
                    hasLine: true,
                  ),

                  const SizedBox(height: 16),

                  // Drop-off Destination
                  _buildDestinationField(
                    icon: Icons.flag,
                    iconColor: Colors.red,
                    controller: _dropoffController,
                    hintText: 'Enter your drop-off Destination',
                    hasLine: false,
                  ),

                  const SizedBox(height: 24),

                  // Weight Section
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: TextField(
                      controller: _weightController,
                      decoration: const InputDecoration(
                        hintText: 'Weight',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 16,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Dimensi Section
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Dimensi',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9E9E9E),
                              ),
                            ),
                            Switch(
                              value: _isDimensionEnabled,
                              onChanged: (value) {
                                setState(() {
                                  _isDimensionEnabled = value;
                                });
                              },
                              activeColor: const Color(0xFF4B7BF5),
                            ),
                          ],
                        ),
                        if (_isDimensionEnabled) ...[
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDimensionField(
                                    'Length', _lengthController),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'X',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildDimensionField(
                                    'Width', _widthController),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'X',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildDimensionField(
                                    'Height', _heightController),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Check Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  _checkPrice();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _showResult
                      ? const Color(0xFF4B7BF5).withOpacity(0.6)
                      : const Color(0xFF4B7BF5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Check',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Result Section
            if (_showResult) ...[
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Express',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Estimated',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                        const Text(
                          '3-5 Days',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Delivery Fee',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                        const Text(
                          'Rp.100.000',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          _sendNow();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4B7BF5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Send Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationField({
    required IconData icon,
    required Color iconColor,
    required TextEditingController controller,
    required String hintText,
    required bool hasLine,
  }) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 12,
              ),
            ),
            if (hasLine) ...[
              Container(
                width: 2,
                height: 32,
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: CustomPaint(
                  painter: DashedLinePainter(),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(36),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      hintStyle: const TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const Icon(
                  Icons.close,
                  color: Color(0xFF9E9E9E),
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDimensionField(String label, TextEditingController controller) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF9E9E9E),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE0E0E0), width: 0.5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                hintStyle: TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 14,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
      ],
    );
  }

  void _checkPrice() {
    // Validate inputs
    if (_pickupController.text.isEmpty ||
        _dropoffController.text.isEmpty ||
        _weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap lengkapi semua field yang diperlukan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _showResult = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Harga berhasil dihitung!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _sendNow() {
    // Navigate to shipping screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ShippingScreen(),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4B7BF5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 3.0;
    const dashSpace = 2.0;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
