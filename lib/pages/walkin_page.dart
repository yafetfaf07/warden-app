import 'package:flutter/material.dart';
import 'package:warden_app/api/auth.dart';
import 'package:warden_app/components/recent_checkout_components.dart';

class WalkinPage extends StatefulWidget {
  final String id;

  const WalkinPage({super.key, required this.id});

  @override
  State<WalkinPage> createState() => _WalkinPageState();
}

class _WalkinPageState extends State<WalkinPage> {
  final AuthService _service = AuthService();
  String parkingId = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final (name, isSuccessful) = await _service.getProfile(widget.id);

      setState(() {
        if (isSuccessful && name != null) {
          parkingId = name.parkingAvenueId;
        } else if (name == null) {
          parkingId = "Unknown";
        }
      });
    });
  }

  final TextEditingController licenseController = TextEditingController();

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Walk-in Registry"), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: const BoxConstraints(maxWidth: 420),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Add Walk-in details",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const SizedBox(height: 16),

                    // License Number
                    TextField(
                      controller: licenseController,
                      decoration: _inputDecoration("License No", "AA-12345"),
                    ),
                    const SizedBox(height: 24),

                    // Button
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          final (vehicleSession, isSuccess) = await _service
                              .checkin((licenseController.text), parkingId);
                          if (vehicleSession != null && isSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Checkin-successful"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else if (vehicleSession == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Checkin-failed"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Add Vehicle",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      "Recent Checkouts",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return RecentCheckoutComponents();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
