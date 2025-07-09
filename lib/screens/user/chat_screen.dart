import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          'Hai Artha, saya sedang dalam perjalanan ke rumah Anda, Mohon tunggu sebentar. Terima kasih!',
      isFromMe: false,
      timestamp: '1:45 Am',
    ),
    ChatMessage(
      text: 'Terima kasih, aku akan menunggumu',
      isFromMe: true,
      timestamp: '1:46 Am',
    ),
    ChatMessage(
      text: 'Saya mungkin sedikit terlambat karena jalanan macet',
      isFromMe: false,
      timestamp: '1:45 Am',
    ),
    ChatMessage(
      text: 'ASAP',
      isFromMe: true,
      timestamp: '1:46 Am',
      isSpecial: true,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
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
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0xFFF0F0F0),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Row(
          children: [
            // Avatar kurir
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF4B7BF5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Maya',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'WushShip Bandar Lampung',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Quick responses
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickResponse('ASAP', isSelected: true),
                  const SizedBox(width: 8),
                  _buildQuickResponse('OK'),
                  const SizedBox(width: 8),
                  _buildQuickResponse('Terima kasih'),
                  const SizedBox(width: 8),
                  _buildQuickResponse('Baik'),
                  const SizedBox(width: 8),
                  _buildQuickResponse('Siap'),
                  const SizedBox(width: 8),
                  _buildQuickResponse('Mengerti'),
                ],
              ),
            ),
          ),

          // Message input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              children: [
                // Attachment button
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.attach_file,
                        color: Colors.grey, size: 20),
                    onPressed: () {
                      // Handle attachment
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // Message input field
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                              hintText: 'Type Your message',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.emoji_emotions_outlined,
                              color: Colors.grey, size: 20),
                          onPressed: () {
                            // Handle emoji
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Send button
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4B7BF5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: () {
                      _sendMessage();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: message.isFromMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          // Special ASAP message
          if (message.isSpecial) ...[
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.4,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF4B7BF5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF4B7BF5), width: 2),
              ),
              child: const Text(
                'ASAP',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4B7BF5),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ] else ...[
            // Regular message
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: message.isFromMe
                    ? const Color(0xFF4B7BF5).withOpacity(0.1)
                    : const Color(0xFFF5E6D3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message.text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text(
            message.timestamp,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickResponse(String text, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        _sendQuickResponse(text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4B7BF5) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF4B7BF5) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: _messageController.text.trim(),
            isFromMe: true,
            timestamp: _getCurrentTime(),
          ),
        );
      });
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _sendQuickResponse(String text) {
    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isFromMe: true,
          timestamp: _getCurrentTime(),
          isSpecial: text == 'ASAP',
        ),
      );
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}

class ChatMessage {
  final String text;
  final bool isFromMe;
  final String timestamp;
  final bool isSpecial;

  ChatMessage({
    required this.text,
    required this.isFromMe,
    required this.timestamp,
    this.isSpecial = false,
  });
}
