import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sasto_mart/features/authentication/bloc/login_bloc.dart';
import 'package:sasto_mart/features/authentication/bloc/signup_bloc.dart';
import 'package:sasto_mart/features/authentication/views/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName : ".env");
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
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        ),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: MediaQuery.of(context).textScaler.clamp(
                minScaleFactor: 1.0,
                maxScaleFactor: 1.2,
              ),
            ),
            child: child!,
          );
        },
        home: const LoginPage(),
      ),
    );
  }
}