
class Contact {
  String? id;
  String name;
  String phoneNumber;
  String email;

  Contact({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id']?.toString(),
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
    );
  }
}
