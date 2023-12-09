import 'package:firebase_auth/firebase_auth.dart';
import 'package:swiftcheckin/services/auth.dart';
import 'package:flutter/material.dart';

class signIn extends StatefulWidget {
  const signIn({super.key});

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Sign IN Page"), backgroundColor: Colors.green),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () async {
                try {
                  User? user = await authService.signInWithGoogle();
                } catch (e) {
                  print(e.toString());
                  print("Unable to Log in ");
                }
              },
              color: Colors.green,
              textColor: Colors.black,
              child: const Text('Login with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
