

import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Contact>> getContacts(String userId) async {
    final snapshot = await _firestore.collection('contacts').where('userId', isEqualTo: userId).get();
    return snapshot.docs.map((doc) {
      final contact = Contact.fromMap(doc.data() as Map<String, dynamic>);
      contact.id = doc.id;
      return contact;
    }).toList();
  }

  Future<void> syncContacts(String userId, List<Contact> contacts) async {
    final batch = _firestore.batch();
    for (var contact in contacts) {
      final docRef = _firestore.collection('contacts').doc(contact.id ?? contact.name);
      batch.set(docRef, contact.toMap());
    }
    await batch.commit();
  }
}
