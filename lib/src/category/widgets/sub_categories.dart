import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_mobile/src/category/category.dart';
import 'package:scanner_mobile/src/home/routes/routes.dart';
import 'package:scanner_mobile/src/shared/models/models.dart';
import 'package:scanner_mobile/src/shared/widgets/widgets.dart';

class SubCategories extends StatelessWidget {
  const SubCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.subCategories == null || state.subCategories!.isEmpty) {
          return Container();
        }

        return _createListView(context, state.subCategories!);
      },
    );
  }

  void _selectCategory(BuildContext context, Category category) {
    context.flow<HomeData>().update((HomeData homeData) =>
        homeData.copyWith(subCategory: category),
    );
  }

  Widget _createListView(BuildContext context, List<Category> categories) {
    return CustomGridList<Category>(
      data: categories,
      itemBuilder: (index) => CategoryGridItem(
        onTap: () => _selectCategory(context, categories[index]),
        categoryName: categories[index].name,
      ),
    );
  }
}