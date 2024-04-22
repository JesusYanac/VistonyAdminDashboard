import 'package:flutter/material.dart';

import 'presentation/core/constants.dart';
import 'presentation/features/auth/Welcome/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vistony Admin Panel',

      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: bgColor,
          //scaffoldBackgroundColor: const Color.fromRGBO(43, 43, 43, 1),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              //foregroundColor: const Color.fromRGBO(43, 43, 43, 1),
              foregroundColor: bgColor,
              backgroundColor: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: kPrimaryLightColor),
          bodyMedium: TextStyle(color: kPrimaryLightColor),
          bodySmall: TextStyle(color: kPrimaryLightColor),
          titleLarge: TextStyle(color: kPrimaryLightColor),
          titleMedium: TextStyle(color: kPrimaryLightColor),
          // default style
          titleSmall: TextStyle(color: kPrimaryLightColor),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
