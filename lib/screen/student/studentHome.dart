import 'package:swiftcheckin/services/auth.dart';
import 'package:flutter/material.dart';

class studentHomePage extends StatefulWidget {
  const studentHomePage({super.key});

  @override
  State<studentHomePage> createState() => _studentHomePageState();
}

class _studentHomePageState extends State<studentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stduent Home Page"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(children: <Widget>[
          MaterialButton(
            onPressed: () async => await authService.signOut(),
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text("Sign Out"),
          )
        ]),
      ),
    );
  }
}
