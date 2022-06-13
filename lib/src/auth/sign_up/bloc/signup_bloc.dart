import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

import 'package:scanner_mobile/src/app/bloc/app_bloc.dart';
import 'package:scanner_mobile/src/shared/models/http/models.dart';
import 'package:scanner_mobile/src/shared/inputs/models/models.dart';
import 'package:scanner_mobile/src/shared/bloc/form/bloc_form_base.dart';
import 'package:scanner_mobile/src/shared/repository/authorization/authorization_repository.dart';

part 'signup_state.dart';
part 'signup_event.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({
    required AppBloc appBloc,
    required AuthorizationRepository authorizationRepository,
  }): _authorizationRepository = authorizationRepository,
        _appBloc = appBloc,
        super(const SignupState()) {
    on<SignupEmailChanged>(_onSignupEmailChanged);
    on<SignupUsernameChanged>(_onSignupUsernameChanged);
    on<SignupPasswordChanged>(_onSignupPasswordChanged);
    on<SignupConfirmedPasswordChanged>(_onSignupConfirmedPasswordChanged);
    on<SignupFormConfirmed>(_onSignupFromConfirmed);
  }

  final AuthorizationRepository _authorizationRepository;
  final AppBloc _appBloc;

  void _onSignupEmailChanged(SignupEmailChanged event, Emitter<SignupState> emit) {
    Email email = Email.dirty(event.email);

    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.username,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void _onSignupUsernameChanged(SignupUsernameChanged event, Emitter<SignupState> emit) {
    Username username = Username.dirty(event.username);

    emit(state.copyWith(
      username: username,
      status: Formz.validate([
        state.email,
        username,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void _onSignupPasswordChanged(SignupPasswordChanged event, Emitter<SignupState> emit) {
    Password password = Password.dirty(event.password);
    ConfirmedPassword confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );

    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.email,
        state.username,
        password,
        confirmedPassword,
      ]),
    ));
  }

  void _onSignupConfirmedPasswordChanged(SignupConfirmedPasswordChanged event, Emitter<SignupState> emit) {
    ConfirmedPassword confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: event.confirmedPassword,
    );

    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.username,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  void _onSignupFromConfirmed(SignupFormConfirmed event, Emitter<SignupState> emit) async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      BaseResponse<TokenResponse> response = await _authorizationRepository.signUp(
        state.email.value,
        state.password.value,
        state.username.value,
      );

      if (response.error != null || response.data == null || response.data?.token == null) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));

        return;
      }

      _appBloc.add(AppAuthChanged(response.data?.token));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}