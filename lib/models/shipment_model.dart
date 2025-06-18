class ShipmentModel {
  final String trackingNumber;
  final String status;
  final String origin;
  final String destination;
  final DateTime estimatedArrival;

  ShipmentModel({
    required this.trackingNumber,
    required this.status,
    required this.origin,
    required this.destination,
    required this.estimatedArrival,
  });
}
