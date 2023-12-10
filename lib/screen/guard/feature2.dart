// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:swiftcheckin/dataModels/guard.dart';
import 'package:swiftcheckin/dataModels/student.dart';
import 'package:swiftcheckin/screen/guard/validateQR.dart';
import 'package:swiftcheckin/services/dataServices.dart';

class ScanQR extends StatefulWidget {
  ScanQR({
    Key? key,
    required this.guardObject,
  }) : super(key: key);

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
    Map<String, String> map;
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: () {
                scanQR();
                map = dataServices.DecodeQR(qrResult);
                if (map['status'] == 'Invalid') {
                  print("Error scanning QR");
                } else {
                  print("sucess");
                }
              },
              color: Colors.green,
              child: const Text("Scan QR"),
            ),
            const SizedBox(
              height: 50,
              width: 50,
            ),
            MaterialButton(
              onPressed: () async {
                map = dataServices.DecodeQR(qrResult);
                student? studentObject =
                    await dataServices.getStudentDetailsbyQR(map);
                if (studentObject == null) {
                  print("Invalid QR Code");
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => ValidatePageQR(
                            studentObject: studentObject,
                            guardObject: widget.guardObject,
                            qrResult: map,
                          )),
                    ),
                  );
                }
              },
              color: Colors.green,
              child: const Text("Validate"),
            ),
          ],
        ),
      ),
    );
  }
}
