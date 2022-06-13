import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signup_form.dart';
import '../bloc/signup_bloc.dart';
import 'package:scanner_mobile/src/app/bloc/app_bloc.dart';
import 'package:scanner_mobile/src/shared/repository/authorization/authorization_repository.dart';

class Signup extends StatelessWidget {
  const Signup({
    Key? key,
    required AuthorizationRepository authorizationRepository,
  }) : _authorizationRepository = authorizationRepository,
        super(key: key);

  final AuthorizationRepository _authorizationRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupBloc>(
      create: (_) => SignupBloc(
        appBloc: context.read<AppBloc>(),
        authorizationRepository: _authorizationRepository,
      ),
      child: const SignupForm(),
    );
  }
}