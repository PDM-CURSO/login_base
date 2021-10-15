import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/home/home_page.dart';
import 'package:login_firebase/login/login_page.dart';
import 'package:login_firebase/splash_screen.dart';

import 'auth/bloc/auth_bloc.dart';

void main() async {
  // inicializar firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // inicializar auth bloc provider

  runApp(
    BlocProvider(
      create: (context) => AuthBloc()..add(VerifyAuthEvent()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // bloc builder con estados de auth bloc
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AlreadyAuthState) {
          return HomePage();
        } else if (state is UnAuthState) {
          return LoginPage();
        }
        return SplashScreen();
      },
    ));
  }
}
