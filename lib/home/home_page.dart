import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home page'),
          // TODO: add logout
          actions: [
            IconButton(
              onPressed: () {
                // TODO: agregar evento a bloc auth para desautenticar
              },
              icon: Icon(FontAwesomeIcons.signOutAlt),
            ),
          ]),
      body: Center(
        child: Container(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
