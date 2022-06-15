import 'package:flutter/material.dart';

class CustomGridList<T> extends StatelessWidget {
  const CustomGridList({
    Key? key,
    required this.data,
    required this.itemBuilder,
    this.crossAxisCount = 3,
  }) : super(key: key);

  final List<T> data;
  final Widget Function(int index) itemBuilder;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return _createImagesList(data);
  }

  Widget _createImagesList(List<T> list) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 20.0,
      ),
      itemBuilder: (_, index) => itemBuilder(index),
    );
  }
}