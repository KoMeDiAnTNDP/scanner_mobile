import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_mobile/src/shared/models/models.dart';
import 'package:scanner_mobile/src/category/bloc/category_bloc.dart';
import 'package:scanner_mobile/src/category/view/category_view.dart';
import 'package:scanner_mobile/src/shared/repository/user/user_repository.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    Key? key,
    required this.mainCategory,
    this.subCategory,
  }) : super(key: key);

  final Category mainCategory;
  final Category? subCategory;

  static Page page({
    required Category mainCategory,
    Category? subCategory,
  }) => MaterialPage(child: CategoryPage(
    mainCategory: mainCategory,
    subCategory: subCategory,
  ));

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (_) => CategoryBloc(
        mainCategory: mainCategory,
        subCategory: subCategory,
        userRepository: UserRepository(),
      ),
      child: const CategoryView(),
    );
  }
}