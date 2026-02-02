import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warden_app/components/app_bar.dart';
import 'package:warden_app/components/assigned_areas_card.dart';
import 'package:warden_app/components/card_display.dart';

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
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {

        }, child: Icon(Icons.qr_code),),
        appBar: ParkingAppBar(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),

          child: Column(
            children: [
              Text(
                "Current Shift",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "Duty started at 8:00",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CardDisplay(
                    title: "WORKED",
                    icon: Icon(Icons.timer_outlined, color: Colors.blue),
                  ),
                  CardDisplay(
                    title: "REVENUE",
                    icon: Icon(Icons.attach_money, color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              SizedBox(
                height: 450,
                child: ListView.builder(itemCount: 5,itemBuilder: (context, index) {
                  return AssignedAreasCard();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
