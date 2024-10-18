// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../model/contact_model.dart';

class ContactListScreen extends StatelessWidget {
  final ContactController _contactController = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff3A6D8C),
        title: Text(
          'Contacts',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.white,
            ),
            onPressed: _contactController.syncContactsToFirestore,
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                _contactController.searchContacts(value);
              },
              decoration: InputDecoration(
                labelText: 'Search Contacts',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: _contactController.contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contactController.contacts[index];
                  return ListTile(
                    title: Text(contact.name),
                    subtitle: Text(contact.phoneNumber),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () =>
                                _contactController.deleteContact(contact.id!)),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () =>
                              _showEditContactDialog(context, contact),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff3A6D8C),
        onPressed: () => _showAddContactDialog(context),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name')),
              TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone')),
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final contact = Contact(
                  name: nameController.text,
                  phoneNumber: phoneController.text,
                  email: emailController.text,
                );
                _contactController.addContact(contact);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showEditContactDialog(BuildContext context, Contact contact) {
    final nameController = TextEditingController(text: contact.name);
    final phoneController = TextEditingController(text: contact.phoneNumber);
    final emailController = TextEditingController(text: contact.email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name')),
              TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone')),
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedContact = Contact(
                  id: contact.id,
                  name: nameController.text,
                  phoneNumber: phoneController.text,
                  email: emailController.text,
                );
                _contactController.updateContact(updatedContact);
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
