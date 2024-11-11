import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> testFirestore() async {
  try {
    // Example write operation
    await FirebaseFirestore.instance.collection('users').doc('test_user').set({
      'name': 'Test User',
      'email': 'testuser@example.com',
      'createdAt': Timestamp.now(),
    });

    // Example read operation
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc('test_user')
        .get();

    if (documentSnapshot.exists) {
      print("Document data: ${documentSnapshot.data()}");
    } else {
      print("No document found");
    }
  } catch (e) {
    print("Error interacting with Firestore: $e");
  }
}
