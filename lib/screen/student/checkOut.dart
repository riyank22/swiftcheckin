import 'package:flutter/material.dart';
import 'package:swiftcheckin/dataModels/student.dart';
import 'package:swiftcheckin/screen/student/QRpage.dart';

class CheckOut extends StatefulWidget {
  CheckOut({Key? key, required this.studentObject}) : super(key: key);
  student? studentObject;

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
      appBar: AppBar(
        title: const Text("Check Out"),
        backgroundColor: Colors.yellow,
      ),
      //add Current Time over here
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Exit Time: ${currentTime.hour.toString()}:${currentTime.minute.toString()}:${currentTime.second.toString()}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 45),
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
                height: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellowAccent)),
                  onPressed: () {
                    Reason = _textController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => QR_Page(
                              data:
                                  "{{Check Out},{${widget.studentObject?.uniqueID.toString()}},{$Reason}}",
                            )),
                      ),
                    );
                  },
                  child: const Text(
                    'Generate QR Code',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
