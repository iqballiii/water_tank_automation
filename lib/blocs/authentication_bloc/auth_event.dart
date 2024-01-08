part of 'auth_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();

  List<Object> get props => [];
}

class SignUpUserEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignUpUserEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOutEvent extends AuthenticationEvent {}

class SignInUserEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInUserEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
