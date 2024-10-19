import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:water_tank_automation/models/user_data_model.dart';
import '../../services/firebase_service.dart';
part 'app_state.dart';
part 'app_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAppService appService = FirebaseAppService();
  var logger = Logger();
  AuthenticationBloc()
      : super(const AuthenticationState(status: AuthStatus.initial)) {
    on<SignInUserEvent>(signInUser);
    on<SignOutEvent>(signOutUser);
  }

  signInUser(SignInUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationState(status: AuthStatus.loading));
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(const AuthenticationState(
          status: AuthStatus.failed,
          errorMessage: 'Please enter email and password.'));
      return;
    }
    try {
      var user = await appService.signinUser(event.email, event.password);
      if (user is! FirebaseAuthException) {
        emit(AuthenticationState(status: AuthStatus.success, user: user));
      }
    } on FirebaseAuthException catch (e) {
      logger.f(e.code.toString());

      // emit(const AuthenticationState(status: AuthStatus.failed));
      if (e.code == 'user-not-found') {
        emit(const AuthenticationState(
            status: AuthStatus.failed,
            errorMessage:
                'Sorry! You\'re not authorised to enter Nauman manzil!'));
      } else if (e.code == 'wrong-password') {
        emit(const AuthenticationState(
            status: AuthStatus.failed,
            errorMessage:
                'The entered password is incorrect. Please enter the correct credentials and try again!.'));
      } else if (e.code == 'invalid-email') {
        emit(const AuthenticationState(
            status: AuthStatus.failed,
            errorMessage: 'Please enter a valid email address.'));
      } else {
        logger.f(e.code);
        logger.d(e.message);
        emit(AuthenticationState(
            status: AuthStatus.failed, errorMessage: e.message));
      }
    }
  }

  // The app has pre defined set of users, if a new user needs to be added, you can add them from
  // https://console.firebase.google.com/u/0/project/water-tank-automation-c1811/authentication/users .

  // signUpUser(SignUpUserEvent event, Emitter<AuthenticationState> emit) async {
  //   emit(AuthenticationLoadingState(isLoading: true));

  //   await appService.signinUser(event.email, event.password);
  //   try {
  //     final UserDataModel? user =
  //         await appService.signUpUser(event.email, event.password);
  //     if (user != null) {
  //       emit(AuthenticationLoadingState(isLoading: false));
  //       emit(AuthenticationSuccessState(user));
  //     } else {
  //       emit(const AuthenticationFailureState('create user failed'));
  //       logger.d(state.toString());
  //       logger.d('error');
  //     }
  //     return;
  //   } on FirebaseAuthException catch (e) {
  //     emit(AuthenticationFailureState(e.code.toString()));
  //     logger.d(e.toString());
  //     emit(AuthenticationLoadingState(isLoading: false));
  //     return;
  //   }
  // }

  signOutUser(SignOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationState(status: AuthStatus.loading));
    try {
      appService.signOutUser();
      emit(const AuthenticationState(status: AuthStatus.initial));
      return;
    } catch (e) {
      logger.d('error');
      logger.d(e.toString());
      emit(AuthenticationState(
          status: AuthStatus.failed, errorMessage: e.toString()));
      return;
    }
  }
}
