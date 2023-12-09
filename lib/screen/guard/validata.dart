import 'package:flutter/material.dart';
import 'package:swiftcheckin/dataModels/student.dart';
import 'package:swiftcheckin/services/dataServices.dart';

class ValidatePage extends StatelessWidget {
  ValidatePage({Key? key, required this.obj}) : super(key: key);

  student obj;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Validate"),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 25),
          Text(
            obj.firstName!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35),
          ),
          const SizedBox(height: 25),
          Text(
            obj.lastName!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35),
          ),
          Text(
            obj.uniqueID!.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35),
          ),
          MaterialButton(
            onPressed: () async {
              dataServices.changeStudentState0(obj);
              Navigator.pop(context);
            },
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text('Validate'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.red,
            textColor: Colors.white,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
