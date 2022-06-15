part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class GetSubCategory extends CategoryEvent {
  const GetSubCategory(this.mainCategoryId);

  final int mainCategoryId;

  @override
  List<Object> get props => [mainCategoryId];
}

class GetImages extends CategoryEvent {
  const GetImages({required this.mainCategoryId, this.subCategoryId});

  final int mainCategoryId;
  final int? subCategoryId;

  @override
  List<Object?> get props => [mainCategoryId, subCategoryId];
}