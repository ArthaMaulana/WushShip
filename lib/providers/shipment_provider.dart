import 'package:flutter/foundation.dart';
import '../models/shipment_model.dart';

class ShipmentProvider with ChangeNotifier {
  ShipmentModel? _currentShipment;
  bool _isLoading = false;
  String? _errorMessage;

  ShipmentModel? get currentShipment => _currentShipment;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> trackShipment(String trackingNumber) async {
    if (trackingNumber.isEmpty) {
      _errorMessage = 'Masukkan nomor pelacakan yang valid';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Simulate API call with delay
    await Future.delayed(const Duration(seconds: 1));

    try {
      // Mock data - in a real app, this would come from an API
      _currentShipment = ShipmentModel(
        trackingNumber: trackingNumber,
        status: 'Dalam Pengiriman',
        origin: 'Jakarta',
        destination: 'Surabaya',
        estimatedArrival: DateTime.now().add(const Duration(days: 2)),
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Gagal melacak kiriman. Silakan coba lagi.';
      notifyListeners();
    }
  }

  void clearTracking() {
    _currentShipment = null;
    _errorMessage = null;
    notifyListeners();
  }
}
