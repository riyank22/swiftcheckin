import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QR_Page extends StatelessWidget {
  QR_Page({Key? key, required this.data}) : super(key: key);

  String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR"),
        backgroundColor: Colors.yellow,
      ),
      //add Current Time over here
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (data.isNotEmpty) QrImageView(data: data, size: 200),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
