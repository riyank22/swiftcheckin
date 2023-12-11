import 'package:flutter/material.dart';
import 'package:swiftcheckin/dataModels/EventLog.dart';
import 'package:swiftcheckin/dataModels/student.dart';
import 'package:swiftcheckin/screen/student/QRpage.dart';
import 'package:swiftcheckin/services/dataServices.dart';

class CheckIn extends StatefulWidget {
  CheckIn({Key? key, required this.studentObject}) : super(key: key);
  student? studentObject;

  @override
  State<CheckIn> createState() => _Feature1State();
}

class _Feature1State extends State<CheckIn> {
  final TextEditingController _textController = TextEditingController();
  String Reason = '';
  DateTime currentTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check In"),
        backgroundColor: Colors.yellow,
      ),
      //add Current Time over here
      body: FutureBuilder(
        future: dataServices.getEventDetails(widget.studentObject),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            eventLog eventObj = snapshot.data as eventLog;
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Exit Time: ${eventObj.exitTime!.hour.toString()}:${eventObj.exitTime!.minute.toString()}:${eventObj.exitTime!.second.toString()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 35),
                    ),
                    const SizedBox(height: 50),
                    const SizedBox(height: 50),
                    Text(
                      'Entry Time: ${currentTime.hour.toString()}:${currentTime.minute.toString()}:${currentTime.second.toString()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 35),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: () {
                          Reason = _textController.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => QR_Page(
                                    data:
                                        "{{Check In},{${widget.studentObject?.uniqueID.toString()}},{${eventObj.DocumentID}}}",
                                  )),
                            ),
                          );
                        },
                        child: const Text('Generate QR Code')),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
