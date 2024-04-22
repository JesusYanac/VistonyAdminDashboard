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


class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
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
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
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
                            create: (context){
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
            },
            child: Text(
              "Inicia Sesión".toUpperCase(),
              style: const TextStyle(color: Colors.white),
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
