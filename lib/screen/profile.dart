import 'package:swiftcheckin/dataModels/guard.dart';
import 'package:flutter/material.dart';

class profilePage extends StatelessWidget {
  profilePage({Key? key, required this.obj}) : super(key: key);

  guard obj;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: ListView(
        children: [
          Icon(
            Icons.person,
            size: 74,
          ),
          const SizedBox(height: 50),
          Text(
            obj.firstName!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35),
          ),
          const SizedBox(height: 50),
          Text(
            obj.lastName!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35),
          ),
          Text(
            obj.emailID!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35),
          ),
          Text(
            obj.uniqueID!.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35),
          )
        ],
      ),
    );
  }
}
