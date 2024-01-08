import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../models/user_data_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var logger = Logger();

  /// create user
  Future<UserDataModel?> signUpUser(
    String email,
    String password,
  ) async {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return UserDataModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email,
          username: firebaseUser.displayName,
        );
      }
    } on FirebaseAuthException catch (e) {
      logger.e(e.toString());
    }
    return null;
  }

  ///signOutUser
  Future<void> signOutUser() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }
  // ... (other methods)}

  Future<dynamic> signinUser(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return UserDataModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email,
          username: firebaseUser.displayName,
        );
      }
    } on FirebaseAuthException catch (e) {
      logger.i(e.code.toString());
      logger.i(e.message.toString());
      logger.e(e.toString());
      return e;
    }
  }
}
