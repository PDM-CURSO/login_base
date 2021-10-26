part of 'create_bloc.dart';

abstract class CreateState extends Equatable {
  const CreateState();

  @override
  List<Object> get props => [];
}

class CreateInitial extends CreateState {}

class CreatedTweetState extends CreateState {}

class LoadingState extends CreateState {}

class ErrorTweetState extends CreateState {
  final errorMsg;

  ErrorTweetState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
