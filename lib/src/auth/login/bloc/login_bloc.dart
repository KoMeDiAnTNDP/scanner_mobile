import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

import 'package:scanner_mobile/src/app/bloc/app_bloc.dart';

import 'package:scanner_mobile/src/shared/models/http/models.dart';
import 'package:scanner_mobile/src/shared/inputs/models/models.dart';
import 'package:scanner_mobile/src/shared/bloc/form/bloc_form_base.dart';
import 'package:scanner_mobile/src/shared/repository/authorization/authorization_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AppBloc appBloc,
    required AuthorizationRepository authorizationRepository,
  }): _authorizationRepository = authorizationRepository,
        _appBloc = appBloc,
        super (const LoginState()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginFormSubmitted>(_onLoginFormSubmitted);
  }

  final AuthorizationRepository _authorizationRepository;
  final AppBloc _appBloc;

  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    Email email = Email.dirty(event.email);

    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void _onLoginPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    Password password = Password.dirty(event.password);

    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  void _onLoginFormSubmitted(LoginFormSubmitted event, Emitter<LoginState> emit) async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      BaseResponse<TokenResponse> response = await _authorizationRepository.signIn(
        state.email.value,
        state.password.value,
      );

      if (response.error != null || response.data == null || response.data?.token == null) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));

        return;
      }

      _appBloc.add(AppAuthChanged(response.data!.token));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}