import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swiftcheckin/screen/error/InvalidEmail.dart';
import 'package:swiftcheckin/screen/guard/guardHome.dart';
import 'package:swiftcheckin/screen/sign_in.dart';
import 'package:swiftcheckin/screen/student/studentHome.dart';
import 'package:flutter/widgets.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('User Emails')
                .where('Email', isEqualTo: snapshot.data?.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const errorInvalidEmail();
              } else if (snapshot.data?.docs.elementAt(0)['Role'] ==
                  'Student') {
                return studentHomePage(
                    stduentEmail: snapshot.data?.docs.elementAt(0)['Email']);
              } else {
                return guardHomePage(
                    guardEmail: snapshot.data?.docs.elementAt(0)['Email']);
              }
            },
          );
        } else {
          return const signIn();
        }
      },
    );
  }
}
