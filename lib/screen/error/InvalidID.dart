import 'package:flutter/material.dart';

class errorInvalidID extends StatelessWidget {
  const errorInvalidID({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
        backgroundColor: const Color.fromARGB(255, 233, 83, 73),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_rounded,
              color: Colors.red,
              size: 150,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Invalid Student ID',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              textColor: Colors.white,
              color: Colors.red,
              child: const Text("OK"),
            ),
          ],
        ),
      ),
    );
  }
}
