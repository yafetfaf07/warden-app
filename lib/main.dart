import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:warden_app/pages/dashboard_page.dart';
import 'package:warden_app/pages/login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 Future<Widget> _getInitialPage() async {
    const storage = FlutterSecureStorage();
    final String? refreshToken = await storage.read(key: 'token');
    if (refreshToken != null && !JwtDecoder.isExpired(refreshToken)) {
      print("TOKEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEENNNNNNNN: $refreshToken");
      return Dashboard(id: refreshToken);
    } else {
      // Token is missing or expired
      return  Login();
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade200),

        textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme),
      ),
        home: FutureBuilder<Widget>(
        future: _getInitialPage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            // Handle errors (e.g., storage read issues)
            return const Scaffold(
              body: Center(child: Text('Error checking authentication')),
            );
          }
          return snapshot.data ?? Login();
        },
      ),
    );
  }
}
