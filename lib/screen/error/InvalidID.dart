import 'package:swiftcheckin/services/auth.dart';
import 'package:flutter/material.dart';

class errorInvalidID extends StatefulWidget {
  const errorInvalidID({super.key});

  @override
  State<errorInvalidID> createState() => _errorInvalidIDState();
}

class _errorInvalidIDState extends State<errorInvalidID> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invalid Student ID"),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () => Navigator.pop(context),
          textColor: Colors.black,
          color: Colors.cyan,
          child: const Text("OK"),
        ),
      ),
    );
  }
}
