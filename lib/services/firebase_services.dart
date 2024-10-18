
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/contact_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<List<Contact>> getContacts(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('contacts')
        .get();

    return snapshot.docs.map((doc) {
      final contact = Contact.fromMap(doc.data() as Map<String, dynamic>);
      contact.id = doc.id; // Firestore document IDs are strings
      return contact;
    }).toList();
  }


  Future<void> syncContacts(String userId, List<Contact> contacts) async {
    final batch = _firestore.batch();
    final userContactsRef = _firestore.collection('users').doc(userId).collection('contacts');

    for (var contact in contacts) {
      final docRef = userContactsRef.doc(contact.id ?? contact.name);
      batch.set(docRef, contact.toMap());
    }

    await batch.commit();
  }
}
