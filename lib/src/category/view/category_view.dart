import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_mobile/src/category/category.dart';
import 'package:scanner_mobile/src/category/widgets/images.dart';
import 'package:scanner_mobile/src/category/widgets/sub_categories.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryBloc categoryBloc = context.read<CategoryBloc>();
    return Scaffold(
      appBar: AppBar(
        title: categoryBloc.subCategory == null
            ? Text(categoryBloc.mainCategory.name)
            : Text(categoryBloc.subCategory!.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state.subCategories == null || state.subCategories!.isEmpty) {
              return const Images();
            }

            return Column(
              children: const [
                SubCategories(),
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Divider(color: Colors.grey,),
                ),
                Images(),
              ],
            );
          },
        ),
      )
    );
  }
}