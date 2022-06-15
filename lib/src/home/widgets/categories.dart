import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_mobile/src/home/home.dart';
import 'package:scanner_mobile/src/home/routes/routes.dart';
import 'package:scanner_mobile/src/shared/models/models.dart';
import 'package:scanner_mobile/src/shared/widgets/widgets.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.categories.isEmpty) {
          return const Center(
            child: Text('You have not uploaded any documents yet'),
          );
        }
        
        FlowController<HomeData> homeFlowController = context.flow<HomeData>();
        HomeBloc homeBloc = context.read<HomeBloc>();

        return RefreshIndicator(
          onRefresh: () async => homeBloc.add(GetUserMainCategories()),
          child: _createList(context, homeFlowController, state.categories),
        );
      },
    );
  }

  void _selectCategory(
      BuildContext context,
      FlowController<HomeData> homeFlowController,
      Category category
      ) {
    homeFlowController.update((HomeData homeData) =>
        homeData.copyWith(mainCategory: category),
    );
  }

  Widget _createList(
      BuildContext context,
      FlowController<HomeData> homeFlowController,
      List<Category> categories,
      ) {
    return CustomGridList<Category>(
      data: categories,
      itemBuilder: (index) =>
          CategoryGridItem(
            onTap: () => _selectCategory(context, homeFlowController, categories[index]),
            categoryName: categories[index].name,
          ),
    );
  }
}