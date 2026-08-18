import 'package:flutter_bloc/flutter_bloc.dart';
// Event
abstract class LoginEvent {}
class LoginEmailChanged extends LoginEvent{
  final String email;
  LoginEmailChanged(this.email);
}
class LoginPasswordChanged extends LoginEvent{
  final String password;
  LoginPasswordChanged(this.password);
}

// Bloc
class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc():super(LoginState()){
    on<LoginEmailChanged>((event,emit){
      emit(state.copyWith(email: event.email));
    });
    on<LoginPasswordChanged>((event,emit){
      emit(state.copyWith(password: event.password));
    });
  }
}

// state
class LoginState{
  final String email;
  final String password;
  LoginState({
    this.email ="",
    this.password=""
  });

  LoginState copyWith({
    String? email,
    String? password
  }){
    return LoginState(
      email: email ?? this.email,
      password: password?? this.password
    );
  }
}