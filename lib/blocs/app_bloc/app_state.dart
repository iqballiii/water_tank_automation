part of 'app_bloc.dart';

// @immutable
// sealed class AuthenticationState {}

// final class AuthenticationInitial extends AuthenticationState {}

enum AuthStatus { initial, loading, success, failed }

class AuthenticationState {
  const AuthenticationState(
      {this.errorMessage = "The entered credentials are incorrect!",
      this.user,
      required this.status});
  final UserDataModel? user;
  final String? errorMessage;
  final AuthStatus status;

  AuthenticationState? copyWith(
      {final UserDataModel? user,
      final String? errorMessage,
      final AuthStatus? status}) {
    return AuthenticationState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  List<Object> get props => [user!, errorMessage!, status];
}
