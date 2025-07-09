import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CourierCallScreen extends StatefulWidget {
  final String name;
  final String status;
  final Color avatarColor;

  const CourierCallScreen({
    super.key,
    required this.name,
    required this.status,
    required this.avatarColor,
  });

  @override
  State<CourierCallScreen> createState() => _CourierCallScreenState();
}

class _CourierCallScreenState extends State<CourierCallScreen> {
  bool _isMuted = false;
  bool _isSpeakerOn = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPatternPainter(),
            ),
          ),

          // Top section with back button and title
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            right: 20,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'WushShip',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48), // Balance the back button
              ],
            ),
          ),

          // Central profile section
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile picture with circular rings
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue.shade200,
                      width: 2,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue.shade300,
                        width: 2,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: widget.avatarColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.delivery_dining,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Name
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                // Status
                Text(
                  widget.status,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Bottom control buttons
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // More options button
                  GestureDetector(
                    onTap: () {
                      _showMoreOptions(context);
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ),

                  // Speaker button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSpeakerOn = !_isSpeakerOn;
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ),

                  // Mute button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isMuted = !_isMuted;
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _isMuted ? Colors.grey.shade400 : Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isMuted ? Icons.mic_off : Icons.mic,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ),

                  // End call button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Video Call'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Video call feature coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Send Message'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context); // Go back to chat
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Profile'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile feature coming soon')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for background pattern
class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade50
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw circular patterns
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 1; i <= 5; i++) {
      canvas.drawCircle(center, i * 60.0, paint);
    }

    // Draw additional decorative lines
    final linePaint = Paint()
      ..color = Colors.blue.shade100
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Draw curved lines
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * (3.14159 / 180);
      final startX = center.dx + 100 * cos(angle);
      final startY = center.dy + 100 * sin(angle);
      final endX = center.dx + 300 * cos(angle);
      final endY = center.dy + 300 * sin(angle);

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
