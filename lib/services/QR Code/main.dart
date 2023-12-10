import 'package:flutter/material.dart';
import 'package:swiftcheckin/services/QR Code/generate_qr_code.dart';
import 'package:swiftcheckin/services/QR Code/scan_qr_code.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'qr code',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('qr code'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ScanQRCode()));
                  });
                },
                child: const Text('Scan QR Code')),
            const SizedBox(height: 40),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const GenerateQRCode()));
                  });
                },
                child: const Text('Generate QR Code'))
          ],
        ),
      ),
    );
  }
}
