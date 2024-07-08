import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants.dart';
import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';
import '../../bloc/auth_bloc/bloc.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/logo_vistony_rojo.png",
                width: 150,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async{
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) => AuthBloc(),
                    child: const LoginScreen(),
                  );
                },
              ),
            );
          },
          child: Text(
            "Inicia Sesión".toUpperCase(),
            style: const TextStyle(color: Colors.white),
          )
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SignUpScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryLightColor,
            elevation: 0,
          ),
          child: Text(
            "Regístrate".toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

}
