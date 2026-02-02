import 'package:flutter/material.dart';

class AssignedAreasCard extends StatelessWidget {
  const AssignedAreasCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F2B), // Deep navy background
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Status Badge and Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusBadge(),
              const Row(
                children: [
                  Icon(Icons.access_time, color: Colors.grey, size: 18),
                  SizedBox(width: 6),
                  Text(
                    "JUST NOW",
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Title
          const Text(
            "Downtown Ave Seg A",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Address Row
          const Row(
            children: [
              Icon(Icons.location_on_outlined, color: Colors.grey, size: 18),
              SizedBox(width: 4),
              Text(
                "45 Downtown Ave",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Bottom Row: Type Tag and Open Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTypeTag(),
              Row(
                children: const [
                  Text(
                    "Open",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.chevron_right, color: Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for the "AVAILABLE" badge
  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2F3A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: const [
          Icon(Icons.circle, color: Colors.green, size: 10),
          SizedBox(width: 8),
          Text(
            "AVAILABLE",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Widget for the "ON-STREET" tag
  Widget _buildTypeTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF232935),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: const Text(
        "ON-STREET",
        style: TextStyle(
          color: Color(0xFF6391F2), // Light blue text color
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}