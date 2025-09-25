import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final String status; // e.g., 'Hijau', 'Kuning', 'Merah'

  const StatusIndicator({super.key, required this.status});

  Color _getColor() {
    switch (status.toLowerCase()) {
      case 'hijau':
        return Colors.green;
      case 'kuning':
        return Colors.yellow;
      case 'merah':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        "Status Gizi: $status",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
