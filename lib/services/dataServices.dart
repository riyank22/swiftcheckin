import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftcheckin/dataModels/guard.dart';

class dataServices {
  static var _db = FirebaseFirestore.instance;

  static Future<guard> fetchDetailsOfGuard(String givenEmail) async {
    final snapshot =
        await _db.collection('Guard Details').doc(givenEmail).get();
    final userData = guard.fromSnapshot(snapshot.data(), givenEmail);
    return userData;
  }
}
