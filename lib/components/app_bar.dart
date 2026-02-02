import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParkingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ParkingAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80); // Slightly taller for better spacing

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false, // Removes default back button if any
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: [
            // 1. Profile Avatar (Using Icon as requested)
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.person, color: Color(0xFF1A1F36), size: 30),
            ),
            const SizedBox(width: 12),

            // 2. User Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Active Duty",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.blueGrey[400],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Officer Marcus",
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: const Color(0xFF1A1F36),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),

            // 3. Online Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9), // Light green
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.wifi, size: 16, color: Color(0xFF2E7D32)),
                  const SizedBox(width: 6),
                  Text(
                    "ONLINE",
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

            // 4. Notification Bell
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    color: Color(0xFF1A1F36),
                    size: 24,
                  ),
                ),
                // Red Dot Indicator
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}