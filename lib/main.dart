import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:newsindia/Auth/bloc/AuthBloc.dart';
import 'package:newsindia/Widgets/LoginScreen.dart';
import 'package:newsindia/Widgets/MainScreen.dart';
import 'package:newsindia/hive/bloc/HiveBloc.dart';
import 'package:newsindia/news/Tools/catogory.dart';
import 'package:newsindia/news/bloc/NewsBloc.dart';
import 'package:newsindia/news/widgets/newsBox.dart';
import 'package:newsindia/theme/bloc/themeBloc.dart';

import 'Auth/models/USer.dart';
import 'Widgets/HomePage.dart';
import 'news/Tools/model.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(NewsSourceAdapter());

  final box = await Hive.openBox('userBox');
  final isLoggedIn = box.get('isLoggedIn') ?? false;
  final storedUser = box.get('user') as User?;

  final AuthBloc authBloc = AuthBloc(); // ✅ Create one instance
  log("In main the current values are $isLoggedIn and ${storedUser.runtimeType}");

  if (isLoggedIn && storedUser != null) {
    authBloc.add(Pushlogin(user: storedUser)); // ✅ Send login to the same instance
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => NewsBloc()),
        BlocProvider(create: (context) => authBloc), // ✅ Use the same instance
        BlocProvider(create: (context) => HiveBloc(authBloc: authBloc)),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
   MyApp({super.key});
  final ThemeData blueWhiteTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF007BFF),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF007BFF),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF007BFF),
      secondary: Color(0xFFD6EFFF),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(color: Color(0xFF003E7E), fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
  );
   final ThemeData blueDarkTheme = ThemeData(
     brightness: Brightness.dark,
     primaryColor: Color(0xFF007BFF),
     scaffoldBackgroundColor: Color(0xFF121212),
     appBarTheme: AppBarTheme(
       backgroundColor: Color(0xFF003E7E),
       foregroundColor: Colors.white,
       elevation: 0,
     ),
     colorScheme: ColorScheme.dark(
       primary: Color(0xFF007BFF),
       secondary: Color(0xFF1E3A5F),
       surface: Color(0xFF1C1C1E),
       onPrimary: Colors.white,
       onSecondary: Colors.white70,
     ),
     textTheme: TextTheme(
       titleLarge: TextStyle(color: Color(0xFFD6EFFF), fontWeight: FontWeight.bold),
       bodyMedium: TextStyle(color: Colors.white70),
     ),
   );

   @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          title: 'Flutter News App',
          theme: theme,
          // darkTheme: blueDarkTheme,
          themeMode: ThemeMode.system,
          home: BlocBuilder<AuthBloc,AuthState>(builder: (context, state) {
            if(state is LoggedIN){
              return MainScreen();
            }
            // else if(state is AuthLoading){
            //   return Center(child: SpinKitThreeBounce(color: Colors.blue,),);
            // }
            log(state.toString());
            return const Loginscreen();
          },),
        );
      },
    );
  }
}

