part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.imageUrls = const [],
    this.loading = false,
  });

  final List<String> imageUrls;
  final bool loading;

  CategoryState copyWith({
    List<String>? imageUrls,
    bool? loading,
  }) {
    return CategoryState(
      imageUrls: imageUrls ?? this.imageUrls,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [imageUrls];
}