part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.user = User.empty,
    this.categories = const [],
    this.userIsLoading = false,
    this.categoriesIsLoading = false,
    this.upload = false,
    this.advance = false,
  });

  final User user;
  final List<Category> categories;
  final bool userIsLoading;
  final bool categoriesIsLoading;
  final bool upload;
  final bool advance;

  HomeState copyWith({
    User? user,
    List<Category>? categories,
    int? categoryId,
    bool? userIsLoading,
    bool? categoriesIsLoading,
    bool? upload,
    bool? advance
  }) {
    return HomeState(
      user: user ?? this.user,
      categories: categories ?? this.categories,
      userIsLoading: userIsLoading ?? this.userIsLoading,
      categoriesIsLoading: categoriesIsLoading ?? this.categoriesIsLoading,
      upload: upload ?? this.upload,
      advance: advance ?? this.advance,
    );
  }

  @override
  List<Object> get props => [
    user,
    categories,
    advance,
    userIsLoading,
    categoriesIsLoading,
    upload,
  ];
}