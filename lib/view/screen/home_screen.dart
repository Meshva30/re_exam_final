// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../model/contact_model.dart';

class HomeScreen extends StatelessWidget {
  final ContactController contactController = Get.put(ContactController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.white),
        backgroundColor: Color(0xff3A6D8C),
        title: Text(
          'Contacts',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await contactController.syncContactsFromFirestore();
            },
            icon: Icon(Icons.sync, color: Colors.white),
          ),
        ],
      ),
      body: Obx(() {
        final contacts = contactController.contacts;
        return ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return ListTile(
              title: Text(contact.name),
              subtitle: Text(contact.phoneNumber),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Delete Contact',
                        middleText: 'Are you sure you want to delete ${contact.name}?',
                        onConfirm: () {
                          contactController.deleteContact(contact.id!);
                          Get.back(); // Close the dialog
                        },
                        onCancel: () => Get.back(),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _showEditContactDialog(contact),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff3A6D8C),
        onPressed: () => _showAddContactDialog(),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddContactDialog() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();

    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
                  final newContact = Contact(
                    name: nameController.text,
                    phoneNumber: phoneController.text,
                    email: emailController.text,
                  );
                  contactController.addContact(newContact);
                  Get.back();
                } else {
                  Get.snackbar('Error', 'Name and Phone Number are required.',
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditContactDialog(Contact contact) {
    nameController.text = contact.name;
    phoneController.text = contact.phoneNumber;
    emailController.text = contact.email;

    showDialog(
      context: Get.context!, // Use the context from Get
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Contact'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
                  final updatedContact = Contact(
                    id: contact.id,
                    name: nameController.text,
                    phoneNumber: phoneController.text,
                    email: emailController.text,
                  );
                  contactController.updateContact(updatedContact);
                  Get.back();
                } else {
                  Get.snackbar('Error', 'Name and Phone Number are required.',
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
