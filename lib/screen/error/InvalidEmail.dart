import 'package:swiftcheckin/services/auth.dart';
import 'package:flutter/material.dart';

class errorInvalidEmail extends StatelessWidget {
  const errorInvalidEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invalid Email ID"),
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
              'Your Email ID is not registed with our database.\n Please contact Admin',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () async => await authService.signOut(),
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
