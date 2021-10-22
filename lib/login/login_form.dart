import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/home/home_page.dart';
import 'package:login_firebase/login/bloc/login_bloc.dart';

import 'form_body.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // inicializar instacia de login bloc
  late LoginBloc _loginBloc;

  // para poder agregar eventos al bloc
  // al presionar los botones de login

  bool _showLoading = false;

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  void _anonymousLogIn(bool _) {
    print("anonimo");
    // agregar evento al login bloc
    _loginBloc.add(LoginWithAnonymousEvent());
  }

  void _googleLogIn(bool _) {
    // invocar al login de firebase con el bloc
    // recodar configurar pantallad Oauth en google Cloud
    print("google");
    // agregar evento al login bloc
    _loginBloc.add(LoginWithGoogleEvent());
  }

  void _facebookLogIn(bool _) {
    // invocar al login de firebase con el bloc
    print("facebook");
    // agregar evento al login bloc
    _loginBloc.add(LoginWithFacebookEvent());
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
        // agregar bloc login provider
        // agregar bloc login consumer
        //  revisar estados y retornar error o home page o login page
        SafeArea(
          child: BlocProvider(
            create: (context) {
              _loginBloc = LoginBloc();
              return _loginBloc;
            },
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginErrorState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("${state.error}:\n${state.code}"),
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is LoginSuccessState) {
                  return HomePage();
                }
                return SingleChildScrollView(
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
                );
              },
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
