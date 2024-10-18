// lib/controllers/contact_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/database_helper.dart';
import '../model/contact_model.dart';
import '../services/firebase_services.dart';

class ContactController extends GetxController {
  RxList<ContactModal> contactList = <ContactModal>[].obs;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final FirestoreService _firestoreService = FirestoreService();



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DbServices.dbServices.database;
    contactDetailsShow();
  }


  Future<void> contactDetailsShow()
  async {
    List dataList = await DbServices.dbServices.showDatabase();
    contactList.value = dataList.map((e) => ContactModal(e),).toList();
    update();
    contactList.refresh();
  }

  void deleteContact(int index)
  {
    DbServices.dbServices.deleteContact(contactList[index].id);
    contactList.removeAt(index);
    update();
    contactList.refresh();
  }


  void updateDetails(int index)
  {
    txtName = TextEditingController(text: contactList[index].name);
    txtUserEmail = TextEditingController(text: contactList[index].email);
    txtMobile = TextEditingController(text: contactList[index].phoneNumber);
    update();
  }

  void searchData(String value)
  {
    if(value.isNotEmpty || value!='')
    {
      contactList.value = contactList.where((contact) => contact.name.contains(value),).toList();
    } else{
      contactDetailsShow();
    }
    update();
    contactList.refresh();
  }

}