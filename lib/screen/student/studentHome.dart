import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swiftcheckin/dataModels/student.dart';
import 'package:swiftcheckin/screen/student/profile.dart';
import 'package:flutter/material.dart';
import 'package:swiftcheckin/services/dataServices.dart';
import 'package:swiftcheckin/services/auth.dart';

class studentHomePage extends StatelessWidget {
  studentHomePage({Key? key, required this.stduentEmail}) : super(key: key);

  final String stduentEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Home Page"),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
          future: dataServices.fetchDetailsOfStudentbyEmail(stduentEmail),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                student studentobj = snapshot.data as student;
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
                                profilePage(obj: studentobj)),
                          ),
                        )
                      },
                      color: Colors.green,
                      child: const Text("Profile"),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Student Details')
                            .doc(stduentEmail)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data!["Current Status"] == true) {
                            return MaterialButton(
                              onPressed: () => {},
                              textColor: Colors.white,
                              color: Colors.red,
                              child: const Text("Check Out"),
                            );
                          } else {
                            return MaterialButton(
                              onPressed: () => {},
                              textColor: Colors.white,
                              color: Colors.red,
                              child: const Text("Check In"),
                            );
                          }
                        })
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
                child: const Text("Log Out"),
              ),
            );
          }),
    );
  }
}
