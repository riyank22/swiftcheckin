import 'package:flutter/material.dart';
import 'package:swiftcheckin/dataModels/guard.dart';
import 'package:swiftcheckin/dataModels/student.dart';
import 'package:swiftcheckin/services/dataServices.dart';

class ValidatePageQR extends StatelessWidget {
  ValidatePageQR(
      {Key? key,
      required this.studentObject,
      required this.guardObject,
      required this.qrResult})
      : super(key: key);

  student? studentObject;
  guard? guardObject;
  Map<String, String>? qrResult;

  String request = "";
  void getRequest(bool? state) {
    if (state!) {
      request = "Check Out request";
    } else {
      request = "Check In request";
    }
  }

  @override
  Widget build(BuildContext context) {
    var _db = dataServices();
    getRequest(studentObject?.state);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Validate"),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Icon(
                Icons.person,
                size: 100,
              ),
              Text(
                "${studentObject?.firstName!} ${studentObject?.lastName!}",
                style: const TextStyle(fontSize: 35),
              ),
              const SizedBox(height: 10),
              Text(
                studentObject!.uniqueID!.toString(),
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 10),
              Text(
                studentObject!.roomNumber!,
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 10),
              Text(
                request,
                style: const TextStyle(fontSize: 35),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  _db.syncEntrybyQR(studentObject, guardObject!, qrResult!);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: const Text(
                  'Validate',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
