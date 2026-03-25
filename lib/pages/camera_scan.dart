import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:warden_app/api/auth.dart';
// Import your service file here
// import 'package:your_app/services/api_service.dart'; 

class CameraScan extends StatefulWidget {
  const CameraScan({super.key});

  @override
  State<CameraScan> createState() => _CameraScanState();
}

class _CameraScanState extends State<CameraScan> {
  // 1. Initialize your service
  final AuthService _service = AuthService(); 
  final MobileScannerController controller = MobileScannerController();
  
  bool isProcessing = false;

  void _handleOnDetect(BarcodeCapture capture) async {
    final List<Barcode> barcodes = capture.barcodes;

    if (barcodes.isNotEmpty && !isProcessing) {
      setState(() => isProcessing = true);

      final String code = barcodes.first.rawValue ?? "Unknown";
  print("BOOOOOOOOOOOOOOOOOOOOOOOKKKKKKKKKKKKK REF $code");
  final Map<String, dynamic> parsedQr = jsonDecode(code);
  print(parsedQr['ref']);
      final (data, isSuccessful) = await _service.verifyBooking(parsedQr['ref']);

      if (!mounted) return;

      if (isSuccessful) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Verification Successful: ${data?['bookingRef']}"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        // Show error feedback
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Verification Failed. Invalid QR."),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      // Small cooldown before allowing the next scan
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        setState(() => isProcessing = false);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR Code")),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: _handleOnDetect,
          ),
          // Visual overlay for the scanner
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isProcessing ? Colors.orange : Colors.white, 
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          if (isProcessing)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}