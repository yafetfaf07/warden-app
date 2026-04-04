import 'package:flutter/material.dart';

class RecentCheckoutComponents extends StatelessWidget {
  const RecentCheckoutComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Text("ABC-123"),
          ),
          SizedBox(
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Row(
                    spacing: 5,
                    children: [
                      Text(
                        "Details",
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Icon(Icons.details, color: Colors.blue.shade700),
                    ],
                  ),
                ),

          TextButton(
            onPressed: () {},
            child: Row(
              spacing: 5,
              children: [
                Text(
                  "Checkout",
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Icon(Icons.qr_code, color: Colors.blue.shade700),
              ],
            ),
          )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
