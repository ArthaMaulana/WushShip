import 'package:flutter/material.dart';

import '../../models/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderItem order;
  final VoidCallback onDetailTap;
  final VoidCallback onTrackTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.onDetailTap,
    required this.onTrackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildRouteInfo(),
            const SizedBox(height: 16),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.trackingNumber,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                order.date,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8F9BB3),
                ),
              ),
            ],
          ),
        ),
        _buildStatusChip(),
      ],
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        order.status.displayName,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _getStatusColor(),
        ),
      ),
    );
  }

  Widget _buildRouteInfo() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4B7BF5).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.local_shipping_outlined,
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
                order.route,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3142),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                order.serviceType,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8F9BB3),
                ),
              ),
            ],
          ),
        ),
        Text(
          order.price,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4B7BF5),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onDetailTap,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF4B7BF5)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text(
              'Detail',
              style: TextStyle(
                color: Color(0xFF4B7BF5),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onTrackTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4B7BF5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              elevation: 0,
            ),
            child: const Text(
              'Lacak',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (order.status) {
      case OrderStatus.processing:
        return const Color(0xFF4B7BF5);
      case OrderStatus.shipping:
        return const Color(0xFFFF9800);
      case OrderStatus.delivered:
        return const Color(0xFF00C896);
      case OrderStatus.cancelled:
        return const Color(0xFFFF5252);
    }
  }
}
