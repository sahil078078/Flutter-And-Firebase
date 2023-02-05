import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Services/auth.dart';
import '../Components/my_text_form_field_fireflutter.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService authService = AuthService();

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
        title: Text("Register"),
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
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
