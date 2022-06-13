import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  static bool isCategory(Map<String, dynamic> json) =>
      json.length == 2 && json.containsKey('id') && json.containsKey('name');

  @override
  List<Object?> get props => [id, name];
}