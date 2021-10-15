import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase/auth/user_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserAuthRepository _authRepo = UserAuthRepository();

  AuthBloc() : super(AuthInitial()) {
    // revisar los eventos que llegan al Bloc
    on<VerifyAuthEvent>(_authVerification);
    on<SignOutAuthEvent>(_signOut);
  }

  void _authVerification(
    AuthEvent event,
    Emitter emitState,
  ) {
    if (_authRepo.isAlreadyLogged())
      emitState(AlreadyAuthState());
    else
      emitState(UnAuthState());
  }

  Future<void> _signOut(
    AuthEvent event,
    Emitter emitState,
  ) async {
    if (FirebaseAuth.instance.currentUser!.isAnonymous)
      await _authRepo.signOutFirebase();
    else {
      await _authRepo.signOutFirebase();
      await _authRepo.signOutGoogle();
    }
    emitState(UnAuthState());
  }
}
