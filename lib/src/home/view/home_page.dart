import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_mobile/src/home/bloc/home_bloc.dart';
import 'package:scanner_mobile/src/home/view/home_view.dart';
import 'package:scanner_mobile/src/shared/repository/user/user_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: HomePage());

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = UserRepository();

    return RepositoryProvider<UserRepository>.value(
      value: userRepository,
      child: BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(userRepository: userRepository),
        child: const HomeView(),
      ),
    );
  }
}