import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Top buttons section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
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
                const SizedBox(width: 16),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                _buildTab('All (100)', 0),
                const SizedBox(width: 24),
                _buildTab('Pengguna', 1),
                const SizedBox(width: 24),
                _buildTab('Chat Bot ai', 2),
                const SizedBox(width: 24),
                _buildTab('Cs', 3),
              ],
            ),
          ),

          // Chat list
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 20),
                  _buildSectionHeader('Today'),
                  const SizedBox(height: 16),
                  _buildChatItem(
                    name: 'Hamada Asahi',
                    message: 'Paket sudah sampai?',
                    time: '',
                    status: 'Pengguna',
                    statusColor: Colors.grey,
                    avatarColor: Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  _buildChatItem(
                    name: 'B.o.x',
                    message: 'Paket terdekat Yang harus diantar',
                    time: '',
                    status: 'Bot ai',
                    statusColor: Colors.grey,
                    avatarColor: Colors.green,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Kemarin'),
                  const SizedBox(height: 16),
                  _buildChatItem(
                    name: 'Angga Ramadhan',
                    message: 'Paket sudah sampai?',
                    time: '',
                    status: 'Pengguna',
                    statusColor: Colors.grey,
                    avatarColor: Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  _buildChatItem(
                    name: 'Maya',
                    message: 'Paket segera diantar',
                    time: '',
                    status: 'Cs',
                    statusColor: Colors.grey,
                    avatarColor: Colors.brown,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Sabtu, 20 Oktober 2024'),
                  const SizedBox(height: 16),
                  _buildChatItem(
                    name: 'Rakha',
                    message: '',
                    time: '',
                    status: 'Pengguna',
                    statusColor: Colors.grey,
                    avatarColor: const Color(0xFF4B7BF5),
                  ),
                  const SizedBox(height: 12),
                  _buildChatItem(
                    name: 'Artha Maulana',
                    message: '',
                    time: '',
                    status: 'Pengguna',
                    statusColor: Colors.grey,
                    avatarColor: const Color(0xFF4B7BF5),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
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
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildChatItem({
    required String name,
    required String message,
    required String time,
    required String status,
    required Color statusColor,
    required Color avatarColor,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to individual chat screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening chat with $name'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: avatarColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
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
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 12,
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (message.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
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
      ),
    );
  }
}
