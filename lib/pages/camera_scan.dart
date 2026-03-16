
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraScan extends StatefulWidget {
  const CameraScan({super.key});

  @override
  State<CameraScan> createState() => _CameraScanState();
}

class _CameraScanState extends State<CameraScan> {
  bool isPathFound = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan QR code ")),
      body: MobileScanner(
        controller: MobileScannerController(),
   onDetect: (capture) {
  final List<Barcode> barcodes = capture.barcodes;
  
  if (barcodes.isNotEmpty && !isPathFound) {
    isPathFound = true; // 2. Lock the detector immediately
    
    final String code = barcodes.first.rawValue ?? "Unknown";
    print("Barcode found: $code");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(code),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                isPathFound = false; // 3. Unlock when dialog is closed
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    ).then((_) => isPathFound = false); // Safety reset
  }
},
      ),
    );
  }
}
