import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sasto_mart/features/authentication/bloc/login_bloc.dart';
import 'package:sasto_mart/features/authentication/bloc/signup_bloc.dart';
import 'package:sasto_mart/features/authentication/views/login_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> LoginBloc()),
        BlocProvider(create: (context)=>SignupBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage()
      ),
    );
  }
}