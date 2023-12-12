// ignore_for_file: use_build_context_synchronously

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:swiftcheckin/dataModels/guard.dart';
import 'package:swiftcheckin/dataModels/student.dart';
import 'package:swiftcheckin/screen/error/InvalidQR.dart';
import 'package:swiftcheckin/screen/guard/EnterID.dart';
import 'package:swiftcheckin/screen/guard/profileGuard.dart';
import 'package:swiftcheckin/screen/guard/validateQR.dart';
import 'package:swiftcheckin/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftcheckin/services/dataServices.dart';

class guardHomePage extends StatefulWidget {
  guardHomePage({Key? key, required this.guardEmail}) : super(key: key);

  final String guardEmail;

  @override
  State<guardHomePage> createState() => _guardHomePageState();
}

class _guardHomePageState extends State<guardHomePage> {
  guard? guardObject;
  Map<String, String>? map;
  String qrResult = 'Blank';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guard Home Page"),
        backgroundColor: Colors.cyan,
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => profilePage(obj: guardObject)),
                  ),
                );
              },
              child: const Icon(
                Icons.person,
                size: 35,
                color: Colors.black,
              ))
        ],
      ),
      body: FutureBuilder(
          future: dataServices.fetchDetailsOfGuard(widget.guardEmail),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                guardObject = snapshot.data as guard;
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan)),
                      onPressed: () async {
                        await scanQR();

                        if (qrResult == '-1') {
                          return;
                        }
                        map = dataServices.DecodeQR(qrResult);
                        if (map?['status'] == 'Invalid') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const InvalidQR()),
                            ),
                          );
                        } else {
                          student? studentObject =
                              await dataServices.getStudentDetailsbyQR(map!);
                          if (studentObject == null) {
                            print("Invalid QR Code");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const InvalidQR()),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ValidatePageQR(
                                      studentObject: studentObject,
                                      guardObject: guardObject,
                                      qrResult: map,
                                    )),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Scan QR",
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan)),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                EnterID(guardObject: guardObject)),
                          ),
                        )
                      },
                      child: const Text("Enter ID",
                          style: TextStyle(fontSize: 30, color: Colors.black)),
                    ),
                  ],
                ));
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: MaterialButton(
                onPressed: () async => await authService.signOut(),
                color: Colors.red,
                child: Text(widget.guardEmail),
              ),
            );
          }),
    );
  }
}
