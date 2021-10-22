import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_firebase/auth/user_auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserAuthRepository _userRep = UserAuthRepository();

  LoginBloc() : super(LoginInitial()) {
    on<LoginWithGoogleEvent>(_googleLogin);
  }

  Future _googleLogin(
    LoginEvent event,
    Emitter emitState,
  ) async {
    try {
      await _userRep.signInWithGoogle();
      emitState(LoginSuccessState());
    } catch (e) {
      emitState(
        LoginErrorState(
          error: "Error al hacer login con google",
          code: e.toString(),
        ),
      );
    }
  }
}
