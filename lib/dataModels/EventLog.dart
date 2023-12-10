import 'package:cloud_firestore/cloud_firestore.dart';

class eventLog {
  final int? studentID;
  final int? guardID;
  String? DocumentID;
  String reason = "";
  DateTime? entryTime;
  DateTime? exitTime;

  eventLog({
    required this.studentID,
    required this.guardID,
    required this.reason,
  });

  eventLog.Noreason(this.guardID, this.studentID) {
    this.exitTime = DateTime.now();
    this.reason = "NO REASON";
  }

  factory eventLog.checkOutStudent(Map<String, dynamic>? data, String? id) {
    var temp = eventLog(
      studentID: data?['Student ID'],
      guardID: data?['Guard ID'],
      reason: data?['Reason'],
    );
    Timestamp t = data?['Exit Time'];
    temp.exitTime = t.toDate();
    temp.DocumentID = id;
    return temp;
  }
}
