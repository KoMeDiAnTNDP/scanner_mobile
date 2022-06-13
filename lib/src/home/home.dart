import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:scanner_mobile/src/home/routes/routes.dart';

export 'bloc/home_bloc.dart';
export 'view/home_page.dart';

class HomeFlow extends StatelessWidget {
  const HomeFlow({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: HomeFlow());

  @override
  Widget build(BuildContext context) {
    return const FlowBuilder<HomeData>(
      state: HomeData(),
      onGeneratePages: onGenerateHomePages,
    );
  }
}