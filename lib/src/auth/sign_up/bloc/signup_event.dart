part of 'signup_bloc.dart';

abstract class SignupEvent extends FormEventBase {
  const SignupEvent();
}

class SignupEmailChanged extends SignupEvent {
  const SignupEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class SignupUsernameChanged extends SignupEvent {
  const SignupUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class SignupConfirmedPasswordChanged extends SignupEvent {
  const SignupConfirmedPasswordChanged(this.confirmedPassword);

  final String confirmedPassword;

  @override
  List<Object> get props => [confirmedPassword];
}

class SignupFormConfirmed extends SignupEvent {}