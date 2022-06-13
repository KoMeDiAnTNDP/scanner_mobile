import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  const Auth({required this.token});

  final String token;

  static const unauthorized = Auth(token: '');

  bool get isUnauthorized => this == Auth.unauthorized;

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {
      token: token
    };
  }

  Auth copyWith({String? token}) {
    return Auth(token: token ?? this.token);
  }

  @override
  String toString() {
    return 'Auth('
        'token: $token'
        ')';
  }

  @override
  List<Object> get props => [token];
}
