import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_firebase/auth/bloc/auth_bloc.dart';
import 'package:login_firebase/create/create_form.dart';
import 'package:login_firebase/home/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home page'), actions: [
        IconButton(
          tooltip: "Desautenticar",
          onPressed: () {
            // agregar evento a bloc auth para desautenticar
            BlocProvider.of<AuthBloc>(context).add(SignOutAuthEvent());
          },
          icon: Icon(FontAwesomeIcons.signOutAlt),
        ),
      ]),
      body: BlocProvider(
        create: (context) => HomeBloc()..add(RequestDataEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is NoDataState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("No se encontraron datos..."),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ExistingDataState) {
              return ListView.builder(
                itemCount: state.tweetsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text("${state.tweetsList[index]["titulo"]}");
                },
              );
            }
            return Center(
              child: Text("No hay datos que mostrar aun..."),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.boxOpen),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreateForm()),
          );
        },
      ),
    );
  }
}
