import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_mobile/src/auth/login/bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Login Failure')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _createEmailInput(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _createPasswordInput(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _createLoginButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createEmailInput() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => prev.email != curr.email,
      builder: (context, state) {
        return TextField(
          key: const Key('email_text_input'),
          decoration: const InputDecoration(
            icon: Icon(Icons.email),
            label: Text('Email'),
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (String email) => context.read<LoginBloc>()
              .add(LoginEmailChanged(email)),
        );
      },
    );
  }

  Widget _createPasswordInput() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => prev.password != curr.password,
      builder: (context, state) {
        return TextField(
          key: const Key('password_input_text'),
          obscureText: true,
          decoration: const InputDecoration(
            icon: Icon(Icons.lock),
            label: Text('Password'),
          ),
          onChanged: (String password) => context.read<LoginBloc>()
              .add(LoginPasswordChanged(password)),
        );
      },
    );
  }

  Widget _createLoginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('login_button'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: state.status.isValidated
              ? () => context.read<LoginBloc>().add(LoginFormSubmitted())
              : null,
          child: state.status.isSubmissionInProgress
              ? const SizedBox(
                height: 25.0,
                width: 25.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
              : const Text('Login'),
        );
      },
    );
  }
}