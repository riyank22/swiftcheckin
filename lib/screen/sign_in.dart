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
          title: const Text("Welcome to SwiftCheckIn"),
          backgroundColor: Colors.blue),
      body: Center(
        child: Container(
          width: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    try {
                      User? user = await authService.signInWithGoogle();
                    } catch (e) {
                      print(e.toString());
                      print("Unable to Log in ");
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Image.asset('assets/google_logo.png', height: 25.0),
                      SizedBox(width: 10.0),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
