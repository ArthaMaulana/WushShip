import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/courier/courier_bottom_nav_bar.dart';
import 'courier_call_screen.dart';
import 'courier_dashboard_screen.dart';
import 'courier_my_order_screen.dart';
import 'courier_profile_screen.dart';

class CourierChatScreen extends StatefulWidget {
  const CourierChatScreen({super.key});

  @override
  State<CourierChatScreen> createState() => _CourierChatScreenState();
}

class _CourierChatScreenState extends State<CourierChatScreen> {
  int _selectedTabIndex = 0;

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
        centerTitle: true,
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Top buttons section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        'Belum dibaca',
                        style: TextStyle(
                          color: Color(0xFF4B7BF5),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4B7BF5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        'Riwayat Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tab section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                _buildTab('All (100)', 0),
                const SizedBox(width: 32),
                _buildTab('Pengguna', 1),
                const SizedBox(width: 32),
                _buildTab('Chat Bot ai', 2),
                const SizedBox(width: 32),
                _buildTab('Cs', 3),
              ],
            ),
          ),

          // Chat list
          Expanded(
            child: Container(
              color: const Color(0xFFF8F9FA),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 20),
                  _buildSectionHeader('Today'),
                  const SizedBox(height: 16),
                  _buildChatItem(
                    name: 'Hamada Asahi',
                    message: 'Paket sudah sampai?',
                    status: 'Pengguna',
                    avatarIcon: Icons.person,
                    avatarColor: const Color(0xFFFF6B6B),
                  ),
                  _buildChatItem(
                    name: 'B.o.x',
                    message: 'Paket terdekat Yang harus diantar',
                    status: 'Bot ai',
                    avatarIcon: Icons.person,
                    avatarColor: const Color(0xFF4ECDC4),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Kemarin'),
                  const SizedBox(height: 16),
                  _buildChatItem(
                    name: 'Angga Ramadhan',
                    message: 'Paket sudah sampai?',
                    status: 'Pengguna',
                    avatarIcon: Icons.person,
                    avatarColor: const Color(0xFFFFE66D),
                  ),
                  _buildChatItem(
                    name: 'Maya',
                    message: 'Paket segera diantar',
                    status: 'Cs',
                    avatarIcon: Icons.person,
                    avatarColor: const Color(0xFFA8E6CF),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Sabtu, 20 Oktober 2024'),
                  const SizedBox(height: 16),
                  _buildChatItem(
                    name: 'Rakha',
                    message: '',
                    status: 'Pengguna',
                    avatarIcon: Icons.person,
                    avatarColor: const Color(0xFF4B7BF5),
                  ),
                  _buildChatItem(
                    name: 'Artha Maulana',
                    message: '',
                    status: 'Pengguna',
                    avatarIcon: Icons.person,
                    avatarColor: const Color(0xFF4B7BF5),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CourierBottomNavBar(
        currentIndex: 2, // Chat is at index 2
        onTap: (index) {
          // Navigate to different screens based on bottom nav selection
          if (index == 0) {
            // Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CourierDashboardScreen()),
            );
          } else if (index == 1) {
            // My Order
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CourierMyOrderScreen()),
            );
          } else if (index == 3) {
            // Profile
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CourierProfileScreen()),
            );
          }
          // index == 2 (Chat) - stay on current screen
        },
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFF4B7BF5) : Colors.grey,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          if (isSelected)
            Container(
              height: 2,
              width: 40,
              color: const Color(0xFF4B7BF5),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildChatItem({
    required String name,
    required String message,
    required String status,
    required IconData avatarIcon,
    required Color avatarColor,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to individual chat screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualChatScreen(
              name: name,
              status: status,
              avatarIcon: avatarIcon,
              avatarColor: avatarColor,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Avatar with person icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: avatarColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Chat content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              status,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (message.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Individual Chat Screen
class IndividualChatScreen extends StatefulWidget {
  final String name;
  final String status;
  final IconData avatarIcon;
  final Color avatarColor;

  const IndividualChatScreen({
    super.key,
    required this.name,
    required this.status,
    required this.avatarIcon,
    required this.avatarColor,
  });

  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final List<String> _quickReplies = [
    'Saya sedang dalam perjalanan',
    'Paket akan segera tiba',
    'Mohon tunggu sebentar',
    'Terima kasih',
    'Maaf atas keterlambatan',
    'Sudah sampai di lokasi',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with default messages
    _messages.addAll([
      {
        'message':
            'Hai Artha, I\'m on the way to your home, Please wait a moment . Thanks!',
        'isFromCourier': true,
        'time': '1:45 Am',
        'type': 'text',
      },
      {
        'message': 'Thank you, I\'ll be waiting for you',
        'isFromCourier': false,
        'time': '1:46 Am',
        'type': 'text',
      },
      {
        'message': 'I might be a little late because the road is jammed',
        'isFromCourier': true,
        'time': '1:45 Am',
        'type': 'text',
      },
      {
        'message': 'ASAP',
        'isFromCourier': false,
        'time': '1:46 Am',
        'type': 'asap',
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.avatarColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.avatarIcon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.status,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: Color(0xFF4B7BF5)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourierCallScreen(
                    name: widget.name,
                    status: widget.status,
                    avatarColor: widget.avatarColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                if (message['type'] == 'asap') {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildASAPMessage(message['time']),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildMessage(
                      message['message'],
                      message['isFromCourier'],
                      message['time'],
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Column(
              children: [
                // Quick replies
                SizedBox(
                  height: 100,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _quickReplies.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _sendMessage(_quickReplies[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: index == 0
                                ? const Color(0xFF4B7BF5)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: index == 0
                                  ? const Color(0xFF4B7BF5)
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _quickReplies[index],
                              style: TextStyle(
                                color: index == 0
                                    ? Colors.white
                                    : Colors.grey.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Message input
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.attach_file, color: Colors.grey),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type Your message',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.emoji_emotions_outlined,
                          color: Colors.grey),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Color(0xFF4B7BF5)),
                      onPressed: () {
                        if (_messageController.text.isNotEmpty) {
                          _sendMessage(_messageController.text);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String message, bool isFromCourier, String time) {
    return Align(
      alignment: isFromCourier ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isFromCourier ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isFromCourier
                  ? const Color(0xFFE8E8E8) // Abu-abu untuk kurir (kanan)
                  : const Color(0xFF4B7BF5), // Biru untuk pengguna (kiri)
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: isFromCourier
                    ? const Radius.circular(20)
                    : const Radius.circular(5),
                bottomRight: isFromCourier
                    ? const Radius.circular(5)
                    : const Radius.circular(20),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: isFromCourier ? Colors.black : Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildASAPMessage(String time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF4B7BF5), // Biru untuk pengguna (kiri)
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: const Text(
              'ASAP',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      // Add courier message
      _messages.add({
        'message': message,
        'isFromCourier': true,
        'time': _getCurrentTime(),
        'type': 'text',
      });
    });

    _messageController.clear();

    // Generate auto reply after 1-2 seconds
    Future.delayed(
        Duration(
            milliseconds:
                1000 + (DateTime.now().millisecondsSinceEpoch % 1000)), () {
      if (mounted) {
        _generateAutoReply(message);
      }
    });
  }

  void _generateAutoReply(String originalMessage) {
    List<String> replies = [];

    final lowerMessage = originalMessage.toLowerCase();

    if (lowerMessage.contains('paket') || lowerMessage.contains('package')) {
      replies = [
        'Paket sedang dalam perjalanan',
        'Paket akan segera sampai',
        'Baik, saya akan cek paket Anda',
        'Terima kasih, paket sudah diterima',
      ];
    } else if (lowerMessage.contains('terlambat') ||
        lowerMessage.contains('late')) {
      replies = [
        'Tidak apa-apa, terima kasih sudah menunggu',
        'Saya akan segera sampai',
        'Maaf jika terlambat',
        'Baik, saya akan tunggu',
      ];
    } else if (lowerMessage.contains('terima kasih') ||
        lowerMessage.contains('thank')) {
      replies = [
        'Sama-sama!',
        'Terima kasih kembali',
        'Senang bisa membantu',
        'Dengan senang hati',
      ];
    } else if (lowerMessage.contains('perjalanan') ||
        lowerMessage.contains('way')) {
      replies = [
        'Baik, saya akan menunggu',
        'Hati-hati di jalan',
        'Terima kasih sudah update',
        'Sampai jumpa nanti',
      ];
    } else if (lowerMessage.contains('sampai') ||
        lowerMessage.contains('arrive')) {
      replies = [
        'Terima kasih!',
        'Baik, saya sudah siap',
        'Saya tunggu di depan',
        'Sampai jumpa',
      ];
    } else {
      replies = [
        'Baik, terima kasih',
        'Saya mengerti',
        'Oke, siap',
        'Terima kasih infonya',
        'Baik, saya akan menunggu',
        'Sampai jumpa',
      ];
    }

    final randomReply =
        replies[DateTime.now().millisecondsSinceEpoch % replies.length];

    setState(() {
      _messages.add({
        'message': randomReply,
        'isFromCourier': false,
        'time': _getCurrentTime(),
        'type': 'text',
      });
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final ampm = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $ampm';
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
