import 'package:get/get.dart';
import '../helper/database_helper.dart';

import '../model/contact_model.dart';
import '../services/firebase_services.dart';

class ContactController extends GetxController {
  var contacts = <Contact>[].obs;
  var isLoading = false.obs;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void onInit() {
    super.onInit();
    loadContacts();
  }

  void loadContacts() async {
    isLoading.value = true;

    contacts.value = await _dbHelper.getContacts();
    isLoading.value = false;
  }

  void addContact(Contact contact) async {
    await _dbHelper.insertContact(contact);
    syncContactsToFirestore();
    loadContacts();
  }

  void updateContact(Contact contact) async {
    await _dbHelper.updateContact(contact);
    syncContactsToFirestore();
    loadContacts();
  }

  void deleteContact(int id) async {
    await _dbHelper.deleteContact(id);
    syncContactsToFirestore();
    loadContacts();
  }

  Future<void> syncContactsToFirestore() async {
    String userId = "currentUserId";
    await _firestoreService.syncContacts(userId, contacts);
  }

  Future<void> fetchContactsFromFirestore() async {
    String userId = "currentUserId";
    var cloudContacts = await _firestoreService.getContacts(userId);

    for (var contact in cloudContacts) {
      await _dbHelper.insertContact(contact);
    }

    loadContacts();
  }
}
