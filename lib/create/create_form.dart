import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_firebase/create/bloc/create_bloc.dart';

class CreateForm extends StatefulWidget {
  CreateForm({Key? key}) : super(key: key);

  @override
  _CreateFormState createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  var _formKey = GlobalKey<FormState>();
  late CreateBloc _createBloc;
  String title = "", descr = "";
  File? _img;

  // pick image
  Future<File?> _getImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    if (pickedImage != null)
      return File(pickedImage.path);
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingresar datos"),
      ),
      body: BlocProvider(
        create: (context) {
          _createBloc = CreateBloc();
          return _createBloc;
        },
        child: BlocListener<CreateBloc, CreateState>(
          listener: (context, state) {
            if (state is CreatedTweetState) Navigator.of(context).pop();
            // TODO: hacer los demas estados emitidos y que haran.
          },
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(24),
              children: [
                Container(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      CircleAvatar(
                        maxRadius: 84,
                        child: _img != null ? Image.file(_img!) : Container(),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: MediaQuery.of(context).size.width * 0.25,
                        child: CircleAvatar(
                          maxRadius: 24,
                          backgroundColor: Colors.yellow,
                          child: IconButton(
                            tooltip: "Tomar foto",
                            color: Colors.black87,
                            icon: Icon(FontAwesomeIcons.cameraRetro),
                            onPressed: () async {
                              _img = await _getImage();
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text("Titulo"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (currentText) {
                    if (currentText == null || currentText.isEmpty) {
                      return 'Please enter some text';
                    } else {
                      title = currentText;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text("Descripcion"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (currentText) {
                    if (currentText == null || currentText.isEmpty) {
                      return 'Please enter some text';
                    } else {
                      descr = currentText;
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _createBloc.add(SaveAllOnlineEvent(
                        img: _img,
                        tweetData: {
                          "title": title,
                          "descripcion": descr,
                          "osystem": [],
                        },
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      _formKey.currentState!.reset();
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
