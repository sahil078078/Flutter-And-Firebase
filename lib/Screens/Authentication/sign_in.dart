import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_and_firebase/Models/user_model.dart';
import 'package:flutter_and_firebase/Services/auth.dart';

import '../../functions/validator_collection.dart';
import '../Components/my_text_form_field_fireflutter.dart';

class SignIn extends StatefulWidget {
  final VoidCallback toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  UserModel? userModel;

  bool isShowPassword = false;
  String error = '';

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
      body: Form(
        key: _formKey,
        child: Padding(
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
                validator: emailValidator,
              ),
              const SizedBox(height: 8),
              MyTextFormFieldFireFlutter(
                controller: passwordController,
                lable: "Password",
                hintText: "Enter your password",
                obscureText: isShowPassword,
                validator: passwordValidator,
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
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade600,
                  elevation: 2.0,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    User? result = await authService.signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text,
                    );

                    if (result != null) {
                      setState(() => userModel = UserModel.fromJson(result));
                    } else {
                      setState(
                        () => error = "Can't signIn with this credentials",
                      );
                    }
                  }
                },
                child: Text("SignIn"),
              ),
              const SizedBox(height: 15),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: "Don't have account  ?  ",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: "Create a new account",
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.brown,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.toggleView();
                          },
                      ),
                    ],
                  ),
                ),
              ),
              if (error.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
