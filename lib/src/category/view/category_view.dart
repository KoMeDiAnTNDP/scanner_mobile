import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_mobile/src/category/category.dart';
import 'package:scanner_mobile/src/category/widgets/images.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryBloc categoryBloc = context.read<CategoryBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryBloc.category.name),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Images(),
      )
    );
  }
}