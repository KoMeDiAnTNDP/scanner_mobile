import 'package:json_annotation/json_annotation.dart';

import 'package:scanner_mobile/src/shared/models/category.dart';

part 'categories_response.g.dart';

@JsonSerializable(createToJson: false)
class CategoriesResponse {
  const CategoriesResponse({required this.categories});

  final List<Category> categories;

  static bool isListCategories(Map<String, dynamic> json) =>
      json.length == 1 && json.containsKey('categories');

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);
}