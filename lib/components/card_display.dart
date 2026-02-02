import 'package:flutter/material.dart';

class CardDisplay extends StatelessWidget {
  final String title;
  final Icon icon;
  const CardDisplay({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          Row(children: [icon, Text(title)]),
          Row(
            children: [
              Text(
                "06:42 ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text("HRS", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
