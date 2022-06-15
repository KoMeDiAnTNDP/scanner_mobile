part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.imageUrls = const [],
    this.imagesLoading = true,
    this.subCategories,
    this.subCategoriesLoading = true,
  });

  final List<String> imageUrls;
  final bool imagesLoading;
  final List<Category>? subCategories;
  final bool subCategoriesLoading;

  CategoryState copyWith({
    List<String>? imageUrls,
    bool? imagesLoading,
    List<Category>? subCategories,
    bool? subCategoriesLoading
  }) {
    return CategoryState(
      imageUrls: imageUrls ?? this.imageUrls,
      imagesLoading: imagesLoading ?? this.imagesLoading,
      subCategories: subCategories ?? this.subCategories,
      subCategoriesLoading: subCategoriesLoading ?? this.subCategoriesLoading,
    );
  }

  @override
  List<Object?> get props => [
    imageUrls,
    imagesLoading,
    subCategories,
    subCategoriesLoading,
  ];
}