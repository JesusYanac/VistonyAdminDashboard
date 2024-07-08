import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/already_have_an_account_acheck.dart';
import '../../../../core/constants.dart';
import '../../../../core/controllers/menu_app_controller.dart';
import '../../../dashboard/bloc/navigation_bloc.dart';
import '../../../dashboard/main_screen.dart';
import '../../../dashboard/trade_marketing/bloc/trade_marketing_bloc.dart';
import '../../Signup/signup_screen.dart';
import '../../bloc/auth_bloc/bloc.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _password = TextEditingController();
    _email = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Usuario",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
            style: const TextStyle(color: kPrimaryColor),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _password,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Contraseña",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              style: const TextStyle(color: kPrimaryColor),
            ),
          ),
          const SizedBox(height: defaultPadding),
          BlocListener<AuthBloc, AuthBlocState>(
            listener: (context, state) {
              if (state is SuccessAuthBlocState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (context) => MenuAppController(),
                          ),
                        ],
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => NavigationBloc(),
                            ),
                            BlocProvider(
                              create: (context) {
                                final bloc = TradeMarketingBloc();
                                bloc.reloadTradeMarketing();
                                return bloc;
                              },
                            )
                          ],
                          child: const MainScreen(),
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is ErrorAuthBlocState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Login Error"),
                  ),
                );
              }
            },
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).triggerAuthLogin(_email.text, _password.text);
              },
              child: Text(
                "Inicia Sesión".toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
