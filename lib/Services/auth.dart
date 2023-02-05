import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_and_firebase/Models/user_model.dart';

class AuthService {
  // make a instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // authChange userStream
  Stream<UserModel?> get user {
    // return _auth.userChanges();
    // return _auth.onAuthStateChanged; // old way not now
    return _auth.userChanges().map(
          (User? user) => user != null ? UserModel.fromJson(user) : null,
        );
  }

  //signIn anonymous
  Future<User?> signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      // debugPrint('result : $result : ${result.runtimeType}');
      // debugPrint('user : $user : ${user.runtimeType}');
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException signInAnonymously Error : $e');
      return null;
    } catch (e) {
      debugPrint('FirebaseAuth signInAnonymously CatchError : $e');
      return null;
    }
  }

  //  signIn with email & password

  // register with email & password

  //signOut

  Future signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException CatchError SignOut : $e');
      return null;
    } catch (e) {
      debugPrint('FirebaseAuth CatchError signOut : $e');
      return null;
    }
  }
}
