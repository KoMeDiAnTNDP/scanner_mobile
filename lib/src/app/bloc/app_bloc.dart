import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:scanner_mobile/src/shared/service/http/http_service.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final HttpService _httpService = HttpService();

  AppBloc() : super(const AppState.unauthenticated()) {
    on<AppAuthChanged>(_onAppAuthChanged);
    on<AppLogoutRequested>(_onAppLogoutRequested);
  }

  void _onAppAuthChanged(AppAuthChanged event, Emitter<AppState> emit) {
    _httpService.setToken(event.token);

    emit(
      event.token == null
          ? const AppState.unauthenticated()
          : const AppState.authenticated()
    );
  }

  void _onAppLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    add(const AppAuthChanged(null));
  }
}
