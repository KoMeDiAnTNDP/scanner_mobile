import 'package:json_annotation/json_annotation.dart';

import 'package:scanner_mobile/src/shared/models/models.dart';

part 'user_response.g.dart';

@JsonSerializable(createToJson: false)
class UserResponse {
  const UserResponse({required this.user});

  final User user;

  static isUserResponse(Map<String, dynamic> json) =>
      json.length == 1 && json.containsKey('user');

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}