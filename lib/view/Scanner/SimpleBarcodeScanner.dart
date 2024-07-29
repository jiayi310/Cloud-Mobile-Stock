import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class SimpleBarcodeScannerPage extends StatefulWidget {
  const SimpleBarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _SimpleBarcodeScannerPageState createState() =>
      _SimpleBarcodeScannerPageState();
}

class _SimpleBarcodeScannerPageState extends State<SimpleBarcodeScannerPage> {
  String _scanResult = 'Unknown';

  @override
  void initState() {
    super.initState();
    _scanBarcode();
  }

  Future<void> _scanBarcode() async {
    try {
      String scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // Line color
        'Cancel', // Cancel button text
        true, // Show flash icon
        ScanMode.BARCODE, // Scan mode
      );

      if (scanResult != '-1') {
        setState(() {
          _scanResult = scanResult;
        });

        Navigator.pop(
            context, _scanResult); // Return scanned result to previous screen
      } else {
        Navigator.pop(context, null); // Cancelled scan
      }
    } catch (e) {
      Navigator.pop(context, null); // Error occurred
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Scanner'),
      ),
      body: Center(
        child: Text(
          'Scan result: $_scanResult',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
