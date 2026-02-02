import 'package:flutter/material.dart';

class ParkingDetailedCard extends StatelessWidget {
  final String title;
  final int spots;
  const ParkingDetailedCard({
    super.key,
    required this.title,
    required this.spots,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      width: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(title),
          Row(
            children: [
              Text(
                spots.toString(),
                style: TextStyle(
                  color: title == "Available"
                      ? Colors.green
                      : title == "Occupied"
                      ? Colors.red
                      : Colors.purple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("spots", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
