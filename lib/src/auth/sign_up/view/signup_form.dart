import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_mobile/src/auth/sign_up/bloc/signup_bloc.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
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
                _createEmailInput(),
                _createUsernameInput(),
                _createPasswordInput(),
                _createConfirmedPasswordInput(),
              ].map(_createInput).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _createSignupButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createInput(Widget input) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: input,
    );
  }

  Widget _createEmailInput() {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prev, curr) => prev.email != curr.email,
      builder: (context, state) {
        return TextField(
          key: const Key('email_text_input'),
          decoration: const InputDecoration(
            icon: Icon(Icons.email),
            label: Text('Email'),
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (String email) => context.read<SignupBloc>()
              .add(SignupEmailChanged(email)),
        );
      },
    );
  }

  Widget _createUsernameInput() {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prev, curr) => prev.username != curr.username,
      builder: (context, state) {
        return TextField(
          key: const Key('username_text_input'),
          decoration: const InputDecoration(
            icon: Icon(Icons.account_box),
            label: Text('Username'),
          ),
          onChanged: (String username) => context.read<SignupBloc>()
              .add(SignupUsernameChanged(username)),
        );
      },
    );
  }

  Widget _createPasswordInput() {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prev, curr) => prev.password != curr.password,
      builder: (context, state) {
        return TextField(
          key: const Key('password_input_text'),
          obscureText: true,
          decoration: const InputDecoration(
            icon: Icon(Icons.lock),
            label: Text('Password'),
          ),
          onChanged: (String password) => context.read<SignupBloc>()
              .add(SignupPasswordChanged(password)),
        );
      },
    );
  }

  Widget _createConfirmedPasswordInput() {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prev, curr) =>
        prev.confirmedPassword != curr.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('confirmed_password_input_text'),
          obscureText: true,
          decoration: const InputDecoration(
            icon: Icon(Icons.lock_outline),
            label: Text('Confirmed password'),
          ),
          onChanged: (String confirmedPassword) => context.read<SignupBloc>()
              .add(SignupConfirmedPasswordChanged(confirmedPassword)),
        );
      },
    );
  }

  Widget _createSignupButton() {
    return BlocBuilder<SignupBloc, SignupState>(
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
              ? () => context.read<SignupBloc>().add(SignupFormConfirmed())
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
              : const Text('Sign up'),
        );
      },
    );
  }
}