enum OrderStatus {
  processing('Dalam Proses'),
  shipping('Dalam Perjalanan'),
  delivered('Selesai'),
  cancelled('Dibatalkan');

  const OrderStatus(this.displayName);
  final String displayName;
}

class OrderItem {
  final String id;
  final String trackingNumber;
  final String date;
  final OrderStatus status;
  final String route;
  final String serviceType;
  final String price;
  final String estimatedArrival;
  final List<TrackingHistory> trackingHistory;

  const OrderItem({
    required this.id,
    required this.trackingNumber,
    required this.date,
    required this.status,
    required this.route,
    required this.serviceType,
    required this.price,
    required this.estimatedArrival,
    required this.trackingHistory,
  });

  // Copy with method for immutability
  OrderItem copyWith({
    String? id,
    String? trackingNumber,
    String? date,
    OrderStatus? status,
    String? route,
    String? serviceType,
    String? price,
    String? estimatedArrival,
    List<TrackingHistory>? trackingHistory,
  }) {
    return OrderItem(
      id: id ?? this.id,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      date: date ?? this.date,
      status: status ?? this.status,
      route: route ?? this.route,
      serviceType: serviceType ?? this.serviceType,
      price: price ?? this.price,
      estimatedArrival: estimatedArrival ?? this.estimatedArrival,
      trackingHistory: trackingHistory ?? this.trackingHistory,
    );
  }
}

class TrackingHistory {
  final String description;
  final String dateTime;
  final bool isCompleted;

  const TrackingHistory({
    required this.description,
    required this.dateTime,
    required this.isCompleted,
  });
}
