import 'package:swiftcheckin/dataModels/person.dart';

class guard extends person {
  guard({super.emailID, super.uniqueID, super.firstName, super.lastName});

  factory guard.fromSnapshot(Map<String, dynamic>? data, String Email) {
    return guard(
        emailID: Email,
        uniqueID: data?['Unique ID'],
        firstName: data?['First Name'],
        lastName: data?['Last Name']);
  }

  void EnteryByID() {}
}
