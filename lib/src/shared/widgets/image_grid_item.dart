import 'package:flutter/material.dart';

class ImageGridItem extends StatelessWidget {
  const ImageGridItem({
    Key? key,
    required this.url,
    required this.onTap,
  }) : super(key: key);

  final String url;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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