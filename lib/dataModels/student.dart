import 'package:swiftcheckin/dataModels/person.dart';

class student extends person {
  final String? roomNumber;
  final String? programme;
  final int? batch;
  final bool? state;

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

  Future checkOut() async {}

  Future checkIn() async {}
}
