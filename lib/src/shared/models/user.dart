import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.username,
  });

  final int id;
  final String email;
  final String username;

  static const empty = User(id: -1, email: '', username: '');

  bool get isEmpty => this == User.empty;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
    );
  }

  User copyWith({
    int? id,
    String? email,
    String? username
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
    );
  }

  @override
  String toString() {
    return 'User('
        'id: $id'
        'email: $email, '
        'username: $username,'
        ')';
  }

  @override
  List<Object> get props => [id, email, username];
}