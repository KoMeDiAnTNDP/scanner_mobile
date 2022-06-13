import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_mobile/src/shared/models/models.dart';
import 'package:scanner_mobile/src/category/bloc/category_bloc.dart';
import 'package:scanner_mobile/src/category/view/category_view.dart';
import 'package:scanner_mobile/src/shared/repository/user/user_repository.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key, required this.category}) : super(key: key);

  final Category category;

  static Page page(Category category) =>
      MaterialPage(child: CategoryPage(category: category));

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (_) => CategoryBloc(
        category: category,
        userRepository: UserRepository(),
      ),
      child: const CategoryView(),
    );
  }
}