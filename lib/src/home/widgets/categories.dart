import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_mobile/src/home/home.dart';
import 'package:scanner_mobile/src/home/routes/routes.dart';
import 'package:scanner_mobile/src/shared/models/models.dart';

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

        return _createList(state.categories, homeFlowController);
      },
    );
  }

  Widget _createCategoryItem(
      Category category,
      FlowController<HomeData> homeFlowController,
      ) {
    return InkWell(
      onTap: () =>
          homeFlowController.update((HomeData homeData) =>
              homeData.copyWith(category: category),
          ),
      child: GridTile(
        child: Card(
          child: Center(
            child: Text(category.name),
          ),
        ),
      ),
    );
  }

  Widget _createList(
      List<Category> categories,
      FlowController<HomeData> homeFlowController,
      ) {
    return GridView.builder(
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 20.0,
      ),
      itemBuilder: (_, index) =>
          _createCategoryItem(categories[index], homeFlowController),
    );
  }
}