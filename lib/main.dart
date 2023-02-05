import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/Models/user_model.dart';
import 'package:flutter_and_firebase/Screens/wrapper.dart';
import 'package:flutter_and_firebase/Services/auth.dart';
import 'package:provider/provider.dart';

// new application id : com.example.fire_flutter_sahil
// old application id : com.example.flutter_and_firebase
// never remove it

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // initializeFirebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FireFlutter',
        home: const Wrapper(),
      ),
    );
  }
}

// wrapper (parent)
// 1) Home                        2) Authentication (two child)
//Setting & BrewCrew              SignIn and Register
//
