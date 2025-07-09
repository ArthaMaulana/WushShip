import 'package:flutter/material.dart';

import '../../models/order_model.dart';

class OrderDetailSheet extends StatelessWidget {
  final OrderItem order;

  const OrderDetailSheet({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          _buildHandle(),
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderDetails(),
                  const SizedBox(height: 20),
                  _buildTrackingSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Detail Pesanan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3142),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.close,
                color: Color(0xFF8F9BB3),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailItem('Nomor Resi', order.trackingNumber),
        _buildDetailItem('Tanggal Order', order.date),
        _buildDetailItem('Status', order.status.displayName),
        _buildDetailItem('Rute', order.route),
        _buildDetailItem('Layanan', order.serviceType),
        _buildDetailItem('Harga', order.price),
        _buildDetailItem('Estimasi Tiba', order.estimatedArrival),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF8F9BB3),
              ),
            ),
          ),
          const Text(': ', style: TextStyle(color: Color(0xFF8F9BB3))),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3142),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tracking History',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3142),
          ),
        ),
        const SizedBox(height: 12),
        ...order.trackingHistory.map((history) => _buildTrackingItem(history)),
      ],
    );
  }

  Widget _buildTrackingItem(TrackingHistory history) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: history.isCompleted
                  ? const Color(0xFF00C896)
                  : const Color(0xFF8F9BB3),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  history.description,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: history.isCompleted
                        ? const Color(0xFF2D3142)
                        : const Color(0xFF8F9BB3),
                  ),
                ),
                if (history.dateTime.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    history.dateTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8F9BB3),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
