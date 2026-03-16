import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:warden_app/components/app_bar.dart';
import 'package:warden_app/components/assigned_areas_card.dart';
import 'package:warden_app/components/card_display.dart';
import 'package:warden_app/pages/camera_scan.dart';
import 'package:warden_app/pages/report_page.dart';
import 'package:warden_app/pages/walkin_page.dart';

class Dashboard extends StatefulWidget {
  final dynamic id;
  const Dashboard({super.key, required this.id});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [HomeView(),ReportPage(), WalkinPage()];
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: "Report"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Walkin"),
        ],
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraScan()));
        },
        child: Icon(Icons.qr_code),
      ),
      appBar: ParkingAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        
          child: Column(
            children: [
              Text(
                "Current Shift",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text("Duty started at 8:00", style: TextStyle(color: Colors.grey)),
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
              const SizedBox(height: 30),
              SizedBox(
                height: 450,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return AssignedAreasCard();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

