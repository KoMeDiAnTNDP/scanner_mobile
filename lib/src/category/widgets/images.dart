import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_mobile/src/category/category.dart';
import 'package:scanner_mobile/src/home/routes/routes.dart';
import 'package:scanner_mobile/src/shared/widgets/widgets.dart';

class Images extends StatelessWidget {
  const Images({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.imageUrls.isEmpty) {
          return const Center(
            child: Text('You have not uploaded any documents yet'),
          );
        }

        return _createImagesList(context, state.imageUrls);
      },
    );
  }

  void _selectImage(BuildContext context, String url) {
    context.flow<HomeData>().update((HomeData homeData) =>
        homeData.copyWith(imageUrl: url),
    );
  }

  Widget _createImagesList(BuildContext context, List<String> imageUrls) {
    return CustomGridList<String>(
      data: imageUrls,
      crossAxisCount: 2,
      itemBuilder: (index) => ImageGridItem(
        url: imageUrls[index],
        onTap: () => _selectImage(context, imageUrls[index]),
      ),
    );
  }
}