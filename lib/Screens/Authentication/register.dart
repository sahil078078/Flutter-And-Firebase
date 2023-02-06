import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_and_firebase/Models/user_model.dart';

import '../../Services/auth.dart';
import '../Components/my_text_form_field_fireflutter.dart';

class Register extends StatefulWidget {
  final VoidCallback toggleView;
  const Register({
    super.key,
    required this.toggleView,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  UserModel? userModel;
  bool isShowPassword = false;
  bool isShowConfirmPassword = false;
  String error = '';

  // textEditingController
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
        title: Text("Register"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                MyTextFormFieldFireFlutter(
                  controller: emailController,
                  lable: "Email",
                  hintText: "Enter email address",
                  validator: (email) {
                    const pattern =
                        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                    final regex = RegExp(pattern);

                    if (email != null && email.trim().isNotEmpty) {
                      if (!regex.hasMatch(email)) {
                        return "Please enter valid email address";
                      } else {
                        return null;
                      }
                    } else {
                      return "Please enter email address";
                    }
                  },
                ),
                const SizedBox(height: 12),
                MyTextFormFieldFireFlutter(
                  controller: passwordController,
                  lable: "Password",
                  hintText: "Enter your password",
                  obscureText: isShowPassword,
                  suffixIcon: InkWell(
                    onTap: () =>
                        setState(() => isShowPassword = !isShowPassword),
                    child: Icon(
                      isShowPassword
                          ? CupertinoIcons.eye_fill
                          : CupertinoIcons.eye_slash_fill,
                      size: 17,
                    ),
                  ),
                  validator: (pas) {
                    if (pas != null && pas.trim().isNotEmpty) {
                      if (pas.length < 6) {
                        return "Password have atleast 6 character";
                      } else {
                        return null;
                      }
                    } else {
                      return "Please enter password";
                    }
                  },
                ),
                const SizedBox(height: 12),
                MyTextFormFieldFireFlutter(
                  controller: confirmPasswordController,
                  lable: "Confirm Password",
                  hintText: "Enter confirm password",
                  obscureText: isShowConfirmPassword,
                  suffixIcon: InkWell(
                    onTap: () => setState(
                        () => isShowConfirmPassword = !isShowConfirmPassword),
                    child: Icon(
                      isShowConfirmPassword
                          ? CupertinoIcons.eye_fill
                          : CupertinoIcons.eye_slash_fill,
                      size: 17,
                    ),
                  ),
                  validator: (pass) {
                    if (pass != passwordController.text) {
                      return "Password is not matching";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade600,
                    elevation: 2.0,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User? result =
                          await authService.registerWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text,
                      );

                      if (result != null) {
                        if (mounted) {
                          setState(
                            () => userModel = UserModel.fromJson(result),
                          );
                        }
                      } else {
                        setState(
                          () => error = "Failed to create an user",
                        );
                      }
                    }
                  },
                  child: Text("Register"),
                ),
                const SizedBox(height: 15),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: "Already have you account ?  ",
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: "Login",
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
      ),
    );
  }
}
