import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warden_app/api/auth.dart';

class ParkingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
   ParkingAppBar({super.key, required this.username});
AuthService _service = AuthService();
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
              child: const Icon(
                Icons.person,
                color: Color(0xFF1A1F36),
                size: 30,
              ),
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
                  "Officer $username",
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
            IconButton(onPressed: () async{
              final isSuccess = await _service.logout();
              Navigator.of(context).pop();
            }, icon: Icon(Icons.logout)),

            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
