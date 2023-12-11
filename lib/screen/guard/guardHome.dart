import 'package:swiftcheckin/dataModels/guard.dart';
import 'package:swiftcheckin/screen/guard/EnterID.dart';
import 'package:swiftcheckin/screen/guard/feature2.dart';
import 'package:swiftcheckin/screen/guard/profileGuard.dart';
import 'package:swiftcheckin/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftcheckin/services/dataServices.dart';

class guardHomePage extends StatelessWidget {
  guardHomePage({Key? key, required this.guardEmail}) : super(key: key);

  final String guardEmail;
  guard? guardObject;

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
              child: const Icon(Icons.person))
        ],
      ),
      body: FutureBuilder(
          future: dataServices.fetchDetailsOfGuard(guardEmail),
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
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                ScanQR(guardObject: guardObject)),
                          ),
                        )
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
                child: Text(guardEmail),
              ),
            );
          }),
    );
  }
}
