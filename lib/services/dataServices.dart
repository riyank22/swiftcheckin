import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftcheckin/dataModels/EventLog.dart';
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

  static Future syncEntry(student? studentObject, guard guardObject) async {
    //finding snapshot of the student in the student table
    final result = await _db
        .collection('Student Details')
        .doc(studentObject?.emailID)
        .get();

    //for checking out
    if (studentObject?.state == true) {
      print('I am here');
      studentObject?.state = false;
      final eventObj =
          eventLog.Noreason(guardObject.uniqueID, studentObject!.uniqueID);
      final docMap = {
        "Student ID": studentObject.uniqueID,
        "Gurad ID": guardObject.uniqueID,
        "Reason": eventObj.reason,
        "Exit Time": eventObj.exitTime,
      };
      //adding to the log table
      _db.collection('Event Log').add(docMap).then((value) async => await _db
          .collection('Student Details')
          .doc(studentObject.emailID)
          .update({'Last Event ID': value.id, 'Current Status': false}));

      //as well as we are updating the student table
    }
    //for checking in
    else {
      //updating the log table
      studentObject?.state = true;
      await _db
          .collection('Event Log')
          .doc(result.data()?['Last Event ID'])
          .update({'Entry Time': DateTime.now()});
      //updating the student table
      await _db
          .collection('Student Details')
          .doc(studentObject?.emailID)
          .update({'Last Event ID': "", 'Current Status': true});
    }
  }
}
