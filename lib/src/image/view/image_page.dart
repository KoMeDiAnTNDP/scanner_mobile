import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({
    Key? key,
    required this.url
  }) : super(key: key);

  static Page page({required String url}) =>
      MaterialPage(child: ImagePage(url: url));

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(
          url,
          loadingBuilder: (context, image, loading) {
            if (loading == null) return image;

            return const Center(
              child: SizedBox(
                width: 60.0,
                height: 60.0,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}