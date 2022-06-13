import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_mobile/src/category/category.dart';

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

        return _createImagesList(state.imageUrls);
      },
    );
  }

  Widget _createImagesList(List<String> imageUrls) {
    return GridView.builder(
      itemCount: imageUrls.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 20.0,
      ),
      itemBuilder: (_, index) => _createImageItem(imageUrls[index]),
    );
  }

  Widget _createImageItem(String url) {
    return InkWell(
      onTap: () => {},
      child: GridTile(
        child: Card(
          child: Image.network(
            url,
            loadingBuilder: (context, image, loading) {
              if (loading == null) return image;

              return const Center(
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}