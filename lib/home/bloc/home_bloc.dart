import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _cFirestore = FirebaseFirestore.instance;

  HomeBloc() : super(HomeInitial()) {
    on<RequestDataEvent>(_onRequestData);
  }

  // on data request
  void _onRequestData(HomeEvent event, Emitter emitState) async {
    emitState(LoadingState());
    var tweetList = await _getTweets();
    if (tweetList == null)
      emitState(NoDataState());
    else
      emitState(ExistingDataState(tweetsList: tweetList));
  }

  Future<List<Map<String, dynamic>>?> _getTweets() async {
    try {
      var tweets = await _cFirestore.collection("tweet").get();
      return tweets.docs
          .map(
            (tweetDocument) => {
              "titulo": tweetDocument["title"],
              "descr": tweetDocument["description"],
              "img": tweetDocument["picture"],
              "osys": tweetDocument["osystem"],
            },
          )
          .toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
