import 'package:json_annotation/json_annotation.dart';
import 'package:scanner_mobile/src/shared/models/http/images_response.dart';
import 'package:scanner_mobile/src/shared/models/http/models.dart';

part 'base_response.g.dart';

@JsonSerializable(createToJson: false)
class BaseResponse<T> {
  const BaseResponse({
    this.status,
    this.data,
    this.error,
  });

  final int? status;
  final String? error;

  @JsonKey(fromJson: _dataFromJson)
  final T? data;

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  static T? _dataFromJson<T>(Object? json) {
    if (json == null) return null;

    if (json is Map<String, dynamic>) {
      if (json.isEmpty) return null;

      if(TokenResponse.isTokenResponse(json)) {
        return TokenResponse.fromJson(json) as T;
      }

      if (UserResponse.isUserResponse(json)) {
        return UserResponse.fromJson(json) as T;
      }

      if (CategoriesResponse.isListCategories(json)) {
        return CategoriesResponse.fromJson(json) as T;
      }

      if (ImagesResponse.isImagesResponses(json)) {
        return ImagesResponse.fromJson(json) as T;
      }
    }

    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }
}
