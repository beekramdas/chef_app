class UserModelR {
  final String id;
  final String name;
  final String email;

  const UserModelR({required this.id, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {'id': this.id, 'name': this.name, 'email': this.email};
  }

  factory UserModelR.fromMap(Map<String, dynamic> map) {
    return UserModelR(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  @override
  String toString() {
    return 'UserModelR{id: $id, name: $name, email: $email}';
  }

  UserModelR copyWith({String? id, String? name, String? email}) {
    return UserModelR(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
