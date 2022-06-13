part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppAuthChanged extends AppEvent {
  const AppAuthChanged(this.token);

  final String? token;

  @override
  List<Object?> get props => [token];
}

class AppLogoutRequested extends AppEvent {}
