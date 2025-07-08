import '../models/order_model.dart';

class OrderService {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  // Simulasi data orders
  List<OrderItem> get allOrders => _mockOrders;

  List<OrderItem> getOrdersByStatus(OrderStatus status) {
    return _mockOrders.where((order) => order.status == status).toList();
  }

  List<OrderItem> getOrdersInProgress() {
    return _mockOrders.where((order) => 
      order.status == OrderStatus.processing || 
      order.status == OrderStatus.shipping
    ).toList();
  }

  List<OrderItem> getCompletedOrders() {
    return _mockOrders.where((order) => order.status == OrderStatus.delivered).toList();
  }

  OrderItem? getOrderById(String id) {
    try {
      return _mockOrders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }

  // Mock data untuk testing
  final List<OrderItem> _mockOrders = [
    OrderItem(
      id: '1',
      trackingNumber: 'WS-2024-001247',
      date: '15 Jan 2024',
      status: OrderStatus.delivered,
      route: 'Jakarta → Surabaya',
      serviceType: 'Regular',
      price: 'Rp 25.000',
      estimatedArrival: '17 Jan 2024',
      trackingHistory: [
        TrackingHistory(
          description: 'Paket diterima',
          dateTime: '15 Jan 2024, 10:00',
          isCompleted: true,
        ),
        TrackingHistory(
          description: 'Paket dalam perjalanan',
          dateTime: '15 Jan 2024, 14:00',
          isCompleted: true,
        ),
        TrackingHistory(
          description: 'Paket tiba di kota tujuan',
          dateTime: '16 Jan 2024, 08:00',
          isCompleted: true,
        ),
        TrackingHistory(
          description: 'Paket berhasil dikirim',
          dateTime: '17 Jan 2024, 11:00',
          isCompleted: true,
        ),
      ],
    ),
    OrderItem(
      id: '2',
      trackingNumber: 'WS-2024-001248',
      date: '18 Jan 2024',
      status: OrderStatus.shipping,
      route: 'Bandung → Medan',
      serviceType: 'Express',
      price: 'Rp 45.000',
      estimatedArrival: '20 Jan 2024',
      trackingHistory: [
        TrackingHistory(
          description: 'Paket diterima',
          dateTime: '18 Jan 2024, 09:00',
          isCompleted: true,
        ),
        TrackingHistory(
          description: 'Paket dalam perjalanan',
          dateTime: '18 Jan 2024, 15:00',
          isCompleted: true,
        ),
        TrackingHistory(
          description: 'Paket tiba di kota tujuan',
          dateTime: '19 Jan 2024, 12:00',
          isCompleted: false,
        ),
        TrackingHistory(
          description: 'Paket berhasil dikirim',
          dateTime: '',
          isCompleted: false,
        ),
      ],
    ),
    OrderItem(
      id: '3',
      trackingNumber: 'WS-2024-001249',
      date: '20 Jan 2024',
      status: OrderStatus.processing,
      route: 'Yogyakarta → Denpasar',
      serviceType: 'Regular',
      price: 'Rp 35.000',
      estimatedArrival: '23 Jan 2024',
      trackingHistory: [
        TrackingHistory(
          description: 'Paket diterima',
          dateTime: '20 Jan 2024, 08:00',
          isCompleted: true,
        ),
        TrackingHistory(
          description: 'Paket dalam perjalanan',
          dateTime: '',
          isCompleted: false,
        ),
        TrackingHistory(
          description: 'Paket tiba di kota tujuan',
          dateTime: '',
          isCompleted: false,
        ),
        TrackingHistory(
          description: 'Paket berhasil dikirim',
          dateTime: '',
          isCompleted: false,
        ),
      ],
    ),
  ];
}
