import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_form.dart';
import '../bloc/login_bloc.dart';
import 'package:scanner_mobile/src/app/bloc/app_bloc.dart';
import 'package:scanner_mobile/src/shared/repository/authorization/authorization_repository.dart';

class Login extends StatelessWidget {
  const Login({
    Key? key,
    required authorizationRepository,
  }): _authorizationRepository = authorizationRepository,
        super(key: key);

  final AuthorizationRepository _authorizationRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(
        appBloc: context.read<AppBloc>(),
        authorizationRepository: _authorizationRepository,
      ),
      child: const LoginForm(),
    );
  }
}