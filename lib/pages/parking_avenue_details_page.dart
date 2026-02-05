import 'package:flutter/material.dart';
import 'package:warden_app/components/parking_detailed_card.dart';

class ParkingAvenueDetails extends StatelessWidget {
  const ParkingAvenueDetails({super.key});
  static const List<String> _spots = [
    "A1",
    "A2",
    "A3",
    "A4",
    "B1",
    "B2",
    "B3",
    "B4",
    "C1",
    "C2",
    "C3",
    "C4",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("4 kilo parking area")),
      body: Column(
        spacing: 10,
        children: [
          // Text("Spot Details"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ParkingDetailedCard(title: "Available", spots: 4),
              ParkingDetailedCard(title: "Occupied", spots: 4),
              ParkingDetailedCard(title: "Reserved", spots: 4),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 340,
            child: GridView.builder(
              itemCount: _spots.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                if (index >= 0 && index <=3) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(_spots[index], style: TextStyle(color: Colors.white),),
                  );
                } else if (index >= 3 && index <= 7) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(_spots[index], style: TextStyle(color: Colors.white),),
                  );
                } else {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      
                      backgroundColor: Colors.purple.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(_spots[index], style: TextStyle(color: Colors.white),),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
