import 'package:swiftcheckin/dataModels/guard.dart';
import 'package:swiftcheckin/screen/guard/feature1.dart';
import 'package:swiftcheckin/screen/guard/feature2.dart';
import 'package:swiftcheckin/screen/guard/profile.dart';
import 'package:swiftcheckin/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftcheckin/services/dataServices.dart';

class guardHomePage extends StatelessWidget {
  guardHomePage({Key? key, required this.guardEmail}) : super(key: key);

  final String guardEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guard Home Page"),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
          future: dataServices.fetchDetailsOfGuard(guardEmail),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                guard guardObject = snapshot.data as guard;
                return Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () async => await authService.signOut(),
                      color: Colors.green,
                      child: const Text("Sign Out"),
                    ),
                    MaterialButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                profilePage(obj: guardObject)),
                          ),
                        )
                      },
                      color: Colors.green,
                      child: const Text("Profile"),
                    ),
                    const SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                Feature1(guardObject: guardObject)),
                          ),
                        )
                      },
                      color: Colors.green,
                      child: const Text("ID check"),
                    ),
                    const SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                ScanQR(guardObject: guardObject)),
                          ),
                        )
                      },
                      color: Colors.blue,
                      child: const Text("Scan QR"),
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
