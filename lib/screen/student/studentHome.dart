import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:swiftcheckin/dataModels/student.dart';
import 'package:swiftcheckin/screen/student/checkIn.dart';
import 'package:swiftcheckin/screen/student/checkOut.dart';
import 'package:swiftcheckin/screen/student/profileStudent.dart';
import 'package:flutter/material.dart';
import 'package:swiftcheckin/services/dataServices.dart';
import 'package:swiftcheckin/services/auth.dart';

class studentHomePage extends StatelessWidget {
  studentHomePage({Key? key, required this.stduentEmail}) : super(key: key);

  final String stduentEmail;
  student? studentobj;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Home Page"),
        backgroundColor: Colors.yellow,
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => profilePage(obj: studentobj)),
                  ),
                );
              },
              child: const Icon(Icons.person))
        ],
      ),
      body: FutureBuilder(
          future: dataServices.fetchDetailsOfStudentbyEmail(stduentEmail),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                studentobj = snapshot.data as student;
                return Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Student Details')
                            .doc(stduentEmail)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data!["Current Status"] == true) {
                            return ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.yellowAccent)),
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => CheckOut(
                                          studentObject: studentobj,
                                        )),
                                  ),
                                )
                              },
                              child: const Text(
                                "Check Out",
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          } else {
                            return ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.yellowAccent)),
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => CheckIn(
                                          studentObject: studentobj,
                                        )),
                                  ),
                                )
                              },
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
