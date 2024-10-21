import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import 'package:water_tank_automation/blocs/water_tracking_bloc/water_track_bloc.dart';

import '../models/user_data_model.dart';

class FirebaseAppService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var logger = Logger();
  DatabaseReference database =
      FirebaseDatabase.instance.ref('waterTank/water_level');

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
        logger.i(firebaseUser.displayName);
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
    final UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    final User? firebaseUser = userCredential.user;
    logger.f("This is the firebase user ${firebaseUser.toString()}");
    if (firebaseUser != null) {
      return UserDataModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        username: firebaseUser.displayName,
      );
    }
  }

  int? readWaterLevel() {
    Logger().d('inside the place');
    int waterLevel = 0;
    database.onValue.listen((DatabaseEvent event) {
      final double data = double.parse(event.snapshot.value.toString());
      final int levelOfWater = int.parse(((data / 100.0) * 100).toString());
      logger.i(levelOfWater.toString());
      WaterTrackBloc().add(WaterTrackEvent(waterLevel: levelOfWater));
    });
    return waterLevel;
  }
}
