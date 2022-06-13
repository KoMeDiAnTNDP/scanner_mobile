import 'package:json_annotation/json_annotation.dart';

part 'images_response.g.dart';

@JsonSerializable(createToJson: false)
class ImagesResponse {
  const ImagesResponse({required this.imageUrls});
  
  @JsonKey(name: 'image_urls')
  final List<String> imageUrls;
  
  static isImagesResponses(Map<String, dynamic> json) =>
      json.length == 1 && json.containsKey('image_urls');

  factory ImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$ImagesResponseFromJson(json);
}