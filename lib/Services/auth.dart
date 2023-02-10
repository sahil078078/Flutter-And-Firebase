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

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      debugPrint("SignIn result : $result");
      debugPrint("SignIn User : $user");
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint('SignInWithEmail&Pass ExceptionError : $e');
      return null;
    } catch (e) {
      debugPrint('SignInWithEmail&Pass CatchError : $e');
      return null;
    }
  }

  // register with email & password

  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      debugPrint("Register result : $result");
      debugPrint("Register User : $user");
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException register : $e');
      return null;
    } catch (e) {
      debugPrint('Firebase register catchError : $e');
      return null;
    }
  }

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
