part of 'create_bloc.dart';

abstract class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object> get props => [];
}

class SaveAllOnlineEvent extends CreateEvent {
  final File? img;
  final Map<String, dynamic> tweetData;

  SaveAllOnlineEvent({
    required this.img,
    required this.tweetData,
  });

  @override
  List<Object> get props => [tweetData];
}
