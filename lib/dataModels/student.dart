import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftcheckin/dataModels/person.dart';

class student extends person {
  final String? roomNumber;
  final String? programme;
  final int? batch;
  bool? state;
  String? EventID;

  student({
    required super.emailID,
    required super.uniqueID,
    required super.firstName,
    required super.lastName,
    required this.programme,
    required this.batch,
    required this.roomNumber,
    required this.state,
  });

  factory student.fromID(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return student(
      emailID: document.id,
      uniqueID: data?['Unique ID'],
      firstName: data?['First Name'],
      lastName: data?['Last Name'],
      programme: data?['Programme'],
      batch: data?['Batch'],
      roomNumber: data?['Room Number'],
      state: data?['Current Status'],
    );
  }

  // ignore: non_constant_identifier_names
  factory student.fromEmail(Map<String, dynamic>? data, String Email) {
    return student(
      emailID: Email,
      uniqueID: data?['Unique ID'],
      firstName: data?['First Name'],
      lastName: data?['Last Name'],
      programme: data?['Programme'],
      batch: data?['Batch'],
      roomNumber: data?['Room Number'],
      state: data?['Current Status'],
    );
  }

  Future checkOut() async {}

  Future checkIn() async {}
}
