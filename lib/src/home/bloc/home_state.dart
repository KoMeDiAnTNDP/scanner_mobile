part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.user = User.empty,
    this.categories = const [],
    this.userIsLoading = false,
    this.categoriesIsLoading = false,
    this.upload = false,
    this.categoryId = -1,
  });

  final User user;
  final List<Category> categories;
  final int categoryId;
  final bool userIsLoading;
  final bool categoriesIsLoading;
  final bool upload;

  HomeState copyWith({
    User? user,
    List<Category>? categories,
    int? categoryId,
    bool? userIsLoading,
    bool? categoriesIsLoading,
    bool? upload,
  }) {
    return HomeState(
      user: user ?? this.user,
      categories: categories ?? this.categories,
      categoryId: categoryId ?? this.categoryId,
      userIsLoading: userIsLoading ?? this.userIsLoading,
      categoriesIsLoading: categoriesIsLoading ?? this.categoriesIsLoading,
      upload: upload ?? this.upload,
    );
  }

  @override
  List<Object> get props => [
    user,
    categories,
    categoryId,
    userIsLoading,
    categoriesIsLoading,
    upload,
  ];
}