part of 'signup_bloc.dart';

class SignupState extends FormStateBase {
  const SignupState({
    Email email = const Email.pure(),
    this.username = const Username.pure(),
    Password password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    FormzStatus status = FormzStatus.pure,
  }): super(email: email, password: password, status: status);

  final Username username;
  final ConfirmedPassword confirmedPassword;

  SignupState copyWith({
    Email? email,
    Username? username,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
  }) {
    return SignupState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, username, password, confirmedPassword, status];
}