import 'package:flutter/material.dart';
import 'package:login_firebase/splash_screen.dart';

void main() {
  // TODO: inicializar firebase
  // TODO: inicializar auth bloc provider

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // TODO: bloc builder con estados de auth bloc
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
