import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokdex/src/cubit/utility/FirebaseRef.dart';
import 'package:pokdex/src/model/User.dart';

class AuthRepository {
  AuthRepository();

  Future<bool?> signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      FirebaseUser user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      var _firebaseRef =
          FirebaseDatabase().reference().child(FirebaseRef.USERS);
      _firebaseRef.child(user.uid).set({
        "name": name,
        "id": user.uid,
        "email": email,
      }).then((value) {
        return true;
      }, onError: (error) {
        throw error.toString();
      });
    } catch (error) {
      throw error.toString();
    }
  }

  Future<User?> signIn(
      String email, String password, BuildContext context) async {
    try {
      FirebaseUser user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      var _firebaseRef =
          await FirebaseDatabase().reference().child(FirebaseRef.USERS);
      var snapshot = await _firebaseRef.orderByKey().equalTo(user.uid).once();
      Map<dynamic, dynamic> responseData =
          snapshot.value as Map<dynamic, dynamic>;
      Map<dynamic, dynamic> userDate = responseData[user.uid];
      User usera = User.fromJson(userDate);
      return usera;
    } catch (error) {
      throw error.toString();
    }
  }
}
