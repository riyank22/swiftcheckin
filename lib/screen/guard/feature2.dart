import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:swiftcheckin/dataModels/guard.dart';
import 'package:swiftcheckin/dataModels/student.dart';
import 'package:swiftcheckin/screen/guard/validateQR.dart';

class ScanQR extends StatefulWidget {
  ScanQR({
    Key? key,
    required this.studentObject,
    required this.guardObject,
  }) : super(key: key);

  student studentObject;
  guard guardObject;
  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String qrResult = 'Scanned Data will appear here';
  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        qrResult = qrCode.toString();
      });
    } on PlatformException {
      qrResult = 'Failed to read QR Code';
    }
  }

  @override
  Widget build(BuildContext context) {
    scanQR();
    return ValidatePageQR(
      studentObject: widget.studentObject,
      guardObject: widget.guardObject,
      qrResult: qrResult,
    );
  }
}
