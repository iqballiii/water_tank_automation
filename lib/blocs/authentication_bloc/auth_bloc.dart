import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:water_tank_automation/models/user_data_model.dart';
import '../../services/auth_service.dart';
part 'auth_state.dart';
part 'auth_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService = AuthService();
  var logger = Logger();
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<AuthenticationEvent>((event, emit) {});

    on<SignUpUserEvent>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));

      await authService.signinUser(event.email, event.password);
      try {
        final UserDataModel? user =
            await authService.signUpUser(event.email, event.password);
        if (user != null) {
          emit(AuthenticationLoadingState(isLoading: false));
          emit(AuthenticationSuccessState(user));
        } else {
          emit(const AuthenticationFailureState('create user failed'));
          logger.d(state.toString());
          logger.d('error');
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthenticationFailureState(e.code.toString()));
        logger.d(e.toString());
      }
      emit(AuthenticationLoadingState(isLoading: false));
    });

    on<SignOutEvent>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
        authService.signOutUser();
      } catch (e) {
        logger.d('error');
        logger.d(e.toString());
      }
      emit(AuthenticationLoadingState(isLoading: false));
    });

    on<SignInUserEvent>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      dynamic user = await authService.signinUser(event.email, event.password);
      try {
        if (user is! FirebaseAuthException) {
          emit(AuthenticationLoadingState(isLoading: false));
          emit(AuthenticationSuccessState(user));
        } else {
          FirebaseAuthException error = user;
          emit(AuthenticationLoadingState(isLoading: false));
          if (error.code == 'user-not-found') {
            emit(const AuthenticationFailureState(
                'Sorry! You\'re not authorised to enter Nauman manzil!'));
          } else if (error.code == 'wrong-password') {
            emit(const AuthenticationFailureState(
                'The entered password is incorrect. Please enter the correct credentials and try again!.'));
          } else if (error.code == 'invalid-email') {
            emit(const AuthenticationFailureState(
                'Please enter a valid email address.'));
          } else {
            emit(const AuthenticationFailureState(
                'The entered credentials are incorrect. Please enter the correct credentials and try again!.'));
          }
          logger.d(state.toString());
          logger.d('error');
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthenticationFailureState(e.code.toString()));
        logger.d(e.toString());
      }
    });
  }
}
