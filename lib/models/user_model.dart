class User {
  final int id;
  final String name;
  final String birthdate;
  final String ktpImagePath;

  User(
      {required this.id,
      required this.name,
      required this.birthdate,
      required this.ktpImagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthdate': birthdate,
      'ktpImagePath': ktpImagePath,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      birthdate: map['birthdate'],
      ktpImagePath: map['ktpImagePath'],
    );
  }
}
