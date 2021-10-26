import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(CreateInitial()) {
    on<SaveAllOnlineEvent>((event, emit) async {
      emit(LoadingState());
      bool saved = await _saveTweets(event.tweetData, event.img);
      emit(
        saved
            ? CreatedTweetState()
            : ErrorTweetState(
                errorMsg: "No se pudo guardar los datos, intente despues...",
              ),
      );
    });
  }

  // guardar en firebase datos en Cloud Firestore
  Future<bool> _saveTweets(
    Map<String, dynamic> tweet,
    File? img,
  ) async {
    try {
      // subir los datos a firebase
      // subir la imagen a un bucket de firebase storage
      // extraer link de la imagen

      if (img != null) {
        // subir la imagen al bucket
        String _imageUrl = await _uploadFile(img);
        //actualizar el obj tweet
        if (_imageUrl.isNotEmpty) tweet["picture"] = _imageUrl;
      }

      // guardar en Cloud firestore
      await FirebaseFirestore.instance.collection("tweet").add(tweet);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> _uploadFile(File? selectedPicture) async {
    try {
      var stamp = DateTime.now();
      if (selectedPicture == null) return "";
      // definir una upload task
      UploadTask task = FirebaseStorage.instance
          .ref("tweets/imagen_${stamp}.png")
          .putFile(selectedPicture);
      // ejecutar task de upload
      await task;
      // recuperar la url de la archivo
      return await task.storage
          .ref("tweets/imagen_${stamp}.png")
          .getDownloadURL();
    } catch (e) {
      print(e.toString());
      return "";
    }
  }
}
