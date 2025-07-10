import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/courier/courier_bottom_nav_bar.dart';
import 'courier_chat_screen.dart';
import 'courier_dashboard_screen.dart';
import 'courier_profile_screen.dart';

class CourierMyOrderScreen extends StatefulWidget {
  const CourierMyOrderScreen({super.key});

  @override
  State<CourierMyOrderScreen> createState() => _CourierMyOrderScreenState();
}

class _CourierMyOrderScreenState extends State<CourierMyOrderScreen> {
  int _selectedTabIndex = 0;

  // Sample data for courier orders
  final List<Map<String, dynamic>> _courierOrders = [
    {
      'id': 'WS001',
      'customerName': 'Muhammad Rakha R',
      'customerPhone': '081234567890',
      'address': 'JL.1 Kampung baru no.423',
      'status': 'Dalam Perjalanan',
      'statusColor': Colors.blue,
      'orderType': 'COD',
      'amount': 'Rp 150.000',
      'items': 'Paket Elektronik',
      'estimatedTime': '30 menit',
      'priority': 'Normal',
      'distance': '2.5 km',
    },
    {
      'id': 'WS002',
      'customerName': 'Artha Maulana',
      'customerPhone': '081234567891',
      'address': 'JL.1 Kampung baru no.1000',
      'status': 'Menunggu Pickup',
      'statusColor': Colors.orange,
      'orderType': 'Non COD',
      'amount': 'Rp 75.000',
      'items': 'Paket Pakaian',
      'estimatedTime': '45 menit',
      'priority': 'Urgent',
      'distance': '1.2 km',
    },
    {
      'id': 'WS003',
      'customerName': 'Angga Ramadhan',
      'customerPhone': '081234567892',
      'address': 'JL.1 Kampung baru no.2',
      'status': 'Selesai',
      'statusColor': Colors.green,
      'orderType': 'COD',
      'amount': 'Rp 200.000',
      'items': 'Paket Makanan',
      'estimatedTime': 'Selesai',
      'priority': 'Normal',
      'distance': '3.1 km',
    },
    {
      'id': 'WS004',
      'customerName': 'Siti Nurhaliza',
      'customerPhone': '081234567893',
      'address': 'JL.2 Kampung lama no.15',
      'status': 'Dibatalkan',
      'statusColor': Colors.red,
      'orderType': 'Non COD',
      'amount': 'Rp 100.000',
      'items': 'Paket Kosmetik',
      'estimatedTime': 'Dibatalkan',
      'priority': 'Normal',
      'distance': '4.0 km',
    },
  ];

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
        title: const Text(
          'Pesanan Kurir',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Tab selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                _buildTabButton('Semua', 0),
                const SizedBox(width: 16),
                _buildTabButton('Aktif', 1),
                const SizedBox(width: 16),
                _buildTabButton('Selesai', 2),
                const SizedBox(width: 16),
                _buildTabButton('Dibatalkan', 3),
              ],
            ),
          ),
          const Divider(height: 1),

          // Filter section
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari berdasarkan ID atau nama...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4B7BF5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Order list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _getFilteredOrders().length,
              itemBuilder: (context, index) {
                final order = _getFilteredOrders()[index];
                return _buildOrderCard(order);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CourierBottomNavBar(
        currentIndex: 1, // MyOrder is at index 1
        onTap: (index) {
          // Navigate to different screens based on bottom nav selection
          if (index == 0) {
            // Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CourierDashboardScreen()),
            );
          } else if (index == 2) {
            // Chat
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CourierChatScreen()),
            );
          } else if (index == 3) {
            // Profile
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CourierProfileScreen()),
            );
          }
          // index == 1 (MyOrder) - stay on current screen
        },
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4B7BF5) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? null
              : Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredOrders() {
    switch (_selectedTabIndex) {
      case 1: // Aktif
        return _courierOrders
            .where((order) =>
                order['status'] == 'Dalam Perjalanan' ||
                order['status'] == 'Menunggu Pickup')
            .toList();
      case 2: // Selesai
        return _courierOrders
            .where((order) => order['status'] == 'Selesai')
            .toList();
      case 3: // Dibatalkan
        return _courierOrders
            .where((order) => order['status'] == 'Dibatalkan')
            .toList();
      default: // Semua
        return _courierOrders;
    }
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with order ID and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4B7BF5).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      order['id'],
                      style: const TextStyle(
                        color: Color(0xFF4B7BF5),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (order['priority'] == 'Urgent')
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'URGENT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: order['statusColor'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  order['status'],
                  style: TextStyle(
                    color: order['statusColor'],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Customer info
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B7BF5).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF4B7BF5),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['customerName'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      order['customerPhone'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // Call button
              GestureDetector(
                onTap: () {
                  // Make phone call
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Menelepon ${order['customerName']}...'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Address
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  order['address'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Items and amount
          Row(
            children: [
              const Icon(
                Icons.inventory_2,
                color: Colors.orange,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  order['items'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text(
                order['amount'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4B7BF5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Distance and time
          Row(
            children: [
              const Icon(
                Icons.directions,
                color: Colors.blue,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                order['distance'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.access_time,
                color: Colors.purple,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                order['estimatedTime'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: order['orderType'] == 'COD'
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  order['orderType'],
                  style: TextStyle(
                    color: order['orderType'] == 'COD'
                        ? Colors.green
                        : Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Action buttons
          if (order['status'] == 'Menunggu Pickup' ||
              order['status'] == 'Dalam Perjalanan')
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showOrderActionDialog(order);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B7BF5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      order['status'] == 'Menunggu Pickup'
                          ? 'Pickup'
                          : 'Selesaikan',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _showNavigationDialog(order);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF4B7BF5),
                      side: const BorderSide(color: Color(0xFF4B7BF5)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Navigasi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _showOrderActionDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Konfirmasi ${order['status'] == 'Menunggu Pickup' ? 'Pickup' : 'Selesaikan'}'),
          content: Text(
              'Apakah Anda yakin ingin ${order['status'] == 'Menunggu Pickup' ? 'mengambil' : 'menyelesaikan'} pesanan ${order['id']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updateOrderStatus(order);
              },
              child: Text(
                order['status'] == 'Menunggu Pickup' ? 'Pickup' : 'Selesaikan',
                style: const TextStyle(color: Color(0xFF4B7BF5)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showNavigationDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Navigasi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tujuan: ${order['address']}'),
              const SizedBox(height: 8),
              Text('Jarak: ${order['distance']}'),
              const SizedBox(height: 8),
              Text('Estimasi: ${order['estimatedTime']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Membuka aplikasi navigasi...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                'Buka Maps',
                style: TextStyle(color: Color(0xFF4B7BF5)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateOrderStatus(Map<String, dynamic> order) {
    setState(() {
      if (order['status'] == 'Menunggu Pickup') {
        order['status'] = 'Dalam Perjalanan';
        order['statusColor'] = Colors.blue;
      } else if (order['status'] == 'Dalam Perjalanan') {
        order['status'] = 'Selesai';
        order['statusColor'] = Colors.green;
        order['estimatedTime'] = 'Selesai';
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Status pesanan ${order['id']} telah diperbarui'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
