import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warden_app/pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: Dashboard()
    );
  }
}
