import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Custom painter untuk dotted line
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double dashWidth = 4.0;
    const double dashSpace = 3.0;
    double startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter untuk efek lekukan tiket
class TicketPainter extends CustomPainter {
  final bool isTop;

  TicketPainter({required this.isTop});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF8F9FA)
      ..style = PaintingStyle.fill;

    // Shadow paint
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final path = Path();
    final shadowPath = Path();
    const radius = 12.0;
    const notchRadius = 8.0;
    const notchPosition = 0.5; // Middle position

    // Calculate notch positions
    final notchX = size.width * notchPosition;

    if (isTop) {
      // Top section (Pengirim) - notches at bottom

      // Shadow path
      shadowPath.moveTo(radius, 2);
      shadowPath.lineTo(size.width - radius, 2);
      shadowPath.arcToPoint(Offset(size.width, radius + 2),
          radius: const Radius.circular(radius));
      shadowPath.lineTo(size.width, size.height - notchRadius + 2);

      // Right notch (shadow)
      shadowPath.arcToPoint(
        Offset(size.width - notchRadius, size.height + 2),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      );
      shadowPath.lineTo(notchX + notchRadius, size.height + 2);

      // Center notch (shadow)
      shadowPath.arcToPoint(
        Offset(notchX - notchRadius, size.height + 2),
        radius: const Radius.circular(notchRadius),
        clockwise: true,
      );
      shadowPath.lineTo(notchRadius, size.height + 2);

      // Left notch (shadow)
      shadowPath.arcToPoint(
        Offset(0, size.height - notchRadius + 2),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      );
      shadowPath.lineTo(0, radius + 2);
      shadowPath.arcToPoint(Offset(radius, 2),
          radius: const Radius.circular(radius));
      shadowPath.close();

      // Main path
      path.moveTo(radius, 0);
      path.lineTo(size.width - radius, 0);
      path.arcToPoint(Offset(size.width, radius),
          radius: const Radius.circular(radius));
      path.lineTo(size.width, size.height - notchRadius);

      // Right notch
      path.arcToPoint(
        Offset(size.width - notchRadius, size.height),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      );
      path.lineTo(notchX + notchRadius, size.height);

      // Center notch
      path.arcToPoint(
        Offset(notchX - notchRadius, size.height),
        radius: const Radius.circular(notchRadius),
        clockwise: true,
      );
      path.lineTo(notchRadius, size.height);

      // Left notch
      path.arcToPoint(
        Offset(0, size.height - notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      );
      path.lineTo(0, radius);
      path.arcToPoint(Offset(radius, 0), radius: const Radius.circular(radius));
      path.close();
    } else {
      // Bottom section (Penerima) - notches at top

      // Shadow path
      shadowPath.moveTo(0, notchRadius + 2);
      shadowPath.arcToPoint(
        Offset(notchRadius, 2),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      );
      shadowPath.lineTo(notchX - notchRadius, 2);

      // Center notch (shadow)
      shadowPath.arcToPoint(
        Offset(notchX + notchRadius, 2),
        radius: const Radius.circular(notchRadius),
        clockwise: true,
      );
      shadowPath.lineTo(size.width - notchRadius, 2);

      // Right notch (shadow)
      shadowPath.arcToPoint(
        Offset(size.width, notchRadius + 2),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      );
      shadowPath.lineTo(size.width, size.height - radius + 2);
      shadowPath.arcToPoint(Offset(size.width - radius, size.height + 2),
          radius: const Radius.circular(radius));
      shadowPath.lineTo(radius, size.height + 2);
      shadowPath.arcToPoint(Offset(0, size.height - radius + 2),
          radius: const Radius.circular(radius));
      shadowPath.close();

      // Main path
      path.moveTo(0, notchRadius);
      path.arcToPoint(
        Offset(notchRadius, 0),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      );
      path.lineTo(notchX - notchRadius, 0);

      // Center notch
      path.arcToPoint(
        Offset(notchX + notchRadius, 0),
        radius: const Radius.circular(notchRadius),
        clockwise: true,
      );
      path.lineTo(size.width - notchRadius, 0);

      // Right notch
      path.arcToPoint(
        Offset(size.width, notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      );
      path.lineTo(size.width, size.height - radius);
      path.arcToPoint(Offset(size.width - radius, size.height),
          radius: const Radius.circular(radius));
      path.lineTo(radius, size.height);
      path.arcToPoint(Offset(0, size.height - radius),
          radius: const Radius.circular(radius));
      path.close();
    }

    // Draw shadow
    canvas.drawPath(shadowPath, shadowPaint);

    // Draw main shape
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _statusTabController;
  int _currentStatusIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _statusTabController = TabController(length: 4, vsync: this);

    _statusTabController.addListener(() {
      if (_statusTabController.indexIsChanging) {
        setState(() {
          _currentStatusIndex = _statusTabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _statusTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        children: [
          _buildHeader(),
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              _buildAppBar(),
              const SizedBox(height: 24),
              _buildCategoryTabs(),
              const SizedBox(height: 20),
              _buildStatusFilters(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Riwayat Paket',
          style: TextStyle(
            color: Color(0xFF2D3142),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(22),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF4B7BF5),
          borderRadius: BorderRadius.circular(19),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF6B7280),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(text: 'For Me'),
          Tab(text: 'From Me'),
        ],
      ),
    );
  }

  Widget _buildStatusFilters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildStatusFilterChip('All (100)', 0),
        const SizedBox(width: 32),
        _buildStatusFilterChip('Pending', 1),
        const SizedBox(width: 32),
        _buildStatusFilterChip('On Progress', 2),
        const SizedBox(width: 32),
        Expanded(
          child: _buildStatusFilterChip('Delivered', 3),
        ),
      ],
    );
  }

  Widget _buildStatusFilterChip(String text, int index) {
    bool isSelected = index == _currentStatusIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentStatusIndex = index;
          _statusTabController.animateTo(index);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color:
                isSelected ? const Color(0xFF4B7BF5) : const Color(0xFF9CA3AF),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildStatusTabView(), // For Me
          _buildStatusTabView(), // From Me
        ],
      ),
    );
  }

  Widget _buildStatusTabView() {
    return TabBarView(
      controller: _statusTabController,
      children: [
        _buildOrderList('all'),
        _buildOrderList('pending'),
        _buildOrderList('progress'),
        _buildOrderList('delivered'),
      ],
    );
  }

  Widget _buildOrderList(String type) {
    final orders = _getOrdersByType(type);

    if (orders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF4B7BF5).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.inbox_outlined,
                  size: 64,
                  color: const Color(0xFF4B7BF5).withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                type == 'forme'
                    ? 'Belum ada paket untuk Anda'
                    : type == 'fromme'
                        ? 'Belum ada paket dari Anda'
                        : 'Belum ada riwayat paket',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF2D3142),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Paket yang Anda kirim atau terima akan muncul di sini',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return GestureDetector(
      onTap: () => _showOrderDetailSheet(order),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon, order info, and price + status
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: order['iconColor'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    order['icon'],
                    color: order['iconColor'],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['type'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        order['orderId'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        order['subtitle'] ?? order['type'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      order['price'],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      child: Text(
                        order['statusText'],
                        style: TextStyle(
                          color: _getStatusTextColor(order['status']),
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Dotted separator line
            SizedBox(
              height: 1,
              width: double.infinity,
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),

            const SizedBox(height: 12),

            // Date and locations with arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['date'],
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order['from'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF1F2937),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF9CA3AF),
                    size: 14,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      order['date'],
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order['to'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF1F2937),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Bottom status text with background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                _getStatusBottomText(order['status']),
                style: TextStyle(
                  fontSize: 11,
                  color: _getStatusTextColor(order['status']),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'complete':
      case 'delivered':
        return const Color(0xFF059669); // Green
      case 'progress':
      case 'shipping':
        return const Color(0xFF2563EB); // Blue
      case 'pending':
      case 'processing':
        return const Color(0xFFDC2626); // Red/Orange
      default:
        return const Color(0xFF6B7280);
    }
  }

  String _getStatusBottomText(String status) {
    switch (status) {
      case 'complete':
      case 'delivered':
        return 'Completed';
      case 'progress':
      case 'shipping':
        return 'On Proggress';
      case 'pending':
      case 'processing':
        return 'Pending';
      default:
        return 'Status tidak diketahui';
    }
  }

  List<Map<String, dynamic>> _getOrdersByType(String type) {
    final allOrders = [
      {
        'orderId': 'Order No.#109NK',
        'type': 'Electronic Packing',
        'date': 'Sep 22,2024',
        'status': 'progress',
        'statusText': 'Standard',
        'from': 'Lampung, ID',
        'to': 'Jakarta, ID',
        'price': 'Rp 50.000',
        'subtitle': 'Electronic',
        'icon': Icons.devices,
        'iconColor': const Color(0xFF4B7BF5),
        'category': 'forme',
      },
      {
        'orderId': 'Order No.#109NK',
        'type': 'Food Packing',
        'date': 'Sep 22,2024',
        'status': 'pending',
        'statusText': 'Same Day',
        'from': 'Lampung, ID',
        'to': 'Jakarta, ID',
        'price': 'Rp 50.000',
        'subtitle': 'food and drinks',
        'icon': Icons.restaurant,
        'iconColor': const Color(0xFFFF6B35),
        'category': 'fromme',
      },
      {
        'orderId': 'Order No.#109NK',
        'type': 'Document Packing',
        'date': 'Sep 22,2024',
        'status': 'complete',
        'statusText': 'Express',
        'from': 'Lampung, ID',
        'to': 'Jakarta, ID',
        'price': 'Rp 50.000',
        'subtitle': 'Document',
        'icon': Icons.description,
        'iconColor': const Color(0xFF8E44AD),
        'category': 'forme',
      },
      {
        'orderId': 'Order No.#109NK',
        'type': 'Cosmetic Packing',
        'date': 'Sep 28,2024',
        'status': 'complete',
        'statusText': 'Complete',
        'from': 'Jakarta, ID',
        'to': 'Medan, ID',
        'price': 'Rp 50.000',
        'subtitle': 'Cosmetic',
        'icon': Icons.face_retouching_natural,
        'iconColor': const Color(0xFFE91E63),
        'category': 'fromme',
      },
      {
        'orderId': 'Order No.#110NK',
        'type': 'Electronic Packing',
        'date': 'Sep 25,2024',
        'status': 'progress',
        'statusText': 'On Progress',
        'from': 'Bandung, ID',
        'to': 'Surabaya, ID',
        'price': 'Rp 75.000',
        'subtitle': 'Electronic',
        'icon': Icons.devices,
        'iconColor': const Color(0xFF4B7BF5),
        'category': 'forme',
      },
      {
        'orderId': 'Order No.#111NK',
        'type': 'Food Packing',
        'date': 'Sep 26,2024',
        'status': 'pending',
        'statusText': 'Pending',
        'from': 'Yogyakarta',
        'to': 'Bali, ID',
        'price': 'Rp 95.000',
        'subtitle': 'food and drinks',
        'icon': Icons.restaurant,
        'iconColor': const Color(0xFFFF9500),
        'category': 'fromme',
      },
      {
        'orderId': 'Order No.#112NK',
        'type': 'Document Packing',
        'date': 'Sep 27,2024',
        'status': 'delivered',
        'statusText': 'Delivered',
        'from': 'Semarang',
        'to': 'Makassar, ID',
        'price': 'Rp 65.000',
        'subtitle': 'Document',
        'icon': Icons.description,
        'iconColor': const Color(0xFF8E44AD),
        'category': 'forme',
      },
      {
        'orderId': 'Order No.#113NK',
        'type': 'Cosmetic Packing',
        'date': 'Sep 28,2024',
        'status': 'delivered',
        'statusText': 'Delivered',
        'from': 'Denpasar',
        'to': 'Lombok, ID',
        'price': 'Rp 85.000',
        'subtitle': 'Cosmetic',
        'icon': Icons.face_retouching_natural,
        'iconColor': const Color(0xFFE91E63),
        'category': 'fromme',
      },
    ];

    // Filter berdasarkan kategori atau status
    if (type == 'all') {
      return allOrders;
    }
    if (type == 'forme') {
      return allOrders.where((order) => order['category'] == 'forme').toList();
    }
    if (type == 'fromme') {
      return allOrders.where((order) => order['category'] == 'fromme').toList();
    }
    if (type == 'pending') {
      return allOrders.where((order) => order['status'] == 'pending').toList();
    }
    if (type == 'progress') {
      return allOrders.where((order) => order['status'] == 'progress').toList();
    }
    if (type == 'delivered') {
      return allOrders
          .where((order) =>
              order['status'] == 'delivered' || order['status'] == 'complete')
          .toList();
    }

    return allOrders;
  }

  void _showOrderDetailSheet(Map<String, dynamic> order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _DetailPaketScreen(order: order),
      ),
    );
  }
}

// Detail Paket Screen sesuai dengan desain Figma
class _DetailPaketScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const _DetailPaketScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3142)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Paket',
          style: TextStyle(
            color: Color(0xFF2D3142),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status Pengiriman',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4B7BF5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order['statusText'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Resi Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resi Barang',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '268393ecbwr3678',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4B7BF5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy,
                            color: Color(0xFF4B7BF5), size: 20),
                        onPressed: () {
                          // Copy to clipboard functionality
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Barcode section
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: CustomPaint(
                        size: const Size(200, 40),
                        painter: BarcodePainter(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Cetak Resi Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Print receipt functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B7BF5),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cetak Resi',
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

            const SizedBox(height: 24),

            // Dotted line separator
            SizedBox(
              height: 1,
              width: double.infinity,
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),

            const SizedBox(height: 24),

            // Pengirim Section
            _buildTicketSection(
              title: 'Pengirim',
              name: 'Muhammad Rakha Ramadhan',
              phone: '089876660xxx',
              area: 'Menggala,Tulang Bawang,Lampung,Indonesia',
              address: 'Jalan 1 kali ujung,No.39',
              isTop: true,
            ),

            const SizedBox(height: 0),

            // Penerima Section
            _buildTicketSection(
              title: 'Penerima',
              name: 'Artha maulana rahman',
              phone: '089876660xxx',
              area: order['to'],
              address: null,
              isTop: false,
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketSection({
    required String title,
    required String name,
    required String phone,
    required String area,
    String? address,
    required bool isTop,
  }) {
    return CustomPaint(
      painter: TicketPainter(isTop: isTop),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF4B7BF5),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'No.Handphone',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              phone,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2D3142),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Area Penjemputan',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              area,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2D3142),
                fontWeight: FontWeight.w600,
              ),
            ),
            if (address != null) ...[
              const SizedBox(height: 8),
              const Text(
                'Alamat',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                address,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2D3142),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Custom painter untuk barcode
class BarcodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Generate barcode pattern
    final barWidths = [
      3,
      1,
      2,
      1,
      3,
      2,
      1,
      3,
      2,
      1,
      3,
      1,
      2,
      1,
      3,
      2,
      1,
      3,
      2,
      1,
      3,
      1,
      2,
      1,
      3
    ];
    double currentX = 0;

    for (int i = 0; i < barWidths.length; i++) {
      if (i % 2 == 0) {
        // Draw bars for even indices
        final barWidth = barWidths[i].toDouble() * 2;
        canvas.drawRect(
          Rect.fromLTWH(currentX, 0, barWidth, size.height),
          paint,
        );
      }
      currentX += barWidths[i].toDouble() * 2;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
