
class ContactModal {
  int id;
  String name, phoneNumber, email;

  ContactModal._(
      {required this.id, required this.name, required this.phoneNumber, required this.email});

  factory ContactModal(Map json)
  {
    return ContactModal._(id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        email: json['email']);
  }

  Map<String, dynamic> mapToModal(ContactModal contact)
  {
    return {
      'id':contact.id,
      'name':contact.name,
      'phoneNumber':contact.phoneNumber,
      'email':contact.email,
    };
  }
}
