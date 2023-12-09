import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftcheckin/dataModels/guard.dart';
import 'package:swiftcheckin/dataModels/student.dart';

class dataServices {
  static var _db = FirebaseFirestore.instance;

  static Future<guard> fetchDetailsOfGuard(String givenEmail) async {
    final snapshot =
        await _db.collection('Guard Details').doc(givenEmail).get();
    final userData = guard.fromSnapshot(snapshot.data(), givenEmail);
    return userData;
  }

  static Future<student?> fetchDetailsOfStudentID(int ID) async {
    final snapshot = await _db
        .collection('Student Details')
        .where('Unique ID', isEqualTo: ID)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final userData = snapshot.docs.map((e) => student.fromID(e)).single;
      print("Succes");
      return userData;
    } else {
      return null;
    }
  }

  static Future<student> fetchDetailsOfStudentbyEmail(String givenEmail) async {
    final snapshot =
        await _db.collection('Student Details').doc(givenEmail).get();
    final userData = student.fromEmail(snapshot.data(), givenEmail);
    return userData;
  }

  //to change the state of the student, indicating check in chekc out
  static Future changeStudentState0(student? studentObject) async {
    if (studentObject?.state == true) {
      await _db
          .collection('Student Details')
          .doc(studentObject?.emailID)
          .update({'Current Status': false});
      studentObject?.state = false;
    } else {
      await _db
          .collection('Student Details')
          .doc(studentObject?.emailID)
          .update({'Current Status': true});
      studentObject?.state = true;
    }
  }
}
