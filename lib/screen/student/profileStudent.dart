import 'package:swiftcheckin/dataModels/student.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swiftcheckin/services/auth.dart';

class profilePage extends StatelessWidget {
  profilePage({Key? key, required this.obj}) : super(key: key);

  student? obj;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.yellow,
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await authService.signOut();
            },
            child: const Row(
              children: <Widget>[
                Icon(Icons.logout),
                SizedBox(
                  width: 5,
                ),
                Text('Sign Out'),
              ],
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          const Icon(
            Icons.person,
            size: 148,
          ),
          const SizedBox(height: 20),
          Text(
            '${obj!.firstName!} ${obj!.lastName}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 50),
          ),
          const SizedBox(height: 10),
          Text(
            obj!.uniqueID!.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 10),
          Text(
            obj!.emailID!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
