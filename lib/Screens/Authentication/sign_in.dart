import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_and_firebase/Models/user_model.dart';
import 'package:flutter_and_firebase/Services/auth.dart';

import '../Components/my_text_form_field_fireflutter.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService authService = AuthService();
  UserModel? userModel;

  bool isShowPassword = false;

  // textEditingController
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: Colors.brown.shade400,
        elevation: 0.0,
        title: Text("SignIn"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                User? result = await authService.signInAnonymous();
                if (result != null) {
                  if (mounted)
                    setState(
                      () => userModel = UserModel.fromJson(result),
                      // store data(result) into our UserModel
                    );

                  debugPrint('result : ${result}');
                  debugPrint('userModel : ${userModel?.uid}');
                  debugPrint('signIn done');
                } else {
                  debugPrint('error in signIn');
                }
              },
              child: Text("Anonymous SignIn"),
            ),
            const SizedBox(height: 10),
            MyTextFormFieldFireFlutter(
              controller: emailController,
              lable: "Email",
              hintText: "Enter email address",
            ),
            const SizedBox(height: 8),
            MyTextFormFieldFireFlutter(
              controller: passwordController,
              lable: "Password",
              hintText: "Enter your password",
              obscureText: isShowPassword,
              suffixIcon: InkWell(
                onTap: () => setState(() => isShowPassword = !isShowPassword),
                child: Icon(
                  isShowPassword
                      ? CupertinoIcons.eye_fill
                      : CupertinoIcons.eye_slash_fill,
                  size: 17,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade600,
                elevation: 2.0,
              ),
              onPressed: () async {},
              child: Text("SignIn"),
            ),
          ],
        ),
      ),
    );
  }
}
