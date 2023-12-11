import 'package:swiftcheckin/dataModels/guard.dart';
import 'package:flutter/material.dart';
import 'package:swiftcheckin/services/auth.dart';

class profilePage extends StatelessWidget {
  profilePage({Key? key, required this.obj}) : super(key: key);

  guard? obj;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Profile"),
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
