import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String? email;
  final bool emailVerified;
  final bool isAnonyms;
  final String? phoneNo;
  final String? photoUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.emailVerified,
    required this.isAnonyms,
    required this.phoneNo,
    required this.photoUrl,
  });

  factory UserModel.fromJson(User user) => UserModel(
        uid: user.uid,
        email: user.email,
        emailVerified: user.emailVerified,
        isAnonyms: user.isAnonymous,
        phoneNo: user.phoneNumber,
        photoUrl: user.photoURL,
      );
}
