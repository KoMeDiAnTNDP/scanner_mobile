import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable(createToJson: false)
class TokenResponse {
  const TokenResponse({required this.token});

  final String token;

  static isTokenResponse(Map<String, dynamic> json) =>
      json.length == 1 && json.containsKey('token');

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
}