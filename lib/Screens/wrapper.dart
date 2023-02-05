import "package:flutter/material.dart";
import 'package:flutter_and_firebase/Models/user_model.dart';
import 'package:flutter_and_firebase/Screens/Authentication/authenticate.dart';
import 'package:flutter_and_firebase/Screens/Home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserModel?>(context);
    // return either home or authentication screen
    return user != null ? Home() : Authenticate();
  }
}
