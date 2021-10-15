import 'package:flutter/material.dart';

import 'form_body.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // TODO: inicializar instacia de login bloc

  // para poder agregar eventos al bloc
  // al presionar los botones de login

  bool _showLoading = false;

  // @override
  // void dispose() {
  //   _loginBloc.close();
  //   super.dispose();
  // }

  void _anonymousLogIn(bool _) {
    print("anonimo");
    // TODO: agregar evento al login bloc
  }

  void _googleLogIn(bool _) {
    // invocar al login de firebase con el bloc
    // recodar configurar pantallad Oauth en google Cloud
    print("google");
    // TODO: agregar evento al login bloc
  }

  void _facebookLogIn(bool _) {
    // invocar al login de firebase con el bloc
    print("facebook");
    // TODO: agregar evento al login bloc
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // stack background image
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff0884cc),
                Color(0xff04476e),
              ],
            ),
          ),
        ),
        // form content
        // TODO: agregar bloc login provider
        // TODO: agregar bloc login consumer
        // TODO: revisar estados y retornar error o home page o login page
        SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 60, horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color(0xa0FFffff),
              ),
              child: FormBody(
                onFacebookLoginTap: _facebookLogIn,
                onGoogleLoginTap: _googleLogIn,
                onAnonymousLoginTap: _anonymousLogIn,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _showLoading ? CircularProgressIndicator() : Container(),
        ),
      ],
    );
  }
}
