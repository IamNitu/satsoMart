import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SignUpEvent{}
class SignupFullnameChanged extends SignUpEvent{
  final String fullname;
  SignupFullnameChanged(this.fullname);
}
class SignupEmailChanged extends SignUpEvent{
   final String email;
  SignupEmailChanged(this.email);
}
class SignupPasswordChanged extends SignUpEvent{
   final String password;
  SignupPasswordChanged(this.password);
}
class SignupConfirmPasswordChanged extends SignUpEvent{
   final String confirmPassword;
  SignupConfirmPasswordChanged(this.confirmPassword);
}

class SignupState{
  final String? fullname;
  final String? email;
  final String? password;
  final String? confirmPassword;
  SignupState({
    this.fullname="",
    this.email="",
    this.password="",
    this.confirmPassword=""
  });

  SignupState copyWith({
   String? fullname,
   String? email,
   String? password,
   String? confirmPassword,
  }){
    return SignupState(
    fullname: fullname ?? this.fullname,
    email: email ?? this.email,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword
  );
  }
}

class SignupBloc extends Bloc<SignUpEvent,SignupState>{
  SignupBloc(): super(SignupState()){
    on<SignupFullnameChanged>((event, emit){
      emit(state.copyWith(fullname: event.fullname));
    });
    on<SignupEmailChanged>((event, emit){
      emit(state.copyWith(email: event.email));
    });
    on<SignupPasswordChanged>((event, emit){
      emit(state.copyWith(password: event.password));
    });
    on<SignupConfirmPasswordChanged>((event, emit){
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });
  }
}