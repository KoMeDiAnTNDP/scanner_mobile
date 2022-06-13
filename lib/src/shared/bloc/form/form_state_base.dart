import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';


import 'package:scanner_mobile/src/shared/inputs/models/models.dart';

abstract class FormStateBase extends Equatable {
  const FormStateBase({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure
  });

  final Email email;
  final Password password;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, status];
}
