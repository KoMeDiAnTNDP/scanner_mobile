part of 'login_bloc.dart';

class LoginState extends FormStateBase {
  const LoginState({
    Email email = const Email.pure(),
    Password password = const Password.pure(),
    FormzStatus status = FormzStatus.pure,
  }) : super(email: email, password: password, status: status);

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}