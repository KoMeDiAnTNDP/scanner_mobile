import 'package:flutter/material.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    Key? key,
    required this.onTap,
    required this.categoryName,
  }) : super(key: key);

  final void Function()? onTap;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: GridTile(
        child: Card(
          child: Center(
            child: Text(categoryName),
          ),
        ),
      ),
    );
  }
}