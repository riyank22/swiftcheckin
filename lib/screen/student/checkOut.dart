import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swiftcheckin/dataModels/student.dart';
import 'package:swiftcheckin/screen/guard/validata.dart';
import 'package:swiftcheckin/screen/student/QRpage.dart';
import 'package:swiftcheckin/services/dataServices.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CheckOut extends StatefulWidget {
  CheckOut({Key? key, required this.studentObject}) : super(key: key);
  student studentObject;

  @override
  State<CheckOut> createState() => _Feature1State();
}

class _Feature1State extends State<CheckOut> {
  final TextEditingController _textController = TextEditingController();
  String Reason = '';
  DateTime currentTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Check Out")),
      //add Current Time over here
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      hintText: 'Reason',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Enter your Reason',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _textController.clear();
                        },
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Reason = _textController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => QR_Page(
                              data:
                                  "{${widget.studentObject.uniqueID.toString()}},{$Reason}",
                            )),
                      ),
                    );
                  },
                  child: const Text('Generate QR Code')),
            ],
          ),
        ),
      ),
    );
  }
}
