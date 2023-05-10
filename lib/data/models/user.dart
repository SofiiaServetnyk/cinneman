class User {
  final int id;
  final String? name;
  final String? phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] * 1000),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt'] * 1000),
    );
  }
}
