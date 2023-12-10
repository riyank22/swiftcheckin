import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftcheckin/dataModels/EventLog.dart';
import 'package:swiftcheckin/dataModels/guard.dart';
import 'package:swiftcheckin/dataModels/student.dart';

class dataServices {
  static var _db = FirebaseFirestore.instance;

  //for creating object of Guard
  static Future<guard> fetchDetailsOfGuard(String givenEmail) async {
    final snapshot =
        await _db.collection('Guard Details').doc(givenEmail).get();
    final userData = guard.fromSnapshot(snapshot.data(), givenEmail);
    return userData;
  }

  //for validation purpose
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

  //for creating objects of student
  static Future<student> fetchDetailsOfStudentbyEmail(String givenEmail) async {
    final snapshot =
        await _db.collection('Student Details').doc(givenEmail).get();
    final userData = student.fromEmail(snapshot.data(), givenEmail);
    return userData;
  }

  //for guard, feature to offline entry.
  static Future syncEntry(student? studentObject, guard guardObject) async {
    //finding snapshot of the student in the student table
    final result = await _db
        .collection('Student Details')
        .doc(studentObject?.emailID)
        .get();

    //for checking out
    if (studentObject?.state == true) {
      final eventObj =
          eventLog.Noreason(guardObject.uniqueID, studentObject!.uniqueID);
      final docMap = {
        "Student ID": studentObject.uniqueID,
        "Guard ID": guardObject.uniqueID,
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

  //for student screen, getting event details while checkin in
  static Future<eventLog> getEventDetails(student? studentObject) async {
    final result = await _db
        .collection('Student Details')
        .doc(studentObject?.emailID)
        .get();

    final result1 = await _db
        .collection('Event Log')
        .doc(result.data()?['Last Event ID'])
        .get();

    print(result1.data()?['Student ID']);
    print("got event");
    Timestamp t = result1.data()?['Exit Time'];
    print(t.toDate());

    final eventData = eventLog.checkOutStudent(result1.data(), result1.id);
    return eventData;
  }

  //for guard for scanning the QR
  Future syncEntrybyQR(student? studentObject, guard guardObject,
      Map<String, String> map) async {
    //decoding the QR Code Result

    if (map['status'] == "Check In") {
      //updating the log table

      await _db
          .collection('Event Log')
          .doc(map['Document ID'])
          .update({'Entry Time': DateTime.now()});

      //updating the student table
      await _db
          .collection('Student Details')
          .doc(studentObject?.emailID)
          .update({'Last Event ID': "", 'Current Status': true});
    } else if (map['status'] == "Check Out") {
      final docMap = {
        "Student ID": studentObject?.uniqueID,
        "Guard ID": guardObject.uniqueID,
        "Reason": map['Reason'],
        "Exit Time": DateTime.now(),
      };
      //adding to the log table and updating
      _db.collection('Event Log').add(docMap).then((value) async => await _db
          .collection('Student Details')
          .doc(studentObject?.emailID)
          .update({'Last Event ID': value.id, 'Current Status': false}));
    } else {
      print("Invalid Email ID");
    }
  }

  static Future<student?> getStudentDetailsbyQR(Map<String, String> map) async {
    //decoding the QR Code Result

    if (map['status'] == "Check In") {
      //updating the log table

      final result =
          await _db.collection('Event Log').doc(map['Document ID']).get();

      final snapshot = await _db
          .collection('Student Details')
          .where('Unique ID', isEqualTo: result.data()?['Student ID'])
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.map((e) => student.fromID(e)).single;
        return userData;
      } else {
        return null;
      }
    } else if (map['status'] == "Check In") {
      final snapshot = await _db
          .collection('Student Details')
          .where('Unique ID', isEqualTo: map['Student ID'])
          .get();
      //adding to the log table and updating
      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.map((e) => student.fromID(e)).single;
        return userData;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //helper function for the above funciton
  static Map<String, String> DecodeQR(String QRresult) {
    if (QRresult.startsWith('{Check Out}')) {
      var ans = {'status': 'Check Out'};
      int count = 0;
      while (QRresult[count] != '}') {
        count++;
      }

      ans['Unique ID'] = QRresult.substring(13, 12 + count);
      ans['Reason'] = QRresult.substring(15 + count, QRresult.length - 1);

      return ans;
    } else if (QRresult.startsWith('{Check In}')) {
      var ans = {'status': 'Check In'};

      ans['Document ID'] = QRresult.substring(12, QRresult.length - 1);

      return ans;
    } else {
      print("invalid QR");
      var ans = {'status': 'Invalid'};
      return ans;
    }
  }
}
