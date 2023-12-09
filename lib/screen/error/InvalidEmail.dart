import 'package:swiftcheckin/services/auth.dart';
import 'package:flutter/material.dart';

class errorInvalidEmail extends StatefulWidget {
  const errorInvalidEmail({super.key});

  @override
  State<errorInvalidEmail> createState() => _errorInvalidEmailState();
}

class _errorInvalidEmailState extends State<errorInvalidEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invalid Email ID"),
        backgroundColor: Colors.blue,
      ),
      body: MaterialButton(
        onPressed: () async => await authService.signOut(),
        textColor: Colors.white,
        color: Colors.red,
        child: const Text("Home Screen"),
      ),
    );
  }
}
