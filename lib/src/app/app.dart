import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_mobile/src/app/view/app.dart';
import 'package:scanner_mobile/src/app/bloc/app_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc(),
      child: const AppView(),
    );
  }
}